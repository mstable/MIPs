---
mip: 9
title: Feeder Pools
status: Proposed
author: Alex Scott (@alsco77),  Onur Solmaz <onur@mstable.org>
discussions-to: https://forum.mstable.org/t/
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

Incentivising liquidity on these pools will provide on/off ramps, generate swap volume and leverage mAssets SAVE utilisation rate - thus making them ideal options for MTA rewards.

## Motivation

<!-- Alex -->

<!-- Feeder baskets as mAsset internal insurance primitive:

Feeder baskets could be used as a primitive to secure mAssets in the event of one of the stablecoins in the mAsset basket failing. This is because in the event of one of the mAsset basket’s bAsset’s failing, the value of that mAsset would logically fall. Traders would then trade out of the mAsset and into the opposing pegged asset in each feeder basket, effectively filling up each feeder basket with that mAsset. -->

## Specification

### Overview

<!-- Onur Invariant -->

<!-- Alex description -->

<!-- By contributing liquidity to a feeder basket, the user will receive:

Swap fees into the bAsset specific to that feeder basket
Interest from lending out Feeder basket bAssets, including the mAsset trading pair
Possible liquidity rewards from project’s that wish to incentivise their stablecoin on mStable
MTA rewards from locking the LP token into the insurance pool (see above) -->

### Rationale

<!-- Alex -->

## Technical Specification

<!-- Onur Invariant derivation adn spec -->

### Computing mAsset supply for given reserve values

<!-- Onur Invariant derivation adn spec -->

### Computing a reserve value given other reserve values and mAsset supply

<!-- Onur Invariant derivation adn spec -->

### Checking whether the reserve change is allowed

<!-- Same as MIP7 -->

### Computing mint output

<!-- Same as MIP7 -->

### Compute redeem output

<!-- Same as MIP7 -->

### Compute swap output

<!-- Same as MIP7 -->

### Configurable Values (Via MCCP)

Each bAsset has the following configurable values:

- `hard_min`
- `hard_max`
- `A`

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
