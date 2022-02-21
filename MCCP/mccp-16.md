---
mccp: 16
title: Fee restructuring for swaps and redemptions
status: Implemented
author: Dimitri Golecko (@dimsome)
discussions-to:
created: 2022-02-03
---

## Simple Summary

It is proposed to consolidate and unify the fee structure for the current set of products at mStable. Currently, fees vary somewhat and this proposal's purpose is to align all mAsset fees to 2 bsp and fPools to 6 bsp.

## Abstract

The current fee structure is very fragmented. For example, mUSD swap fee is set on Ethereum Mainnet to 3 bsp, while mBTC is set to 2 bsp, while the redemption fee is set to 6 bsp. Feeder Pools also vary between 4 and 6 bsp.

This structure is not very transparent, not easy to remember or to document. Therefore it is proposed to consolidate all the swap and redemption fees for all mAssets and fPools into their own tiers.

The proposed structure is the following:

- mAsset swaps and redeems: `2 bsp`
- fPool swaps and redeems: `6 bsp`

This should apply to Ethereum Mainnet and Polygon.

## Motivation

This proposal seeks to unify and simplify the fee structure. This would make the products easier to understand. This would also set a precedent to what the fee structure is on mStable that could be used to apply to future products as well.

## Specification

This proposal will perform the following transaction for assets that deviate from the fee structure described in this proposal. This includes mUSD, mBTC, and fPools on Ethereum Mainnet and mUSD and fPools on Polygon.

mAssets:

- `setFees(swapFee, redemptionFee)`
  - `swapFee = 2e14`
  - `redemptionFee = 2e14`

fPools:

- `setFees(swapFee, redemptionFee, govFee)`
  - `swapFee = 6e14`
  - `redemptionFee = 6e14`
  - `govFee = 1e17` (unchanged 10%)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/)
