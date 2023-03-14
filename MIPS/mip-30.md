---
mip: 30
title: mStable Governance Path Resolution
status: WIP
author: mZeroNine (@mzero2nine), Cam Soulsby (@camsoulsby), Dimitri Golecko (@dimsome)
discussions-to: https://forum.mstable.org
created: 2023-03-14
---

## Simple Summary

It is proposed to summarize the different MIPs resulting from [MIP 29](./mip-29), put them to a vote, and define the exact procedure and next steps of governance moving forward for each potential case.

## Abstract

The mStable project is at a crossroad in moving forward, and this MIP seeks to consolidate all formal proposals in the forum into one vote to determine which of the available options should be taken to determine the path forward for the project and the DAO overall. 

It is proposed to put a Ranked Choice voting in place on Snapshot to decide which option be the winning path forward for the project.

Currently, the following options will be included in the MIP: 

- mStable Product sunset if proposals to continue are rejected
- Continuation via a merger with or acquisition by another protocol as outlined below

Each of these options will be briefly overviewed, and steps unique to each highlighted in the Specifications section.

## Motivation

As per [MIP 29](./mip-29), a vote needs to take place to determine which path Meta Governors would like to see the mStable project take, and this MIP will serve as a final voting destination to decide which path the DAO and project should pursue moving forward.

## Specification

Since each proposed voting option carries with it a unique set of parameters and approaches, a detailed breakdown of steps and overview of each of the voting options is given, consolidated from each of the respective MIPs, with some minor additions in regards to MIP 31, as some operational concerns were not part of that MIP. 

### Option 1: Acquisition by dHEDGE

It is proposed that all of mStable’s current products, which are uncompetitive in yield, are migrated to ~20% APY offered by [Toros Finance](https://toros.finance/) stable yield strategies. This would boost the mStable TVL immediately and offer better returns. The Toros Finance yield strategies can then become mStable vault strategies. Further information can be found in [this](https://forum.mstable.org/t/rfc-dhedge-acquisition-of-mstable/1002) forum post.

*The reference to the RFC will later be updated and linked to the respective MIP*

### Option 2: Merger with Spool DAO

It is proposed that mStable is merged into Spool DAO. All MTA holders will be able to swap their MTA tokens to SPOOL tokens and, therewith, become members of a growing and sustainable community/DAO with complementary products to what mStable is currently offering. Further information can be found [here](https://forum.mstable.org/t/rfc-mstable-merge-into-spool-dao/1005).

*The reference to the RFC will later be updated and linked to the respective MIP*

### Option 3: Merger with Idle Finance

It is proposed to merge the Idle DAO and mStableDAO and ecosystems while preserving stakeholders, partners, and products on both sides. The goal is to leverage existing resources and amplify potential outcomes. The nature of the offer involves a token swap from MTA to IDLE. This will result in the transfer of mStable treasury assets to the Idle DAO, as well as potential transition of product focus, team migration, and consolidation of the respective product suites into a single one. Further information can be found [here](https://forum.mstable.org/t/rfc-idle-mstable-merge/1006).

*The reference to the RFC will later be updated and linked to the respective MIP*

### Option 4: Acquisition by Origin Protocol

It is proposed that Origin Protocol acquires mStable assets and key team members. MTA holders will be able to swap their tokens for governance tokens from Origin. The exact exchange rate will be determined later, but will be primarily based on the value of mStable’s treasury. The current strategy is to update the backing strategies of mUSD to use OUSD instead. We will be continuing to investigate the feasibility of this plan and welcome feedback and ideas from the community. Further information can be found [here](https://forum.mstable.org/t/rfc-origin-acquisition-of-mstable/1008).

*The reference to the RFC will later be updated and linked to the respective MIP*

### Option 5: mStable Product Shutdown (per MIP 31) and MTA Sunset (pending resolution of ongoing governance proposal)

If MTA Governors decide on a shutdown of mStable products, the Builder subDAO will immediately move to execute a product shutdown as defined in [MIP 31](https://mips.mstable.org/MIPS/mip-31.html) and any MTA sunset and DAO shutdown that might be decided on through the [ongoing governance proposal on that topic](https://forum.mstable.org/t/rfc-future-of-mstable-treasury-assets/999/9). In this scenario, the product shutdown is expected to be completed by the end of April 2023. Timelines for any MTA and DAO shutdown will be defined in that governance proposal.

Assuming that a vote is finalized before April 1st, hosted frontend apps and customer support will be available until the 30th of September, 2023.

###Shutdown costs###
To allow MTA Governors to make the best decision on the path forward, the Builder subDAO has tried to accurately estimate the costs of executing a product shutdown and potential MTA sunset & DAO shutdown. 

The main cost will be in compensating all team members through to the end of their full-time agreements in mid-April, and in compensating 8 critical teams members after that date to ensure that they are incentivised to see the shutdown through until the end and paid for part-time work over a 6-month support period, during which time they will be involved in:

- Finalising the execution of product shutdown
- Assisting with any DAO shutdown proposal
- Communicating with community and ensuring accurate information and withdrawal guides will be available on an ongoing basis
- Providing user support to ensure a smooth user experience around withdrawals
- Responding to technical issues
- Maintaining the required frontend apps
- Providing operational support around maintaining services and shutting down the Builder subDAO

The total of all future costs for the Builder subDAO after April first is estimated at $215,000. This includes around $44,000 for regular salary costs through to the end of current full time agreements, and $171,000 for costs over the following 6 months. 

### SubDAO Funding

In each of the scenarios detailed above, there will be ongoing costs for the Builder subDAO, either in executing a shutdown as defined above, or in facilitating the transition and shutdown of the Builder subDAO in any of the merger or acquisition scenarios. Since these costs will vary and are yet to be fully defined in some cases, it is proposed as part of this MIP that the Builder subDAO is funded for April as previously approved in [TDP 52](https://mips.mstable.org/TDP/tdp-52.html), with a modified mandate to execute on whatever outcome is chosen by MTA Governors and/or work with any potential merger or acquisition partner to manage transition costs. In each scenario, it is expected that there will be a surplus at the end of April which will be returned to the TreasuryDAO. The Builder subDAO is committed to returned as much of this funding as is possible to the treasury in each scenario.

The Ecosystem subDAO will also be wrapping up current contributor agreements in mid-April with part-time customer support to provided by one contributor after that date. Since the Ecosystem subDAO was previously funded for the full period of January-April 2023, surplus funds will be returned in April.

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
