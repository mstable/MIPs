---
mip: 30
title: Product Sunset Approach
status: Proposed
author: Dimitri Golecko (@dimsome), Nick Addison (@naddison36), Cesar Chavez (@doncesarts)
discussions-to:
created: 2023-02-27
---

## Simple Summary

This proposal outlines a sunset process and smart contract changes to products as specified in [MIP 29](https://mips.mstable.org/MIPS/mip-29.html).

It is important to note that this proposal is not indented to propose or discuss whether to sunset the products or not but rather in the case that the subsequent proposals to sunset are voted upon there is a set of clear guides and requirements specified to follow.

## Abstract

### Important comment upfront:

- **_This MIP is NOT to discuss whether to sunset or not_**, this will be part of a future proposal. But in light of MIP 29, we need to prepare for the eventuality of the shutdown of the products and how it’s going to be handled on a smart contract level.
- **_This MIP outlines HOW to sunset the products_** and to offer transparency around the guiding principles, methodology and smart contract changes/upgrades.
- **_The actual decision to execute this will be done in a future proposal._** A future proposal will be made that is referenced in MIP 29 that will offer options for proposed continuation as well as to pursue the shutdown.
- In the case that a proposal for Merge/Acquisition/Continuation is successful, this Proposal and the formal proposal resulting from it will be superseded by the winning proposal

This document serves to discuss the guiding principles and methodology for sunsetting the products and their smart contracts in accordance with [MIP 29](https://mips.mstable.org/MIPS/mip-29.html).

The first guiding principle for sunsetting the products and smart contracts is to allow user withdrawals at any time in the future and to never lock user funds. This means that any user will be able to access their funds at any point in the future, with no restrictions. It also means that users can be sure that their funds are safe, as they are not kept locked away in the contract.

The second principle is to remove all integration contracts such as Aave and Compound, meaning that all of the benefits associated with keeping funds within the contracts will be eliminated. This includes the ability to earn interest on deposits and any rewards. Furthermore, all fees will be set to zero to allow natural arbitrage to flow freely, without the user being able to earn, while also allowing for easier withdrawals with fewer fees in any basket asset.

The third principle is to remove all ownership from contracts held by the ProtocolDAO. This means removing the ability to change parameters, upgrading contracts, and finally renouncing all ownership of the nexus contract and the delayed upgradable proxy.

The fourth principle of open-source projects is to make any remaining repositories that have not yet been made publicly available to the community. This is an important step towards allowing other developers to benefit from the work of the project, as it allows them to access the code and build upon it.

The fifth principle is to communicate the sunset of deployed apps, landing pages, and social channels. This will allow for withdrawals on the hosted front end for a period of at least 6 months starting after the vote of the sunset in the subsequent proposal has been conducted. After this, withdrawals can still be made using locally hosted front-ends or through direct smart contract interaction, such as Etherscan.

## Motivation

The motivation behind this MIP is to ensure a swift and secure transition for the sunset of the products while allowing users to remain in control of their funds and access them at any time in the future, removing ownership from contracts held by the ProtocolDAO on behalf of MTA Governors / mStable DAO.

Data on Ethereum and Polygon don’t have an expiration date and our smart contracts should reflect this fact. Any user, no matter when they chose to withdraw, should get their assets back.

It's important to keep in mind that any changes made to a system may require a significant amount of time to implement properly. Once the changes are in place, it's also essential to test them thoroughly to ensure that they function as intended. Only after thorough testing should the changes be deployed into the live environment to minimize the risk of any potential issues arising. All of these steps are critical to ensuring that changes are made safely and effectively.

## Specification

Outlined here is the high-level approach to the sunset of each product. Staking contracts are excluded here and will be further specified in another proposal outlining MTA procedure.

### mAssets and Save

- Upgrade the mAssets’s `migrateBassets` to support migrating bAssets from platforms back to the mAsset contract
- Remove platform integration
- Set swap and redeem fee to 0
- Set new min-max weights (5% and 95%)
- This applies to mUSD and mBTC on Ethereum mainnet and to mUSD on Polygon

### Feeder Pools

- Upgrade the Feeder Pool’s `migrateBassets` to support migrating bAssets from platforms back to the Feeder Pool contract
- Remove integration contracts if present
- Set swap and redeem fee to 0
- This applies to mUSD and mBTC on Ethereum mainnet and to mUSD on Polygon
- Exception: GUSD is still integrated with Iron Bank, a full withdrawal from the integration contract to cache as specified in [MIP 23](https://mips.mstable.org/MIPS/mip-23.html) was not possible without further changes. The GUSD contract will be adjusted to allow partial migration of assets back to the cache.

### Meta Vault

- Upgrade contracts to add functionality to withdraw from underlying
- Withdraw all assets back to the contract
- Modify deposit and redeem functions to not do anything for all vaults (Convex, Curve, and Cache Meta Vault)

### Automated Tasks

- All automated tasks will be disabled
- This applies to mAssets, Feeder Pools, Emissions Controller, and Meta Vault

### Front-ends

- In all front-ends and the landing page, a banner will be added to notify everyone of the sunsetting of the product and to encourage withdrawals.
- The front-end will be kept alive for at least 6 months after the vote of the sunset in the subsequent proposal has been conducted.
- The possibility to access the contracts afterward is still possible via a locally run front-end or directly with the smart contracts (i.e. Etherscan).

### Nexus

- Set new governor to address dead: `0x000000000000000000000000000000000000dEaD`
- Once the governor's ownership has been renounced, the following is locked into place so this would be the very last on-chain transaction by the protocol governor
  - all modules in the Nexus. eg Liquidator and SavingManager addresses
  - All proxy contracts can no longer be upgraded
- This should be the very last step and requires that the staking contracts upgrades/changes are resolved as well

## Technical Specifications

This section outlines the more technical adjustments of the smart contracts and transactions that will be made in order to implement a sunset.

### mAssets and Save

The following changes will be made to the smart contracts in order to implement the sunset process for the mAssets and Save products.

**mUSD mainnet contract changes**

- Rename the `Manager` library to `MassetManagerV4` so the new library can be deployed and not the old library.
- Upgrade the `migrateBassets` function in the `MassetManagerV4` library so the new integration contract can be a zero address. This will withdraw all the bAssets from the old integrated platform and leave the bAssets in the mUSD contract.
- Rename the `MusdV3` contract to `MusdV4` so the new mUSD implementation can be deployed.
- Remove the `upgrade` function from the mUSD contract to simplify the deployment of the mUSD contract. The `upgrade` was only used for the last upgrade and is dependent on the `Migrator` library. It’s easier to deploy mIUSD with just a dependency on the `MassetManagerV4` library rather than both `MassetManagerV4` and the `Migrator` libraries.

**mUSD upgrade process on mainnet**

- Deploy the new `MassetManagerV4` library.
- Deploy the new `MusdV4` contract that is linked to the previous `MassetManagerV4` library.
- Propose the upgrade of the mUSD proxy by calling `proposeUpgrade` on the deployed proxy admin contract using the Protocol DAO Safe. The last `data` param is just `0x` as `initialize` should not called.
  - Delayed Proxy Admin [0x5c8eb57b44c1c6391fc7a8a0cf44d26896f92386](https://etherscan.io/address/0x5c8eb57b44c1c6391fc7a8a0cf44d26896f92386)
  - mUSD proxy [0xe2f2a5c287993345a840db3b0845fbc70f5935a5](https://etherscan.io/address/0xe2f2a5c287993345a840db3b0845fbc70f5935a5)
- After one week from the proposed upgrade has been executed, accept the mUSD proxy contract upgrade by calling `acceptUpgrade` on the proxy admin contract using the Protocol DAO Safe.
  - Delayed Proxy Admin [0x5c8eb57b44c1c6391fc7a8a0cf44d26896f92386](https://etherscan.io/address/0x5c8eb57b44c1c6391fc7a8a0cf44d26896f92386)
  - mUSD proxy [0xe2f2a5c287993345a840db3b0845fbc70f5935a5](https://etherscan.io/address/0xe2f2a5c287993345a840db3b0845fbc70f5935a5)
- Call `accrueInterest()` on the cUSDC token. This is so all the USDC in Compound is withdrawn when the bAsset migration is done. More specifically, the Compound integrator contract converts required USDC to cUSDC tokens. This uses `exchangeRateStored` on the cUSDC token which does not take into account any accrued interest.
  - cUSDC [0x39aa39c021dfbae8fac545936693ac917d5e7563](https://etherscan.io/token/0x39aa39c021dfbae8fac545936693ac917d5e7563)
- Collect and stream the remaining platform interest by calling `collectAndStreamInterest` on the SavingsManager for the mUSD proxy.
  - Savings Manager [0xBC3B550E0349D74bF5148D86114A48C3B4Aa856F](https://etherscan.io/address/0xBC3B550E0349D74bF5148D86114A48C3B4Aa856F)
  - mUSD proxy [0xe2f2a5c287993345a840db3b0845fbc70f5935a5](https://etherscan.io/address/0xe2f2a5c287993345a840db3b0845fbc70f5935a5)
- The Protocol DAO Safe calls `migrateBassets` on the mUSD proxy passing in each of the bAsset addresses. (sUSD, USDC, DAI and USDT).
  - mUSD proxy [0xe2f2a5c287993345a840db3b0845fbc70f5935a5](https://etherscan.io/address/0xe2f2a5c287993345a840db3b0845fbc70f5935a5)
  - sUSD [0x57Ab1ec28D129707052df4dF418D58a2D46d5f51](https://etherscan.io/address/0x57Ab1ec28D129707052df4dF418D58a2D46d5f51)
  - USDC [0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48](https://etherscan.io/address/0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48)
  - DAI [0x6B175474E89094C44Da98b954EedeAC495271d0F](https://etherscan.io/address/0x6B175474E89094C44Da98b954EedeAC495271d0F)
  - USDT [0xdAC17F958D2ee523a2206206994597C13D831ec7](https://etherscan.io/address/0xdAC17F958D2ee523a2206206994597C13D831ec7)
- The Protocol DAO Safe calls `setFees` on mUSD proxy with zero value for the swap and redemption fees.
  - mUSD proxy [0xe2f2a5c287993345a840db3b0845fbc70f5935a5](https://etherscan.io/address/0xe2f2a5c287993345a840db3b0845fbc70f5935a5)
- The Protocol DAO Safe calls `setWeightLimits` on mUSD proxy with min of 5% (5e16) and max 95% (95e17).
  - mUSD proxy [0xe2f2a5c287993345a840db3b0845fbc70f5935a5](https://etherscan.io/address/0xe2f2a5c287993345a840db3b0845fbc70f5935a5)

**mBTC changes on mainnet**

- Rename the `Manager` library to `MassetManagerBtcV2` so the new library can be deployed and not the old library.
- Upgrade the `migrateBassets` function in the `MassetManagerBtcV2` library so the new integration contract can be a zero address. This will withdraw all the bAssets from the old integrated platform and leave the bAssets in the mBTC contract.
- Rename the `Masset` contract to `MassetBtcV2` so the new mUSD implementation can be deployed.
- Remove the `initialize` function from the mBTC contract to simplify the deployment of the mBTC contract.

**mBTC upgrade process on mainnet**

- Deploy the new `MassetManagerBtcV2` library.
- Deploy the new `MassetBtcV2` contract that is linked to the previous `MassetManagerBtcV2` library
- Propose the upgrade of the mBTC proxy by calling `proposeUpgrade` on the deployed proxy admin contract using the Protocol DAO Safe. The last `data` param is just `0x` as `initialize` should not called.
  - Delayed Proxy Admin [0x5c8eb57b44c1c6391fc7a8a0cf44d26896f92386](https://etherscan.io/address/0x5c8eb57b44c1c6391fc7a8a0cf44d26896f92386)
  - mBTC proxy [0x945Facb997494CC2570096c74b5F66A3507330a1](https://etherscan.io/address/0x945Facb997494CC2570096c74b5F66A3507330a1)
- After one week from the proposed upgrade has been executed, accept the mBTC proxy contract upgrade by calling `acceptUpgrade` on the proxy admin contract using the Protocol DAO Safe.
  - Delayed Proxy Admin [0x5c8eb57b44c1c6391fc7a8a0cf44d26896f92386](https://etherscan.io/address/0x5c8eb57b44c1c6391fc7a8a0cf44d26896f92386)
  - mBTC proxy [0x945Facb997494CC2570096c74b5F66A3507330a1](https://etherscan.io/address/0x945Facb997494CC2570096c74b5F66A3507330a1)
- Collect and stream the remaining platform interest by calling `collectAndStreamInterest` on the SavingsManager for the mBTC proxy.
  - Savings Manager [0xBC3B550E0349D74bF5148D86114A48C3B4Aa856F](https://etherscan.io/address/0xBC3B550E0349D74bF5148D86114A48C3B4Aa856F)
  - mBTC proxy [0x945Facb997494CC2570096c74b5F66A3507330a1](https://etherscan.io/address/0x945Facb997494CC2570096c74b5F66A3507330a1)
- The Protocol DAO Safe calls `migrateBassets` on the mBTC contract passing in the WBTC bAsset address.
  - mBTC proxy [0x945Facb997494CC2570096c74b5F66A3507330a1](https://etherscan.io/address/0x945Facb997494CC2570096c74b5F66A3507330a1)
  - WBTC [0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599](https://etherscan.io/address/0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599)
- The Protocol DAO Safe calls `setFees` on mBTC proxy with zero values for the swap and redemption fees.
  - mBTC proxy [0x945Facb997494CC2570096c74b5F66A3507330a1](https://etherscan.io/address/0x945Facb997494CC2570096c74b5F66A3507330a1)
- The Protocol DAO Safe calls `setWeightLimits` on mBTC proxy with min of 5% (5e16) and max 95% (95e17).
  - mBTC proxy [0x945Facb997494CC2570096c74b5F66A3507330a1](https://etherscan.io/address/0x945Facb997494CC2570096c74b5F66A3507330a1)

**mUSD Polygon contract changes**

- Rename the `MassetManager` library to `MassetManagerV2` so the new library can be deployed and not the old library.
- Upgrade the `migrateBassets` function in the `MassetManager` library so the new integration contract can be a zero address. This will withdraw all the bAssets from the old integrated platform and leave the bAssets in the mUSD contract.
- Rename the `Masset` contract to `MassetPolygon` so the new mUSD implementation can be deployed.
- Rename references of `MassetManager` to `MassetManagerV2`.
- Remove the `initialize` function from `MassetPolygon`.

**mUSD upgrade process on Polygon**

- Deploy the new `MassetManagerV2` library.
- Deploy the new `MassetPolygon` contract that is linked to the previous `MassetManagerV2` library and the existing `MassetLogic` library
  - MassetLogic library [0xb9cca2b53e8d7bc4cbddccb66d20b411b87d213f](https://polygonscan.com/address/0xb9cca2b53e8d7bc4cbddccb66d20b411b87d213f)
- Propose the upgrade of the mUSD proxy by calling `proposeUpgrade` on the deployed proxy admin contract using the Protocol DAO Safe. The last `data` param is just `0x` as `initialize` should not called.
  - Delayed Proxy Admin [0xCb6E4B67f2cac15c284AB49B6a4A671cdfe66711](https://polygonscan.com/address/0xCb6E4B67f2cac15c284AB49B6a4A671cdfe66711)
  - mUSD proxy [0xE840B73E5287865EEc17d250bFb1536704B43B21](https://polygonscan.com/address/0xE840B73E5287865EEc17d250bFb1536704B43B21/contracts#code)
- After one week from the proposed upgrade has been executed, accept the mUSD proxy contract upgrade by calling `acceptUpgrade` on the proxy admin contract using the Protocol DAO Safe.
  - Delayed Proxy Admin [0xCb6E4B67f2cac15c284AB49B6a4A671cdfe66711](https://polygonscan.com/address/0xCb6E4B67f2cac15c284AB49B6a4A671cdfe66711)
  - mUSD proxy [0xE840B73E5287865EEc17d250bFb1536704B43B21](https://polygonscan.com/address/0xE840B73E5287865EEc17d250bFb1536704B43B21/contracts#code)
- Collect and stream the remaining platform interest by calling `collectAndStreamInterest` on the SavingsManager for the mUSD proxy.
  - Savings Manager [0xBC3B550E0349D74bF5148D86114A48C3B4Aa856F](https://etherscan.io/address/0xBC3B550E0349D74bF5148D86114A48C3B4Aa856F)
  - mUSD proxy [0xE840B73E5287865EEc17d250bFb1536704B43B21](https://polygonscan.com/address/0xE840B73E5287865EEc17d250bFb1536704B43B21/contracts#code)
- The Protocol DAO Safe calls `migrateBassets` on the mUSD proxy passing in each of the bAsset addresses. (USDC, DAI and USDT).
  - mUSD proxy [0xE840B73E5287865EEc17d250bFb1536704B43B21](https://polygonscan.com/address/0xE840B73E5287865EEc17d250bFb1536704B43B21/contracts#code)
  - USDC [0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174](https://polygonscan.com/address/0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174)
  - DAI [0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063](https://polygonscan.com/address/0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063)
  - USDT [0xc2132D05D31c914a87C6611C10748AEb04B58e8F](https://polygonscan.com/address/0xc2132D05D31c914a87C6611C10748AEb04B58e8F)
- The Protocol DAO Safe calls `setFees` on mUSD proxy with zero values for the swap and redemption fees.
  - mUSD proxy [0xE840B73E5287865EEc17d250bFb1536704B43B21](https://polygonscan.com/address/0xE840B73E5287865EEc17d250bFb1536704B43B21/contracts#code)
- The Protocol DAO Safe calls `setWeightLimits` on mUSD proxy with min of 5% (5e16) and max 95% (95e17).
  - mUSD proxy [0xE840B73E5287865EEc17d250bFb1536704B43B21](https://polygonscan.com/address/0xE840B73E5287865EEc17d250bFb1536704B43B21/contracts#code)

### Feeder Pools

**Mainnet**

- Collect interest for the BUSD, GUSD, alUSD, RAI and FEI Feeder Pools for by manually running the `ETH - Collect and validate Feeder Pool interest` Autotask.
- Upgrade the Feeder Pool’s `migrateBassets` to support migrating bAssets from platforms back to the Feeder Pool contract.
- ProtocolDAO collects governance fees from feeder pools by calling `collectGovFees` on the Feeder Pool Interest Validator.

**GUSD & BUSD Feeder Pool contract changes**

- Rename the `FeederManager` library to `FeederManagerV2` so the new library can be deployed and not the old library.
- Upgrade the `migrateBassets` function in the `FeederManagerV2` library so the new integration contract can be a zero address. This will withdraw all the bAssets from the old integrated platform and leave the bAssets in the Feeder Pool proxy.
- Rename the `FeederPool` contract to `FeederPoolV2` so the new Feeder Pool implementation can be deployed.
- Remove the `initialize` function from the Feeder Pool contract.
- Add a new `cachePlatformIntegration` function to the `FeederPoolV2` contract that will take a bAsset address and withdraw amount. This function will withdraw bAssets from the platform integration with the recipient the integration contract, the amount as zero and the total amount as the passed in withdraw amount parameter.

**GUSD Feeder Pool upgrade process**

- Deploy the new `FeederManagerV2` library that can be reused by GUSD, BUSD, alUSD, RAI and FEI Feeder Pools.
- Deploy the new `FeederPoolV2` contract that is linked to the previous `FeederManagerV2` library.
- Propose the upgrade of the GUSD Feeder Pool proxy by calling `proposeUpgrade` on the deployed proxy admin contract using the Protocol DAO Safe. The last `data` param is just `0x` as `initialize` should not called.
  - Delayed Proxy Admin [0x5c8eb57b44c1c6391fc7a8a0cf44d26896f92386](https://etherscan.io/address/0x5c8eb57b44c1c6391fc7a8a0cf44d26896f92386)
  - GUSD Feeder Pool proxy [0x4fB30C5A3aC8e85bC32785518633303C4590752d](https://etherscan.io/address/0x4fB30C5A3aC8e85bC32785518633303C4590752d)
- After one week from the proposed upgrade has been executed, accept the GUSD proxy contract upgrade by calling `acceptUpgrade` on the proxy admin contract using the Protocol DAO Safe.
  - Delayed Proxy Admin [0x5c8eb57b44c1c6391fc7a8a0cf44d26896f92386](https://etherscan.io/address/0x5c8eb57b44c1c6391fc7a8a0cf44d26896f92386)
  - GUSD Feeder Pool proxy [0x4fB30C5A3aC8e85bC32785518633303C4590752d](https://etherscan.io/address/0x4fB30C5A3aC8e85bC32785518633303C4590752d)
- Collect and stream the remaining platform interest by calling `collectAndValidateInterest` on the Feeder Pool Interest Validator for the GUSD proxy.
  - Interest Validator [0xf1049aeD858C4eAd6df1de4dbE63EF607CfF3262](https://etherscan.io/address/0xf1049aeD858C4eAd6df1de4dbE63EF607CfF3262)
  - GUSD Feeder Pool proxy [0x4fB30C5A3aC8e85bC32785518633303C4590752d](https://etherscan.io/address/0x4fB30C5A3aC8e85bC32785518633303C4590752d)
- The Protocol DAO Safe calls `migrateBassets` on the GUSD proxy passing in the GUSD bAsset address.
  - GUSD Feeder Pool proxy [0x4fB30C5A3aC8e85bC32785518633303C4590752d](https://etherscan.io/address/0x4fB30C5A3aC8e85bC32785518633303C4590752d)
  - GUSD token [0x056fd409e1d7a124bd7017459dfea2f387b6d5cd](https://etherscan.io/token/0x056fd409e1d7a124bd7017459dfea2f387b6d5cd)
- The Protocol DAO Safe calls `setFees` on GUSD proxy with zero value for the swap, redemption and governance fees.
  - GUSD Feeder Pool proxy [0x4fB30C5A3aC8e85bC32785518633303C4590752d](https://etherscan.io/address/0x4fB30C5A3aC8e85bC32785518633303C4590752d)
- The Protocol DAO Safe calls `setWeightLimits` on GUSD proxy with min of 5% (5e16) and max 95% (95e17).
  - GUSD Feeder Pool proxy [0x4fB30C5A3aC8e85bC32785518633303C4590752d](https://etherscan.io/address/0x4fB30C5A3aC8e85bC32785518633303C4590752d)
- The Protocol DAO Safe calls `cachePlatformIntegration` on GUSD proxy with mUSD address as the bAsset and withdraw amount as the mUSD balance in the cymUSD contract. This is the available mUSD liquidity in Iron Bank.
  - GUSD Feeder Pool proxy [0x4fB30C5A3aC8e85bC32785518633303C4590752d](https://etherscan.io/address/0x4fB30C5A3aC8e85bC32785518633303C4590752d)
  - mUSD token [0xe2f2a5c287993345a840db3b0845fbc70f5935a5](https://etherscan.io/address/0xe2f2a5c287993345a840db3b0845fbc70f5935a5)
  - cymUSD [0xBE86e8918DFc7d3Cb10d295fc220F941A1470C5c](https://etherscan.io/token/0xBE86e8918DFc7d3Cb10d295fc220F941A1470C5c)
- Repeat until the entirety of mUSD is withdrawn

**BUSD Feeder Pool upgrade process**

- Deploy the new `FeederPoolV2` contract that is linked to the `FeederManagerV2` library deployed in the GUSD process.
- Propose the upgrade of the BUSD Feeder Pool proxy by calling `proposeUpgrade` on the deployed proxy admin contract using the Protocol DAO Safe. The last `data` param is just `0x` as `initialize` should not called.
  - Delayed Proxy Admin [0x5c8eb57b44c1c6391fc7a8a0cf44d26896f92386](https://etherscan.io/address/0x5c8eb57b44c1c6391fc7a8a0cf44d26896f92386)
  - BUSD Feeder Pool proxy [0xfE842e95f8911dcc21c943a1dAA4bd641a1381c6](https://etherscan.io/address/0xfE842e95f8911dcc21c943a1dAA4bd641a1381c6)
- After one week from the proposed upgrade has been executed, accept the BUSD proxy contract upgrade by calling `acceptUpgrade` on the proxy admin contract using the Protocol DAO Safe.
  - Delayed Proxy Admin [0x5c8eb57b44c1c6391fc7a8a0cf44d26896f92386](https://etherscan.io/address/0x5c8eb57b44c1c6391fc7a8a0cf44d26896f92386)
  - BUSD Feeder Pool proxy [0xfE842e95f8911dcc21c943a1dAA4bd641a1381c6](https://etherscan.io/address/0xfE842e95f8911dcc21c943a1dAA4bd641a1381c6)
- Collect and stream the remaining platform interest by calling `collectAndValidateInterest` on the Feeder Pool Interest Validator for the BUSD proxy.
  - Interest Validator [0xf1049aeD858C4eAd6df1de4dbE63EF607CfF3262](https://etherscan.io/address/0xf1049aeD858C4eAd6df1de4dbE63EF607CfF3262)
  - BUSD Feeder Pool proxy [0xfE842e95f8911dcc21c943a1dAA4bd641a1381c6](https://etherscan.io/address/0xfE842e95f8911dcc21c943a1dAA4bd641a1381c6)
- The Protocol DAO Safe calls `migrateBassets` on the BUSD proxy passing in the BUSD and mUSD bAsset addresses.
  - BUSD Feeder Pool proxy [0xfE842e95f8911dcc21c943a1dAA4bd641a1381c6](https://etherscan.io/address/0xfE842e95f8911dcc21c943a1dAA4bd641a1381c6)
  - BUSD token [0x4Fabb145d64652a948d72533023f6E7A623C7C53](https://etherscan.io/token/0x4Fabb145d64652a948d72533023f6E7A623C7C53)
  - mUSD token [0xe2f2a5c287993345a840db3b0845fbc70f5935a5](https://etherscan.io/address/0xe2f2a5c287993345a840db3b0845fbc70f5935a5)
- The Protocol DAO Safe calls `setFees` on BUSD proxy with zero value for the swap, redemption and governance fees.
  - BUSD Feeder Pool proxy [0xfE842e95f8911dcc21c943a1dAA4bd641a1381c6](https://etherscan.io/address/0xfE842e95f8911dcc21c943a1dAA4bd641a1381c6)
- The Protocol DAO Safe calls `setWeightLimits` on BUSD proxy with min of 5% (5e16) and max 95% (95e17).
  - BUSD Feeder Pool proxy [0xfE842e95f8911dcc21c943a1dAA4bd641a1381c6](https://etherscan.io/address/0xfE842e95f8911dcc21c943a1dAA4bd641a1381c6)

**RAI Feeder Pool contract changes**

- Rename the `FeederManager` library to `FeederManagerV2` so the new library can be deployed and not the old library.
- Upgrade the `migrateBassets` function in the `FeederManagerV2` library so the new integration contract can be a zero address. This will withdraw all the bAssets from the old integrated platform and leave the bAssets in the Feeder Pool contract.
- Rename the `NonPeggedFeederPool` contract to `NonPeggedFeederPoolV2` so the new Feeder Pool implementation can be deployed.
- Remove the `initialize` function from the Feeder Pool contract.

**RAI Feeder Pool upgrade process**

- Deploy the new `NonPeggedFeederPoolV2` contract that is linked to the `FeederManagerV2` library deployed in the GUSD process.
- Propose the upgrade of the RAI Feeder Pool proxy by calling `proposeUpgrade` on the deployed proxy admin contract using the Protocol DAO Safe. The last `data` param is just `0x` as `initialize` should not called.
  - Delayed Proxy Admin [0x5c8eb57b44c1c6391fc7a8a0cf44d26896f92386](https://etherscan.io/address/0x5c8eb57b44c1c6391fc7a8a0cf44d26896f92386)
  - RAI Feeder Pool proxy [0x36F944B7312EAc89381BD78326Df9C84691D8A5B](https://etherscan.io/address/0x36F944B7312EAc89381BD78326Df9C84691D8A5B)
- After one week from the proposed upgrade has been executed, accept the RAI proxy contract upgrade by calling `acceptUpgrade` on the proxy admin contract using the Protocol DAO Safe.
  - Delayed Proxy Admin [0x5c8eb57b44c1c6391fc7a8a0cf44d26896f92386](https://etherscan.io/address/0x5c8eb57b44c1c6391fc7a8a0cf44d26896f92386)
  - RAI Feeder Pool proxy [0x36F944B7312EAc89381BD78326Df9C84691D8A5B](https://etherscan.io/address/0x36F944B7312EAc89381BD78326Df9C84691D8A5B)
- Collect and stream the remaining platform interest by calling `collectAndValidateInterest` on the Feeder Pool Interest Validator for the RAI proxy.
  - Interest Validator [0xf1049aeD858C4eAd6df1de4dbE63EF607CfF3262](https://etherscan.io/address/0xf1049aeD858C4eAd6df1de4dbE63EF607CfF3262)
  - RAI Feeder Pool proxy [0x36F944B7312EAc89381BD78326Df9C84691D8A5B](https://etherscan.io/address/0x36F944B7312EAc89381BD78326Df9C84691D8A5B)
- The Protocol DAO Safe calls `migrateBassets` on the RAI proxy passing in the RAI address.
  - RAI Feeder Pool proxy [0x36F944B7312EAc89381BD78326Df9C84691D8A5B](https://etherscan.io/address/0x36F944B7312EAc89381BD78326Df9C84691D8A5B)
  - RAI token [0x03ab458634910aad20ef5f1c8ee96f1d6ac54919](https://etherscan.io/token/0x03ab458634910aad20ef5f1c8ee96f1d6ac54919)
- The Protocol DAO Safe calls `setFees` on RAI proxy with zero value for the swap, redemption and governance fees.
  - RAI Feeder Pool proxy [0x36F944B7312EAc89381BD78326Df9C84691D8A5B](https://etherscan.io/address/0x36F944B7312EAc89381BD78326Df9C84691D8A5B)
- The Protocol DAO Safe calls `setWeightLimits` on RAI proxy with min of 5% (5e16) and max 95% (95e17).
  - RAI Feeder Pool proxy [0x36F944B7312EAc89381BD78326Df9C84691D8A5B](https://etherscan.io/address/0x36F944B7312EAc89381BD78326Df9C84691D8A5B)

**FEI Feeder Pool contract changes**

- Rename the `FeederPool.sol` file to `FeiFeederPool.sol`
- Rename the `FeederManager` library to `FeederManagerV2` so the new library can be deployed and not the old library.
- Upgrade the `migrateBassets` function in the `FeederManagerV2` library so the new integration contract can be a zero address. This will withdraw all the bAssets from the old integrated platform and leave the bAssets in the Feeder Pool contract.
- Rename the `FeederPool` contract to `FeiFeederPool` so the new Fei Feeder Pool implementation can be deployed.
- Remove the `initialize` function from the Feeder Pool contract.

**FEI Feeder Pool upgrade process**

- Deploy the new `FeiFeederPool` contract that is linked to the `FeederManagerV2` library deployed in the GUSD process.
- Propose the upgrade of the FEI Feeder Pool proxy by calling `proposeUpgrade` on the deployed proxy admin contract using the Protocol DAO Safe. The last `data` param is just `0x` as `initialize` should not called.
  - Delayed Proxy Admin [0x5c8eb57b44c1c6391fc7a8a0cf44d26896f92386](https://etherscan.io/address/0x5c8eb57b44c1c6391fc7a8a0cf44d26896f92386)
  - FEI Feeder Pool proxy [0x2F1423D27f9B20058d9D1843E342726fDF985Eb](https://etherscan.io/address/0x2F1423D27f9B20058d9D1843E342726fDF985Eb4)
- After one week from the proposed upgrade has been executed, accept the FEI proxy contract upgrade by calling `acceptUpgrade` on the proxy admin contract using the Protocol DAO Safe.
  - Delayed Proxy Admin [0x5c8eb57b44c1c6391fc7a8a0cf44d26896f92386](https://etherscan.io/address/0x5c8eb57b44c1c6391fc7a8a0cf44d26896f92386)
  - FEI Feeder Pool proxy [0x2F1423D27f9B20058d9D1843E342726fDF985Eb](https://etherscan.io/address/0x2F1423D27f9B20058d9D1843E342726fDF985Eb4)
- Collect and stream the remaining platform interest by calling `collectAndValidateInterest` on the Feeder Pool Interest Validator for the FEI proxy.
  - Interest Validator [0xf1049aeD858C4eAd6df1de4dbE63EF607CfF3262](https://etherscan.io/address/0xf1049aeD858C4eAd6df1de4dbE63EF607CfF3262)
  - FEI Feeder Pool proxy [0x2F1423D27f9B20058d9D1843E342726fDF985Eb](https://etherscan.io/address/0x2F1423D27f9B20058d9D1843E342726fDF985Eb4)
- The Protocol DAO Safe calls `migrateBassets` on the FEI proxy passing in the FEI address.
  - FEI Feeder Pool proxy [0x2F1423D27f9B20058d9D1843E342726fDF985Eb](https://etherscan.io/address/0x2F1423D27f9B20058d9D1843E342726fDF985Eb4)
  - FEI token [0x956f47f50a910163d8bf957cf5846d573e7f87ca](https://etherscan.io/token/0x956f47f50a910163d8bf957cf5846d573e7f87ca)
- The Protocol DAO Safe calls `setFees` on FEI proxy with zero value for the swap, redemption and governance fees.
  - FEI Feeder Pool proxy [0x2F1423D27f9B20058d9D1843E342726fDF985Eb](https://etherscan.io/address/0x2F1423D27f9B20058d9D1843E342726fDF985Eb4)
- The Protocol DAO Safe calls `setWeightLimits` on FAI proxy with min of 5% (5e16) and max 95% (95e17).
  - FEI Feeder Pool proxy [0x2F1423D27f9B20058d9D1843E342726fDF985Eb](https://etherscan.io/address/0x2F1423D27f9B20058d9D1843E342726fDF985Eb4)

**Polygon Frax Feeder Pool**

- Collect interest for the FRAX Feeder Pool for running Hardhat task `feeder-collect-interest`.
- ProtocolDAO collects governance fees from feeder pools by calling `collectGovFees` on the Feeder Pool Interest Validator.
- Governance fees are transferred back to mainnet Treasury multi-sig.
- The contract does not need upgrading as the FRAX and mUSD is not integrated to any lending platforms.
- The Protocol DAO Safe calls `setFees` on FRAX proxy with zero value for the swap, redemption and governance fees.
  - FRAX Feeder Pool proxy: [0xB30a907084AC8a0d25dDDAB4E364827406Fd09f0](https://polygonscan.com/address/0xB30a907084AC8a0d25dDDAB4E364827406Fd09f0)
- The Protocol DAO Safe calls `setWeightLimits` on FRAX proxy with min of 5% (5e16) and max 95% (95e17).
  - FRAX Feeder Pool proxy: [0xB30a907084AC8a0d25dDDAB4E364827406Fd09f0](https://polygonscan.com/address/0xB30a907084AC8a0d25dDDAB4E364827406Fd09f0)

### Meta Vaults

**3Pool Convex Meta Vault contract changes**

Upgrade `Curve3CrvAbstractMetaVault`, `PeriodicAllocationPerFeeMetavault` and `Convex3CrvAbstractVault` to support withdrawing all assets from underlying vaults. Withdraw all assets for all vaults and allow withdraw proportional to user shares. Modify `deposit` and `redeem` to not do anything for all vaults (Convex, Curve and Cache Meta Vault). Modify `totalAssets` in `SameAssetsUnderlyingVault` to not include underlying assets.

The following contract change will be made:

- Create a function `liquidateUnderlyingVault` in `Curve3CrvAbstractMetaVault` that can only be called by the ProtocolDAO. This will remove all liquidity from the 3Crv Pool and leave USDC in the contract.
- Modify `deposit` and `mint` to not do anything for all vaults (Convex, Curve, and Cache Meta Vault).
- Modify `totalAssets` in `SameAssetsUnderlyingVault` to not include underlying assets.
- Modify `redeem` and `withdraw` to issue assets based on the proportion of `shares`

**3Pool Convex Meta Vault upgrade process**

- ProtocolDAO calls `pause` on all vaults to avoid any action during the upgrade
  - vcx3CRV-mUSD proxy: [0xB9B47E72819934d7A5d60Bf08cD2C78072383EBb](https://etherscan.io/address/0xB9B47E72819934d7A5d60Bf08cD2C78072383EBb)
  - vcx3CRV-FRAX proxy: [0x98c5910823C2E67d54e4e0C03de44043DbfA7ca8](https://etherscan.io/address/0x98c5910823c2e67d54e4e0c03de44043dbfa7ca8)
  - vcx3CRV-BUSD proxy: [0x87Ed92648fAE3b3930577c92c8A247b127ED8949](https://etherscan.io/address/0x87Ed92648fAE3b3930577c92c8A247b127ED8949)
  - mv3CRV-CVX proxy: [0x9614a4C61E45575b56c7e0251f63DCDe797d93C5](https://etherscan.io/address/0x9614a4c61e45575b56c7e0251f63dcde797d93c5)
  - mvUSDC-3PCV proxy: [0x455fB969dC06c4Aa77e7db3f0686CC05164436d2](https://etherscan.io/address/0x455fb969dc06c4aa77e7db3f0686cc05164436d2)
- ProtocolDAO deploys new implementation contracts and proposes the upgrade
- Upgrade the Meta Vault proxy by calling u`pgrade` on the instant proxy admin contract using the Protocol DAO Safe. The last `data` param is just `0x` as `initialize` should not be called.
  - Instant Proxy Admin [0x3517F5a251d56C768789c22E989FAa7d906b5a13](https://etherscan.io/address/0x3517F5a251d56C768789c22E989FAa7d906b5a13)
  - vcx3CRV-mUSD proxy: [0xB9B47E72819934d7A5d60Bf08cD2C78072383EBb](https://etherscan.io/address/0xB9B47E72819934d7A5d60Bf08cD2C78072383EBb)
  - vcx3CRV-FRAX proxy: [0x98c5910823C2E67d54e4e0C03de44043DbfA7ca8](https://etherscan.io/address/0x98c5910823c2e67d54e4e0c03de44043dbfa7ca8)
  - vcx3CRV-BUSD proxy: [0x87Ed92648fAE3b3930577c92c8A247b127ED8949](https://etherscan.io/address/0x87Ed92648fAE3b3930577c92c8A247b127ED8949)
  - mv3CRV-CVX proxy: [0x9614a4C61E45575b56c7e0251f63DCDe797d93C5](https://etherscan.io/address/0x9614a4c61e45575b56c7e0251f63dcde797d93c5)
  - mvUSDC-3PCV proxy: [0x455fB969dC06c4Aa77e7db3f0686CC05164436d2](https://etherscan.io/address/0x455fb969dc06c4aa77e7db3f0686cc05164436d2)
- ProtocolDAO calls `removeVault` to withdraw all assets from the underlying.
  - mv3CRV-CVX proxy: [0x9614a4C61E45575b56c7e0251f63DCDe797d93C5](https://etherscan.io/address/0x9614a4c61e45575b56c7e0251f63dcde797d93c5)
    - **`removeVault(2)`** to remove vcx3CRV-BUSD
    - **`removeVault(1)`** to remove vcx3CRV-mUSD
    - **`removeVault(0)`** to \***\*remove \*\***vcx3CRV-FRAX
- ProtocolDAO calls **`liquidateUnderlyingVault()`** to \*\*\*\*remove all liquidity from Curve
  - mvUSDC-3PCV proxy: [0x455fB969dC06c4Aa77e7db3f0686CC05164436d2](https://etherscan.io/address/0x455fb969dc06c4aa77e7db3f0686cc05164436d2)
- PrococolDAO unpauses the vaults with `unpause`. This restores the functionality and assets are and will be available to be withdrawn
  - vcx3CRV-mUSD proxy: [0xB9B47E72819934d7A5d60Bf08cD2C78072383EBb](https://etherscan.io/address/0xB9B47E72819934d7A5d60Bf08cD2C78072383EBb)
  - vcx3CRV-FRAX proxy: [0x98c5910823C2E67d54e4e0C03de44043DbfA7ca8](https://etherscan.io/address/0x98c5910823c2e67d54e4e0c03de44043dbfa7ca8)
  - vcx3CRV-BUSD proxy: [0x87Ed92648fAE3b3930577c92c8A247b127ED8949](https://etherscan.io/address/0x87Ed92648fAE3b3930577c92c8A247b127ED8949)
  - mv3CRV-CVX proxy: [0x9614a4C61E45575b56c7e0251f63DCDe797d93C5](https://etherscan.io/address/0x9614a4c61e45575b56c7e0251f63dcde797d93c5)
  - mvUSDC-3PCV proxy: [0x455fB969dC06c4Aa77e7db3f0686CC05164436d2](https://etherscan.io/address/0x455fb969dc06c4aa77e7db3f0686cc05164436d2)

### Nexus

The last step after all of the above is implemented AND all changes to staking, MTA, Emissions Controller are implemented (separate Proposal).

The Protocol DAO’s Gnosis Safe calls `changeGovernor` on the Nexus contract with address `0x000000000000000000000000000000000000dEaD`

**Affected addresses Mainnet:**

- Nexus [0xafce80b19a8ce13dec0739a1aab7a028d6845eb3](https://etherscan.io/address/0xafce80b19a8ce13dec0739a1aab7a028d6845eb3)
- Delayed Proxy Admin [0x5c8eb57b44c1c6391fc7a8a0cf44d26896f92386](https://etherscan.io/address/0x5c8eb57b44c1c6391fc7a8a0cf44d26896f92386)
- Instant Proxy Admin [0x3517F5a251d56C768789c22E989FAa7d906b5a13](https://etherscan.io/address/0x3517F5a251d56C768789c22E989FAa7d906b5a13)
- Gnosis Safe used by the Protocol DAO [0xF6FF1F7FCEB2cE6d26687EaaB5988b445d0b94a2](https://app.safe.global/eth:0xF6FF1F7FCEB2cE6d26687EaaB5988b445d0b94a2/transactions/queue)

**Affected addresses Polygon:**

- Nexus [0x3C6fbB8cbfCB75ecEC5128e9f73307f2cB33f2f6](https://polygonscan.com/address/0x3C6fbB8cbfCB75ecEC5128e9f73307f2cB33f2f6)
- Delayed Proxy Admin [0xCb6E4B67f2cac15c284AB49B6a4A671cdfe66711](https://polygonscan.com/address/0xCb6E4B67f2cac15c284AB49B6a4A671cdfe66711)
- Instant Proxy Admin [0x3517F5a251d56C768789c22E989FAa7d906b5a13](https://etherscan.io/address/0x3517F5a251d56C768789c22E989FAa7d906b5a13)
- Gnosis Safe used by the Protocol DAO [0x429F29A3A36B1B977C3d4Ec77C695c3391e7B9E](https://app.safe.global/matic:0x429F29A3A36B1B977C3d4Ec77C695c3391e7B9ED)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
