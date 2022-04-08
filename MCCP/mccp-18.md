---
mccp: 18
title: Add Idle Finance dial for 3pool PYT
status: Approved
author: Davide_IdleDAO
discussions-to:
created: 2022-03-09
---

## Simple Summary

It is proposed to add an Idle Finance Convex protocol (mUSDcrv) Perpetual Yield Tranches (PYTs) dial.

## Abstract

Idle DAO developed 2 products based on mStable ecosystem in Ethereum:

- mStable PYTs, tranching the “Save” vault, where users can deposit mUSD tokens.
- Convex PYTs, tranching mUSD pool, where users can deposit mUSDcrv Curve LP tokens.

In short, Junior Tranches TVL covers Senior Tranches in case of losses, but they leverage Senior Tranches TVL to receive APYs higher than the underlying yield source.
A wider range of users can deploy mUSD in the Save vault or increase the liquidity of mUSDcrv Curve pool through Convex – with Senior/Junior Tranches, they are now able to adjust their deposit depending on their risk profile.

This proposal suggests adding one dial for the Convex PYTs to receive additional MTA rewards and to incentivise this Junior Tranche.

## Motivation

Idle DAO launched a “Tranches Battle” and selected mUSD as one of the contest winners. This resulted in the development of [PYTs using mUSD pool on Convex](https://gov.idle.finance/t/tranches-battle-choose-which-asset-integrate-next/896/23?u=davide). The integration has been completed, and is ready to be launched. It’s already visible on the [Beta page](https://beta.idle.finance/#/dashboard/tranches).

In addition, Idle DAO [approved the launch of Gauges](https://gov.idle.finance/t/introducing-idle-gauges-model-for-tranches/913) to reward Senior Tranches with $IDLE farming (initially at 990 IDLE/day). mUSDcrv PYTs will be eligible to benefit from these streams.

The support for the Senior Tranches of mUSDcrv PYTs in MTA dial will allow mStable to incentivize Curve pool liquidity, enabling users to adjust their liquidity deployment to their risk profile.

_PYTs features_
With Perpetual Yield Tranches, LPs can earn a higher share of yield by taking more risk (with **Junior Tranche**), or they can hedge risk by depositing their assets into an inherently protected tranche (with **Senior Tranche**). Senior Tranches have a first lien on the assets — they’re in line to be repaid first, in case of default.

PYTs are:

- Epochless, flexible, with no locking periods: you can deposit or withdraw your liquidity at any time;
- Fully fungible and composable ERC-20: other DeFi protocols and integrators can offer tailored products based on PYTs;
- High-quality yield-bearing collateral: the built-in fund protection mechanism available on Senior Tranches makes them more resilient against default scenarios and can benefit from higher LTV.

_About PYTs_
Idle launched PYTs in [late December](https://medium.com/idle-finance/make-yield-your-own-perpetual-yield-tranches-are-live-2aef53c153d6), after 4 months of guarded launch. Idle PYTs’ smart contracts have been audited by two different professional auditing firms before the release (Consensys Diligence and Certik). All the related and previous audits for the Idle protocol are available [here](https://docs.idle.finance/developers/security/audits).

_About Idle_
Idle DAO is a decentralized organization that builds financial infrastructure for Web3. Businesses of every size – from brand new DeFi protocols to public companies – use our protocol to optimize capital efficiency and manage their treasuries with DeFi.

We believe that everyone deserves the best for their idle funds, both in terms of returns and risks. Since 2019, Idle has rolled out the features and services that allowed us to battle-test our products
throughout the years and become one of the most resilient protocols in the space.

To learn more about our products and services:

- [Perpetual Yield Tranches](https://docs.idle.finance/products/perpetual-yield-tranches)
- [Best Yield strategy](https://docs.idle.finance/products/max-yield)

## Specification

A new instance of the contract `BasicRewardsForwarder` will be deployed on Ethereum mainnet with the following parameters:

- `nexus = 0xAFcE80b19A8cE13DEc0739a1aaB7A028d6845Eb3` (Nexus contract)
- `rewardsToken = 0xa3BeD4E1c75D00fa6f4E5E6922DB7261B5E9AcD2` (MTA Deployed address)

And initialized with:

- `emissionsController = 0xBa69e6FC7Df49a3b75b565068Fb91ff2d9d91780` (Emissions Controller deployed address)
- `endRecipient = TODO: To be deployed staking contract address``

This contract receives the MTA from the Emissions Controller and forwards it to the staking contract controlled by Idle Finance.

This contract will then be added to the Emissions Controller as a dial:

- `Emissions Controller (0xBa69e6FC7Df49a3b75b565068Fb91ff2d9d91780)`
  - `addDial (address recipient, uint8 cap, bool notify)`
  - `recipient` = New deployed instance of `BasicRewardsForwarder` as specified above
  - `uint8 cap = 0` uncapped (only used for MTA staking contracts to cap)
  - `notify = true` will call the function to notify and process the MTA rewards upon disperse

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/)
