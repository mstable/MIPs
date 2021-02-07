---
mip: 6
title: Bitcoin mAsset (mBTC) and new AMM-based design
status: Approved
author: Onur Solmaz <onur@mstable.org>
discussions-to: https://forum.mstable.org/t/mip-6-bitcoin-masset-mbtc-and-new-amm-based-design/277
created: 2020-12-07
---

## Simple Summary

<!--"If you can't explain it simply, you don't understand it well enough." Simply describe the outcome the proposed changes intends to achieve. This should be non-technical and accessible to a casual community member.-->

A new mAsset, mBTC, is created, which unites various Bitcoin-backed ERC20 tokens. Mints, redeems and swaps with bAssets are not 1:1, and instead determined by a new [AMM](https://arxiv.org/abs/2003.10001)-based design.

## Abstract

<!--A short (~200 word) description of the proposed change, the abstract should clearly describe the proposed change. This is what *will* be done if the MIP is implemented, not *why* it should be done or *how* it will be done. If the MIP proposes deploying a new contract, write, "we propose to deploy a new contract that will do x".-->

We propose a new mAsset, mBTC. Similar to mUSD, mBTC will be a derivative of BTC-backed assets, most likely [wBTC](https://wbtc.network/), [renBTC](https://renproject.io/) and [sBTC](https://www.synthetix.io/) at launch. However, unlike mUSD, mints, redeems and swaps will not always be 1:1, depending on the relative weights of the bAssets (underlying assets). Instead, mBTC will feature the first ever implementation of our new AMM design, the _Incentivized Constant Sum Market Maker_, or ICSMM for short. In the new design, there are upper and lower soft and hard limits for bAsset weights, which are generally ordered in ascending order as [`0%`,`hard_min`,`soft_min`,`soft_max`,`hard_max`,`100%`]. When all bAsset weights are in the 1:1 region, that is, between `soft_min` and `soft_max`, users can mint, redeem and swap 1:1. If a user action pushes weights beyond this region, increasing disincentives are applied to prevent further movement. Similarly, if a user action brings weights back into the 1:1 region, an incentive is applied. These incentives are computed by penalty functions for each bAsset, which themselves are combined under a single invariant per the usual AMM formulation. Finally, weights can never move beyond the hard limits, imposing limits on how much bAsset reserves can be drained.

## Motivation

<!--This is the problem statement. This is the *why* of the MIP. It should clearly explain *why* the current state of the protocol is inadequate.  It is critical that you explain *why* the change is needed, if the MIP proposes changing how something is calculated, you must address *why* the current calculation is innaccurate or wrong. This is not the place to describe how the MIP will address the issue!-->

The AMM design used for mUSD, the first mAsset, is called the Constant Sum Market Maker, with the invariant \\(\sum_i x_i = k\\). With the CSMM, bAssets can be minted, redeemed and swapped 1:1. However, this design introduces a number shortcomings, namely:

- **Drained bAssets:** Expensive bAssets are fully drained from the basket and cheaper bAssets fill it up as much as they can.
- **Restricted liquidity:** Not being able to swap with all bAssets limits the swap opportunities.
- **Reduced composability:** Not being able to mint or redeem with every bAsset hinders composability with other DeFi projects.

These problems were apparent even before the launch of mUSD v1. Because the system caps risk on individual assets, mUSD was launched with maximum with maximum weight limits of 55%.

We designed the ICSMM to deal with the shortcomings of CSMM. By introducing incentives, we not only solve all of the aforementioned problems, but also turn mAssets into fully functional AMMs, on par with other projects such as [Curve Finance](https://curve.fi) or [Shell Protocol](https://shellprotocol.io/).

## Specification

<!--The specification should describe the syntax and semantics of any new feature, there are five sections
1. Overview
2. Rationale
3. Technical Specification
4. Test Cases
5. Configurable Values
-->

### Overview

<!--This is a high level overview of *how* the MIP will solve the problem. The overview should clearly describe how the new feature will be implemented.-->

As mentioned before, the CSMM invariant is simply the sum of all bAsset reserves:

\\[
\sum_i x_i = k
\\]

To obtain the ICSMM invariant, we multiply each reserve value with a "penalty term"

\\[
\sum_i x_i \left(1 - \pi_i\left(\frac{x_i}{\sum_j x_j}\right)\right) = k
\\]

where \\(\pi_i\\) are the _penalty functions_ for each bAsset \\(i\\). These are functions of weight, and we will construct these to suit our needs from the AMM. Our main design criterion: they should yield 0 in the "target weight range", defined by soft minimum (`soft_min`) and maximum values (`soft_max`), but should otherwise increase with increased distance from `soft_min` or `soft_max`. When every weight is in `[soft_min, soft_max]`, our invariant becomes equal to the CSMM. This is the 1:1 region we mentioned in the abstract.

The weights are allowed to move in a "wiggle room" below `soft_min` and above `soft_max`, capped by `hard_min` and `hard_max` values respectively. In other words, weights are not allowed to go below `hard_min` or above `hard_max`. The lower the weight of a bAsset, the higher its price in the AMM relative to others. The higher the weight of of a bAsset, the lower its price in the AMM relative to others.

In AMM formulation, prices are obtained by taking the derivative of of the invariant function

\\[
\frac{\partial f}{\partial x_i} = 1 -
\pi_i(w_i)-
w_i(1-w_i) \pi_i'(w_i) +
\sum_{j\neq i}w_j^2\pi_j'(w_j)
=: p_i(w)
\\]

where \\(f(x)\\) is the left-hand side of the invariant and weights are defined as \\(w_i=x_i/\sum_j x\\). Note the price expression is independent of total bAsset reserves. Since they are only functions of weights \\(w = (w_1, \dots, w_n)\\), we denote them as \\(p_i(w)\\). We also note that our invariant is _liquidity insensitive_, that is, it yields the same prices at the same weights, regardless of the total amount of liquidity in the AMM. We think that this property is important for a basket of stablecoins.

We want the penalty functions to be easy to compute on chain. To this end, we define them for each bAsset \\(i\\) as

\\[
\pi_i(w) =
\begin{cases}
\pi_{\min,i} \left(\dfrac{w - s_{\min,i}}{h_{\min,i} - s_{\min,i}}\right)^{a_{\min,i}} & h_{\min,i} < w < s_{\min,i} \\\\\\
0 & s_{\min,i} \leq w \leq s_{\max,i} \\\\\\
\pi_{\max,i} \left(\dfrac{w - s_{\max,i}}{h_{\max,i} - s_{\max,i}}\right)^{a_{\max,i}} & s_{\max,i} < w < h_{\max,i}
\end{cases}
\\]

where \\(h*{\min,i}\\) is the hard minimum, \\(s*{\min,i}\\) is the soft minimum, \\(\pi*{\min,i}\\) is the value of the function at the hard minimum, \\( a*{\min,i} \in \mathbb{Z}\_{>0} \\) is the convexity parameter of the weight floor, \\(h*{\max,i}\\) is the hard maximum, \\(s*{\max,i}\\) is the soft maximum, \\(\pi*{\max,i}\\) is the value of the function at the hard maximum, and \\(a*{\max,i} \in \mathbb{Z}\_{>0}\\) is the convexity parameter of the weight ceiling.

### Rationale

<!--This is where you explain the reasoning behind how you propose to solve the problem. Why did you propose to implement the change in this way, what were the considerations and trade-offs. The rationale fleshes out what motivated the design and why particular design decisions were made. It should describe alternate designs that were considered and related work. The rationale may also provide evidence of consensus within the community, and should discuss important objections or concerns raised during discussion.-->

There were various design goals we wanted to achieve while we tackle the problems described in Motivation:

- Be able to flexibly target specific bAsset weights.
- Make mAssets more composable.
- Guarantee a minimum amount of liquidity.
- Increase swap volume.

We came to the conclusion that the most logical solution to our problems was to introduce an invariant-based model to mAssets, effectively turning them into AMMs that work within the bounds defined by hard limits.

## Technical Specification

<!--The technical specification should outline the public API of the changes proposed. That is, changes to any of the interfaces mStable currently exposes or the creations of new ones.-->

In this section, we outline the algorithms used in computing output amounts in Python 3-like pseudocode. The variable `FULL_SCALE` is a big number, e.g. 1e18, that we use to set the precision of integer operations. For more information, check out the [existing math implementation in mStable repositories](https://github.com/mstable/mStable-contracts/blob/db20930cc2553e6854c9d39d219538d55cbd034d/contracts/shared/StableMath.sol).

### Computing the penalty function and its derivative

The penalty function is computed as

```python
def pi(w: int):
    "Evaluate the penalty function at weight `w`"
    result = 0
    if w < soft_min:
        result += (
            floor_penalty
            * (w - soft_min) ** floor_exponent
            // (hard_min - soft_min) ** floor_exponent
        )
    elif soft_max < w:
        result = (
            ceiling_penalty
            * (w - soft_max) ** ceiling_exponent
            // (hard_max - soft_max) ** ceiling_exponent
        )
    return result
```

The derivative of the penalty function is computed as

```python
def dpidw(w: int):
    "Evaluate the derivative of the penalty function at weight `w`"
    result = 0
    if w < soft_min:
        result += (
            FULL_SCALE
            * floor_penalty
            * floor_exponent
            * (w - soft_min)
            ** (floor_exponent - 1)
            // (hard_min - soft_min)
            ** floor_exponent
        )
    elif soft_max < w:
        result += (
            FULL_SCALE
            * ceiling_penalty
            * ceiling_exponent
            * (w - soft_max)
            ** (ceiling_exponent - 1)
            // (hard_max - soft_max)
            ** ceiling_exponent
        )
    return result
```

### Computing the invariant and its derivative

The invariant is computed as

```python
def invariant(x: List[int]):
    """Compute the invariant f(x) for a given array of supplies `x`.
    `penalty[]` is an array of objects for each bAsset, which can
    compute the penalty function `pi(w)` and its derivative `dpidw(w)`."""
    result = 0
    sum_ = sum(x)

    for i in range(n_basset):
        w = FULL_SCALE * x[i] // sum_
        result += x[i] * (FULL_SCALE - penalty[i].pi(w))

    result = result // FULL_SCALE
    return result
```

On the other hand, its derivative is computed for a given array of weights as

```python
def invariant_deriv_weights(w: List[int], i: int):
    """Compute the derivative of the invariant df/dx_i with respect
    to the bAsset index `i` for an array of weights `w`."""
    result = FULL_SCALE
    result -= penalty[i].pi(w[i])
    result -= (
        w[i] * (FULL_SCALE - w[i])
        * penalty[i].dpidw(w[i]) // FULL_SCALE**2
    )

    for j, p in enumerate(penalty_functions):
        if j == i: continue
        result += w[j] * w[j] \
            * penalty[j].dpidw(w[j]) // FULL_SCALE**2

    return result
```

Additionally, we have the function that computes the derivative for given reserves, wrapping the function we have given above

```python
def invariant_deriv(x: List[int], i: int):
    w = [FULL_SCALE * x_j // sum(x) for x_j in x]
    return eval_deriv_weights(w, i)
```

### Solving the invariant equation

We use [Newton's method](https://en.wikipedia.org/wiki/Newton%27s_method) to solve for a reserve value, given a mAsset supply (right-hand side of the invariant equation, \\(k\\))

```python
def solve_invariant(x: List[int], rhs: int, i: int, max_iter=25):
    x_i = x[i]
    tol = 2 * rhs // FULL_SCALE

    for n_iter in range(max_iter):
        res = invariant(x) - rhs
        deriv = invariant_deriv(x, i)
        x_i = x_i - (res * FULL_SCALE) // deriv
        x[i] = x_i

        if abs(res) <= tol:
            return x_i

    raise Exception("Solution did not converge in %d iterations"%max_iter)
```

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
    k_init = invariant(x)
    x[i] += quantity
    k_final = invariant(x)
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
    k_init = invariant(x)
    k_final = k_init - deducted_quantity
    new_reserve = solve_invariant(x, k_final, i)
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
    k1 = invariant(x)
    x[input_idx] += quantity
    k2 = invariant(x)
    total_minted = k2 - k1
    swap_fee = total_minted * swap_fee_rate // FULL_SCALE
    deducted_quantity = total_minted - swap_fee
    k3 = k2 - deducted_quantity
    new_reserve = solve_invariant(x, k3, output_idx)
    total_received = x[output_idx] - new_reserve
    x[output_idx] = new_reserve

    if not in_bounds(x):
        raise Exception("Swap not allowed")

    return total_received
```

<!--
### Test Cases

- Optimal parameters.
- Plot and rendering of an example bonding curve (2d) and surface (3d).
-->

### Configurable Values (Via MCCP)

<!--Please list all values configurable via MCCP under this implementation.-->

Each bAsset has the following configurable values:

- `soft_min`
- `hard_min`
- `floor_penalty`
- `floor_exponent`
- `soft_max`
- `hard_max`
- `ceiling_penalty`
- `ceiling_exponent`

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
