---
mccp: 5
title: Migrate DAI and WBTC to Aave v2
status: WIP
author: Dimitri Golecko <@dimsomedim>
discussions-to:
created: 2020-04-26
---

## Simple Summary

The mStable's SAVE product consistently generates attractive yield for its users. With the recent announcement from Aave to introduce liquidity mining into their lending protocol a new opportunity for the generation of a higher yield becomes available.

This MCCP proposes to move DAI and WBTC to the [Aave v2](https://aave.com/) lending protocol. DAI is currently deposited in [Compound](https://compound.finance/), while WBTC is not deposited in any lending protocol. This proposal seeks to increase the overall yield on interest bearing mAssets, due to higher yields on Aave v2 and in addition to make use of the liquidity mining to earn staked AAVE (a.k.a stkAAVE). The proceeds of that earned asset will go towards interest bearing mUSD (imUSD) and interest bearing mBTC (imBTC) asset holders. The exact handling of the earned stkAAVE will be specified in a future MIP.

## Abstract

With this proposal the deposited DAI would migrate from Compound to Aave v2. WBTC is currently not deposited in any lending platform and is therefore free to be deposited into Aave v2.
proc
Aave is launching a liquidity mining program and is incentivizing deposits. This would earn the protocol stkAAVE that can then be liquidated. The proceeds can be distributed towards the interest bearing mAsset holders. On a positive resolution of this MCCP, a functionality to unstake stkAAVE, to liquidate the resulting AAVE-tokens and to distribute to the SAVE contract will be introduced in a future MIP.

## Motivation

Aave announced to launch a liquidity mining program for its v2 protocol. This MCCP seeks to increase the capital efficiency of the mStable's SAVE product. The DAI that is currently in Compound will earn a higher yield in Aave and earn additionally the stkAAVE token.

WBTC is currently in no lending protocol deposited. The capital efficiency can be increased by depositing WBTC to Aave v2, earning a yield on the asset and participating in the liquidity mining program to earn stkAave.

This will increase the yield that can be generated and the mStable's SAVE products becomes even more attractive to investors. This can have a positive effect on the overall TVL of the mStable ecosystem. In addition this step would benefit the MTA token holders by extracting a portion of the additional yield and using the generated revenue in the Buyback&Make Strategy that was introduced with [MIP-8](../MIPS/mip-8).

Overall, this MCCP seeks to increase yield, benefitting both the users of the mStable's SAVE and MTA token holders.

## Specification

This MCCP would use the existing functionality that is available in the currently deployed mAsset smart contracts.

The following two transactions would be made by the mStable ProtocolDAO multisig wallet:

- Call `migrateBassets` function on mUSD (`Masset.sol`) and migrate DAI to `AaveV2Integration.sol`
- Deploy an mBTC specific `AaveV2Integration.sol` contract and call `migrateBassets` function on mBTC (`Masset.sol`) to migrate WBTC to this integration contract

Following this, stkAAVE will be farmed and distributed via the `Liquidator.sol`

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/)
