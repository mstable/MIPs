---
mip: 17
title: Add mUSD/RAI Feeder Pool
status: Implemented
author: Stefan Ionescu (@stefanionescu)
discussions-to:
created: 2021-10-11
---

## Simple Summary

It is proposed to add an mUSD/RAI Feeder Pool as specified in [MIP 9](./mip-9) on Ethereum mainnet. RAI is a non-USD pegged stablecoin. This Feeder Pool would be the first of its kind since it allows to swap two stable assets that are not same-priced and offer efficient swaps with a Feeder Pool.

## Abstract

The Reflexer community adapted the mStable Feeder Pool code to handle a non-pegged stablecoin like RAI. This change adapts the feeder contracts to handle RAI by keeping the mechanism used to adjust the precision of fAssets but updating the ratio whenever it’s used rather than only setting it during initialisation. The updates are performed by reading RAIs redemption price and using it as a scaling factor on the original ratio set by the precision.

Furthermore, due to the new custom Feeder Pool mechanism, it is proposed to deploy this in a guarded launch. To reduce the demand, the MTA incentives will be caped for the first few weeks. Starting with a max amount of 1000 MTA for the first week and doubling every week until the MTA amount is fully accounted for that would be allocated under the distribution scheme with [MCCP 4](https://mips.mstable.org/MCCP/mccp-4.html) and [MCCP 10](https://mips.mstable.org/MCCP/mccp-10.html).

## Motivation

The Reflexer community adapted the mStable Feeder Pool code to handle a non-pegged stablecoin like RAI. This change adapts the feeder contracts to handle RAI by keeping the mechanism used to adjust the precision of fAssets but updating the ratio whenever it’s used rather than only setting it during initialisation. The updates are performed by reading RAIs redemption price and using it as a scaling factor on the original ratio set by the precision.

Furthermore, due to the new custom Feeder Pool mechanism, it is proposed to deploy this in a guarded launch. To reduce the demand, the MTA incentives will be caped for the first few weeks. Starting with a max amount of 1000 MTA for the first week and doubling every week until the MTA amount is fully accounted for that would be allocated under the distribution scheme with [MCCP 4](https://mips.mstable.org/MCCP/mccp-4.html) and [MCCP 10](https://mips.mstable.org/MCCP/mccp-10.html).

## Specification

Due to the varying price difference between RAI and the mUSD underlying stablecoins a new contract was developed to handle price adjustments.

A new instance of this custom Feeder Pool contract `NonPeggedFeederPool.sol` contract will be deployed with the following parameters:

- Name: mUSD/RAI Feeder Pool
- Symbol: fPmUSD/RAI
- Amplitude coefficient (A): 100
- Swap fee: 0.04% (4 basis points)
- Redemption fee: 0.04% (4 basis points)
- Governance fee: 10% of fees charged
- Min bAsset weight limit: 3%
- Max bAsset weight limit: 97%
- RAI integration: RAI has a market on AaveV2, the contract `AaveV2Integration.sol` will be used allowing to earn native lending yield and stkAAVE rewards.
- mUSD integration: none initially, integration can be added later.

The `mUSD` smart contract address is `0xe2f2a5c287993345a840db3b0845fbc70f5935a5`

The `RAI` smart contract address is `0x03ab458634910aad20ef5f1c8ee96f1d6ac54919`

The address `fAssetRedemptionPriceGetter` will be set to `0x07210B8871073228626AB79c296d9b22238f63cE`. This contract exposes the redemption price of RAI via the Reflexer Labs contract: `RedemptionPriceSnap.` The function for updating the price `_updateBassetData()` has been added to the custom Feeder Pool contract to update the price before each action.

A new instance of the contract `BoostedDualVault` for the vault for the mUSD/RAI Feeder Pool will be deployed to accommodate dual rewards with the following parameters:

- Name: v-mUSD/RAI fPool Vault
- Symbol: v-fPmUSD/RAI

## Permissions

This MIP grants the ProtocolDAO permission to adjust the Amplitude coefficient (A) when deemed necessary.

Additionally, an Iron Bank integration (or any other Integration that was approved by a previous proposal) can be added later, when deemed beneficial.

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
