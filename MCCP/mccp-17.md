---
mccp: 17
title: Add Vesper vaMUSD dial
status: WIP
author: Green Jeff | Vesper Finance (@jeffthedunker)
discussions-to:
created: 2022-02-10
---

## Simple Summary

It is proposed to add a dial in the [Emissions Controller](https://mips.mstable.org/MIPS/mip-24.html) for [Vesper Finance](https://vesper.finance/)’s vaMUSD Pool.
## Abstract

[Vesper Finance](https://vesper.finance/) is a DeFi super app that makes DeFi more accessible and easier to use. It offers well-audited products that simplify digital asset growth and deliver new opportunities for exposure to emerging DeFi projects and communities. The platform’s native token, [VSP](https://www.coingecko.com/en/coins/vesper-finance), incentivizes participation, facilitates governance and catalyzes user contribution.

Vesper is creating a vaMUSD pool. The initial strategy will reflect a Curve-Convex strategy: deposits are converted to mUSD-CRV liquidity and staked on Convex, with rewards auto compounding on behalf of the user.

The dial would then allow MTA Governors to direct emissions towards this Pool. Vesper Finance additionally will support this pool with VSP rewards.

## Motivation

mStable users can access yield opportunities without high gas costs or active management required to realize and compound rewards. Additional VSP + MTA rewards make this a worthwhile yield opportunity for mStable holders.

This pool will create another source of demand for mUSD outside mStable’s Save. Increasing the yield for Save, while also making liquidity in the Convex/Curve Pool more capital efficient and less complex for users.

In addition, this collaboration would strengthen the partnership between mStable and Vesper Finance that could yield more opportunities in the future. Allowing mStable products to be more widely used in the DeFi ecosystem.

## Specification

A new instance of the contract `BasicRewardsForwarder` will be deployed on Ethereum mainnet with the following parameters:

- `nexus = 0xAFcE80b19A8cE13DEc0739a1aaB7A028d6845Eb3` (Nexus contract)
- `rewardsToken = 0xa3BeD4E1c75D00fa6f4E5E6922DB7261B5E9AcD2` (MTA Deployed address)

And initialized with:

- `emissionsController = 0xBa69e6FC7Df49a3b75b565068Fb91ff2d9d91780` (Emissions Controller deployed address)
- `endRecipient = 0x963a9593C9fb4dE39C94452d3De437E8Ab1F7074` (Vesper vaMUSD Rewards Contract)

This contract receives the MTA from the Emissions Controller and forwards it to the staking contract controlled by Vesper.

This contract will then be added to the Emissions Controller as a dial:

- `Emissions Controller (0xBa69e6FC7Df49a3b75b565068Fb91ff2d9d91780)`
    - `addDial (address recipient, uint8 cap, bool notify)`
    - `recipient` = New deployed instance of `BasicRewardsForwarder` as specified above
    - `uint8 cap = 0` uncapped (only used for MTA staking contracts to cap)
    - `notify = true` will call the function to notify and process the MTA rewards upon disperse

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/)
