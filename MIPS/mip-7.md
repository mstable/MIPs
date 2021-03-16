---
mip: 7
title: mAsset AMM Upgrade
status: Implemented
author: Onur Solmaz <onur@mstable.org>
discussions-to: https://forum.mstable.org/t/mip-7-masset-amm-with-feeders/344
created: 2020-02-09
---

## Simple Summary

A new mAsset, mBTC, is created, which unites various Bitcoin-backed ERC20 tokens. Mints, redeems and swaps with bAssets are not 1:1, and instead determined by a new [AMM](https://arxiv.org/abs/2003.10001)-based design.

## Abstract

We propose a new mAsset type where mint, redeem and swap prices are not always 1:1 and instead determined by the StableSwap invariant. There are lower and upper hard limits for bAsset weights, denoted as `hard_min` and `hard_max` respectively. Weights can never move beyond the hard limits, imposing limits on how much bAsset reserves can be drained.

## Motivation

The AMM design used for mUSD, the first mAsset, is called the Constant Sum Market Maker, with the invariant \\(\sum_i x_i = k\\). With the CSMM, bAssets can be minted, redeemed and swapped 1:1. However, this design introduces a number shortcomings, namely:

- **Drained bAssets:** Expensive bAssets are fully drained from the basket and cheaper bAssets fill it up as much as they can.
- **Restricted liquidity:** Not being able to swap with all bAssets limits the swap opportunities.
- **Reduced composability:** Not being able to mint or redeem with every bAsset hinders composability with other DeFi projects.

Since the community have voiced these above concerns, the development team have been working on possible solutions. One such solution was described in [MIP-6](https://mips.mstable.org/MIPS/mip-6.html). There were various design goals the development team wanted to achieve while we tackle the problems as described in MIP-6:

- Be able to flexibly target specific bAsset weights (i.e. max weights and minimum weights)
- Make mAssets more composable
- Guarantee a minimum amount of liquidity
- Increase swap volume

## Specification

### Overview

The StableSwap invariant was previously introduced by [Curve](https://www.curve.fi/) [here](https://www.curve.fi/stableswap-paper.pdf) as

\\[
An^n \sum_i x_i + k = An^nk + \frac{k^{n+1}}{n^n\prod_i x_i}
\\]

On top of this formulation, we further restrict the movement of reserve values \\(x_i\\), such that weights \\(x_i/\sum_i x_i\\) remain between `hard_min` and `hard_max` after all user actions.

Furthermore, we deduct and accrue fees natively to the mAsset, and also bake in accounting for system yield generated from lending platforms. We mint more mAsset with the fees collected from swaps and redemptions. This allows us to keep a stable mAsset value, instead of making it appreciate with revenue. Thus, the supply of mAsset is always made to be equal to \\(k\\) from the equation above.

### Rationale

There were various design goals we wanted to achieve while we tackle the problems described in Motivation:

- Be able to flexibly target specific bAsset weights.
- Make mAssets more composable.
- Guarantee a minimum amount of liquidity.
- Increase swap volume.

We came to the conclusion that the most logical solution to our problems was to introduce an invariant-based model to mAssets, effectively turning them into AMMs that work within the bounds defined by hard limits.

## Technical Specification

In this section, we outline the algorithms used in computing output amounts in Python 3-like pseudocode. The variable `FULL_SCALE` is a big number, e.g. 1e18, that we use to set the precision of integer operations. For more information, check out the [existing math implementation in mStable repositories](https://github.com/mstable/mStable-contracts/blob/db20930cc2553e6854c9d39d219538d55cbd034d/contracts/shared/StableMath.sol).

### Computing mAsset supply for given reserve values

The mAsset supply is computed as

```python
def compute_masset_supply(reserves, A):
    "Use Newton's method to compute the mAsset supply"
    n = len(reserves)
    S = sum(reserves)
    Ann = A * n ** n
    k_prev = 0
    k = S
    while abs(k - k_prev) > 1:
        k_P = k
        for x in reserves:
            k_P = k_P * k // (n * x)
        k_prev = k
        k = (Ann * S + k_P * n) * k // ((Ann - 1) * k + (n + 1) * k_P)
    return k
```

We outline the derivation as follows. First, we define a residual function from the invariant:

\\[r(x, k) = An^n \sum_i x_i + k - An^nk - \frac{k^{n+1}}{n^n\prod_i x_i}. \\]

Then, its derivative with respect to \\(k\\) is computed as

\\[
\frac{\partial r}{\partial k} =
1 - An^n - \frac{(n+1) k^n}{n^n\prod_i x_i}.
\\]

Applying [Newton’s method](https://en.wikipedia.org/wiki/Newton%27s_method) to solve for \\(k\\), we substitute these into

\\[
k_{i+1} = k_i - \frac{r(x, k_i)}{\dfrac{\partial r}{\partial k}\bigg|_{x,k_i}}.
\\]

Working out the steps, we finally arrive at

\\[
k_{i+1} = k_i\frac{A n^n \sum_i x_i + \frac{k_i^{n+1}}{n^{n-1}\prod_i x_i}}{k_i(An^n -1) + \frac{(n+1)k_i^{n+1}}{n^{n}\prod_i x_i}}
\\]

which has been optimized for fast convergence with integer arithmetic.

### Computing a reserve value given other reserve values and mAsset supply

Another important goal is to solve for a certain reserve value \\(x\*i\\) when all the other reserve values \\(\\{x_j\\}\*{j \neq i}\\) and mAsset supply \\(k\\) are known.

```python
def compute_reserve(reserves, A, i, k):
    "Compute the reserve value of i given other reserves and k"
    n = len(reserves)
    Ann = A * n ** n

    S = 0
    k_P = k
    for j, x in enumerate(reserves):
        if j == i: continue
        k_P = k_P * k // (x * n)
        S += x

    c = k_P * k // (Ann * n)
    g = k * (Ann - 1) // Ann

    if g > S:
        b = g - S
        x = (sqrt(b**2 + 4 * c) + b) // 2
    else:
        b = S - g
        x = (sqrt(b**2 + 4 * c) - b) // 2

    return x
```

In obtaining the numerical solution scheme, the first step is to multiply the invariant with \\(x_i\\) and divide by \\(An^n\\). We then simplify the equation as:

\\[
x_i^2 + \underbrace{\left(\sum_{j\neq i}x_j-k+\frac{k}{An^n}\right)}_{b} x_i =
\underbrace{\frac{k^{n+1}}{An^{2n}\prod\_{j\neq i}x\_j}}\_{c}
\\]

This is a quadratic equation \\(x_i^2 + bx_i = c\\) with constant terms \\(b\\) and \\(c\\). Differently than Curve, we do not solve this equation iteratively in `compute_reserve`, but utilize an optimized integer square root function.

\\[
x_i = \frac{\sqrt{b^2 + 4c} - b}{2}
\\]

This has shown to save roughly 5k gas, compared to the iterative solution for large basket sizes.

### Checking whether the reserve change is allowed

User actions will modify reserves in a certain way, and we need to check after each action whether the final values are within the allowed range.

```python
def in_bounds(x: List[int]):
    sum_ = sum(x)
    for i in range(n_basset):
        w = FULL_SCALE * x[i] // sum_
        if not (penalty[i].hard_min <= w and w <= penalty[i].hard_max):
            return False
    return True
```

### Computing mint output

The amount of mAsset received for minting with a certain amount of bAsset is computed as

```python
def compute_mint(i: int, quantity: int):
    """Compute the amount of mAsset received for minting
    with `quantity` amount of bAsset index `i`."""

    x = get_current_reserves()
    A = get_A()
    k_init = compute_masset_supply(x, A)
    x[i] += quantity
    k_final = compute_masset_supply(x, A)
    total_minted = k_final - k_init

    if not in_bounds(x):
        raise Exception("Mint not allowed")

    return total_minted
```

### Compute redeem output

The amount of bAsset received for redeeming a certain amount of mAsset is computed as

```python
def compute_redeem(i: int, quantity: int):
    """Compute the amount of bAsset index `i` received for
    redeeming `quantity` amount of mAsset."""

    redemption_fee = quantity * swap_fee_rate // FULL_SCALE
    deducted_quantity = quantity - redemption_fee

    x = get_current_reserves()
    A = get_A()
    k_init = compute_masset_supply(x, A)
    k_final = k_init - deducted_quantity
    new_reserve = compute_reserve(x, A, i, k_final)
    total_received = x[i] - new_reserve
    x[i] = new_reserve

    if not in_bounds(x):
        raise Exception("Redeem not allowed")

    return total_received
```

### Compute swap output

The output of swapping a certain amount of a bAsset to another one is computed as

```python
def compute_swap(input_idx: int, output_idx: int, quantity: int):
    """Compute the amount of bAsset received for swapping
    `quantity` amount of index `input_idx` to index `output_idx`."""

    x = get_current_reserves()
    A = get_A()
    k1 = compute_masset_supply(x, A)
    x[input_idx] += quantity
    k2 = compute_masset_supply(x, A)
    total_minted = k2 - k1
    swap_fee = total_minted * swap_fee_rate // FULL_SCALE
    deducted_quantity = total_minted - swap_fee
    k3 = k2 - deducted_quantity
    new_reserve = compute_reserve(x, A, output_idx, k3)
    total_received = x[output_idx] - new_reserve
    x[output_idx] = new_reserve

    if not in_bounds(x):
        raise Exception("Swap not allowed")

    return total_received
```

### Configurable Values (Via MCCP)

Each bAsset has the following configurable values:

- `hard_min`
- `hard_max`
- `A`

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
