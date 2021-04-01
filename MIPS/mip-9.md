---
mip: 9
title: Feeder Pools
status: Proposed
author: Alex Scott (@alsco77), Onur Solmaz <onur@mstable.org>
discussions-to: https://forum.mstable.org/t/mip-9-feeder-pools/410
created: 2021-03-15
---

## Simple Summary

Following the deployment of [MIP-7](./mip-7), it’s possible to extend the mAssets by creating "Feeder pools" composed of 50% fAsset and 50% mAsset. These Feeder Pools (fPools) provide important benefits to mAssets by:

- Free `fAsset` -> `mAsset` swaps (effectively allowing users to 'mint' mAssets with any fAsset)
- Leveraging the `mAsset` SAVE rate by providing a source of demand for mAssets from within mStable (thus increasing mAsset SAVE APY)
- Feed swap fees back into the `mAsset` by supporting trades between fAsset <-> mAsset bAssets

This MIP outlines the implementation details for fPools and proposes that mStable actively deploy these to stimulate growth and mAsset utility.

## Abstract

fPools maintain the bulk of functionality from mAssets:

- Same interface for Mint/Swap/Redeem
- Protected through max weights
- Ability to deploy fAsset/mAsset onto third party lending platforms to generate yield
- Governed by vMTA holders
- Ability to enable a governance fee, which extracts a % of total pool revenue

There are a number of core differences between fPools and mAsset pools

1. fPools support mint/swap/redeem using assets within the mAsset basket in addition to it's own basket
1. fPools produce LP tokens that increase in value, rather than inflate supply
1. Swaps into mAsset do not apply a fee
1. fPools are always composed of 50/50 fAsset/mAsset, and use an invariant derived specifically for 2 assets
1. fPools are not protected by MTA in the event of an underlying asset losing it's peg

Incentivising liquidity on these pools will provide on/off ramps, generate swap volume and leverage mAssets SAVE utilisation rate - thus making them ideal options for MTA rewards. Additionally, it provides another place for projects to incentivise their own asset liquidity and benefit from MTA token emission.

## Specification

### Overview

For feeder pools, we introduce a new invariant for 2-asset stablecoin AMMs that shows similar properties as Stableswap, but can be solved with less number of operations. The implicit invariant equation follows as

\\[
\frac{Ak}{x + y} + \frac{k^2}{4xy} = A + 1\,.
\\]

Here, \\(x\\) and \\(y\\) are asset reserves, \\(k\\) is the invariant and \\(A\\) is an amplification coefficient.
The equation is quadratic in terms of \\(k\\), making it easier to compute the invariant value. This invariant results in a bonding curve that is very similar to Stableswap, when the amplification coefficient is 4 times that of Stableswap's.

![Price curve](/assets/MIP-9/feeder_pool_invariant1.svg)

Note that the `A` parameter used in existing Stableswap contracts actually corresponds to \\(An^{n-1}\\) ---we consider the original definition of \\(A\\) from the Stableswap invariant.

By contributing liquidity to a Feeder Pool, the user will receive:

- Swap fees into the bAsset specific to that feeder basket
- Interest from lending out Feeder basket bAssets, including the mAsset trading pair
- Possible liquidity rewards from project’s that wish to incentivise their stablecoin on mStable
- MTA rewards

### Rationale

> fPools are not protected by MTA in the event of an underlying asset losing it's peg

Feeder pools "feed" value into mAssets and the wider mStable system, thus they should not receive protection from MTA.
In fact, in the future it may be proposed that all feeder pools can be converted into insurance pools, from which mAssets can be protected.
This would involve using the feeder pool assets as a backup of last resort in the event of catastrophic failure in the mAsset pool.

> Value accruing LP token vs inflation

In order to reduce the steps needed to become an active LP, it is decided that the feeder pools will use the standard value accruing LP
token.

> Router for cross pool swaps vs localised

Swapping from the fPool to the mAsset pool (e.g. fAsset -> mpAsset) requires 2 steps. The complexity increases massively for multiMint and multiRedeem,
and so it was decided that mint/swap/redeem would be able to communicate cross pool, and a seperate `FeederRouter` would be developed in order to
facilitate more complex trade paths (e.g. mintMulti and cross-feeder pool swaps).

> Swaps into mAsset do not apply a fee

In order to maximise utility for mAssets, it is decided that trades from fAsset to mAsset will have 0 fee. This trade path can be presented to the end
user as `minting` an mAsset.

> fPools are always composed of 50/50 fAsset/mAsset, and use an invariant derived specifically for 2 assets

