---
mip: MIP-19
title: Move idle mAssets in Feeder Pool to Rari Fuse Lending Markets 
status: WIP
author: derc
discussions-to: https://forum.mstable.org/t/discussion-incentivise-rari-fuse-lending-markets/665/11
created: 2021-10-26
---

## Simple Summary

This proposal aims to increase the capital efficiency of mAssets in Feeder Pools, starting with mUSD in the alUSD Feeder Pool and mBTC in TBTC/mBTC Feeder Pool which currently sit idly by deploying it into Rari Fuse.

## Abstract

This change will move idle mUSD and mBTC currently sitting in the various Feeder Pools into Rari Fuse and enable it for borrowing, bootstrapping mUSD and mBTC liquidity in Fuse. The available amount that can be deposited into Fuse lending markets is the total amount of deposited mUSD or mBTC minus the `cache size` (as outlined in [MIP 9 Section: Configurable Values](./mip-9)). This allows enough mUSD or mBTC to remain available for offering gas efficient swaps. At the time of writing, the `cache size` is set to `10%` but can be further adjusted with future MCCPs.

## Motivation

mStable assets do not have a native lending and borrowing market due to their relatively low on-chain liquidity. Protocols like Aave have minimum liquidity and trading volume thresholds for listing and require a Chainlink oracle as a price feed.

Chainlink oracles only exist for MTA, and not mAssets/imAssets due to their lack of on-chain liquidity, trading volume and CEX listing. Lending and borrowing markets are key to growth, especially for stablecoins as they allow users to obtain leverage.

## Specification

For this integration, the existing contract `CompoundIntegration.sol` can be reused as Rari Fuse has the same interface as Compound. A new instance will be deployed and initiated for each Feeder Pool with the following steps:

1. Deploy `CompoundIntegration.sol`

2. Call the contract function `migrateBassets([mAssetAddress], newIntegrationAddress)` to transfer all mUSD/mBTC in the Feeder Pool to the new integration contract.

Subsequent mint, swap or redeem transactions to the Feeder Pool will deposit the migrated mUSD/mBTC to Rari Fuse.

## Permissions

After the initial implementation of the mUSD/alUSD Feeder Pools outlined in this proposal, more Feeder Pools can be migrated to Rari Fuse. Additionally, the mUSD in Feeder Pools that are currently using the Iron Bank, could also be migrated based on utilization metrics.


## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