It makes sense to optimise the invariant for 2 dimensions rather than use an iterative solution for an `n` dimensional surface.

## Technical Specification

### Computing the invariant for given reserve values

The invariant equation is quadratic in terms of \\(k\\), and is solved as

\\[
k(x, y) = 2 \left(\sqrt{c_1^2 + (A+1)xy} - c_1\right)
\\]

where \\(c_1 = Axy/(x+y)\\).

Below is a pseudocode for computing \\(k\\):

```python
def compute_k(x: int, y: int, A: int):
    prod = x * y
    c1 = A * prod // (x + y)
    result = 2 * (sqrt(c1**2 + (A + 1) * prod) - c1)
    return result
```

where `sqrt()` is an optimized integer square root function.

### Computing a reserve given other reserve and invariant

Reserve value \\(y\\) is computed similarly, by solving the invariant equation for \\(y\\):

\\[
y(x, k) = \frac{1}{2}\left(\sqrt{c_3^2+c_2} + c_3\right)
\\]

where

\\[c_2=\frac{k^2}{A+1} \quad\text{and}\quad c_3=\frac{c_2}{4x} + \frac{Ak}{A+1} - x.\\]

Below is a pseudocode for computing \\(y\\):

```python
def compute_y(x: int, k: int, A: int):
    Aplus1 = A + 1
    c2 = k**2 // Aplus1
    # Account for negative c_3
    dummy1 = c2 // (4 * x) + k * A // Aplus1
    if dummy1 >= x:
        dummy2 = dummy1 - x
    else:
        dummy2 = x - dummy1
    result = (sqrt(dummy2**2 + c2) + dummy1 - x) // 2
    return result
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

The amount of LP tokens received for adding a certain amount of pool asset is computed as

```python
def compute_mint(i: int, quantity: int):
    """Compute the amount LP token received for minting
    with `quantity` amount of asset index `i`."""

    x = get_current_reserves()
    lp_supply = get_supply() # LP token supply
    A = get_A()
    k_init = compute_k(x[0], x[1], A)
    x[i] += quantity
    k_final = compute_k(x[0], x[1], A)

    if lp_supply == 0:
        total_minted = k_final - k_init
    else:
        total_minted = lp_supply * (k_final - k_init) // k_init

    if not in_bounds(x):
        raise Exception("Mint not allowed")

    return total_minted
```

### Compute redeem output

The amount of assets received for redeeming a certain amount of LP tokens is computed as

```python
def compute_redeem(i: int, quantity: int):
    """Compute the amount of asset index `i` received for
    redeeming `quantity` amount of LP token."""

    if i == 0:
        j = 1
    elif i == 1:
        j = 0

    redemption_fee = quantity * swap_fee_rate // FULL_SCALE
    deducted_quantity = quantity - redemption_fee

    x = get_current_reserves()
    lp_supply = get_supply() # LP token supply
    A = get_A()
    k_init = compute_k(x[0], x[1], A)
    k_final = k_init * (lp_supply - deducted_quantity) // lp_supply
    new_reserve = compute_y(x[j], k_final, A)
    total_received = x[i] - new_reserve
    x[i] = new_reserve

    if not in_bounds(x):
        raise Exception("Redeem not allowed")

    return total_received, redemption_fee
```

### Compute swap output

The output of swapping a certain amount of an asset for another one is computed as

```python
def compute_swap(input_idx: int, output_idx: int, quantity: int):
    """Compute the amount of asset received for swapping
    `quantity` amount of index `input_idx` to index `output_idx`."""

    x = get_current_reserves()
    lp_supply = get_supply() # LP token supply
    A = get_A()
    k1 = compute_k(x[0], x[1], A)
    x[input_idx] += quantity
    k2 = compute_k(x[0], x[1], A)
    total_minted = k2 - k1
    swap_fee = total_minted * swap_fee_rate // FULL_SCALE
    deducted_quantity = total_minted - swap_fee
    swap_fee = swap_fee * lp_supply // k1
    k3 = k2 - deducted_quantity
    new_reserve = compute_y(x[input_idx], k3, A)
    total_received = x[output_idx] - new_reserve
    x[output_idx] = new_reserve

    if not in_bounds(x):
        raise Exception("Swap not allowed")

    return total_received, swap_fee
```

### Configurable Values (Via MCCP)

Each bAsset has the following configurable values:

- `hard_min`
- `hard_max`
- `A`
- `governance fee`
- `swap fee`
- `redemption fee`
- `cache size`

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
