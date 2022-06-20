---
tdp: 43
title: Gamma Liquidity Migration
status: Proposed
author: mZeroNine (@mzero2nine)
discussions-to: https://forum.mstable.org/t/tdp-43-gamma-liquidity-migration/880
created: 2022-06-01
---

## Simple Summary

It is proposed to let Meta Governors decide on the future of the actively managed liquidity on Uniswap v3 for the [MTA/ETH pair on Gamma](https://v1.gamma.xyz/). 

The first option would have the position upgraded to Gamma v2 to provide tighter ranges and better liquidity management overall, whereas option two would liquidate the existing position and return the resulting MTA and ETH to the TreasuryDAO.

## Abstract

Gamma has recently upgraded some of their pairs to v2 (essentially providing a better overall strategy), and it is now time to decide what to do with our current Gamma v1 position. Currently, we are engaged with Gamma by having a MTA/ETH pair deployed on their platform which is actively managed by them to provide concentrated liquidity on Uniswap v3.

With the upgrade to their next version and with some initial concerns around the usability of this position brought up by the community, a vote should now take place on how to proceed with this opportunity moving forward.

Upgrading the position will require a migration of the existing position from v1 to v2 to be executed by the Gamma team.

Sunsetting of the opportunity will require the removal of the Emissions Controller dial (which is already underway in [MCCP-22](https://forum.mstable.org/t/mccp-22-disable-underutilized-dials/875)), as well as claiming the position back from Gamma to the TreasuryDAO once the dial has been removed.

For more information regarding what Gamma has planned for 2022, please see [this](https://medium.com/gamma-strategies/gammas-immediate-road-map-audits-strategies-liquidity-venues-and-market-making-c81db904d7a0) dedicated blog post.

## Motivation

With the [recent critique](https://forum.mstable.org/t/rfc-uniswap-v3-liquidity-take-2/822/6) brought up by [dimsome](https://forum.mstable.org/u/dimsome) on the effectiveness of the liquidity on Gamma, and the timely arrival of the upgraded version of Gamma and it’s new features, it is now time for Meta Governors to decide on how to proceed with this opportunity for the foreseeable future.

Since we recently [deployed our own liquidity](https://app.uniswap.org/#/pool/242082?chain=mainnet) on Uniswap v3, we should now come to consensus on whether or not we wish to continue receiving actively managed liquidity by a 3rd party provider or not.

## Specification

1.) Depending on vote outcome, Gamma will either upgrade our Uniswap v3 position to v2 of Gamma, or liquidate the position and send the resulting MTA and ETH tokens back to the [TreasuryDAO](https://etherscan.io/address/0x3dd46846eed8d147841ae162c8425c08bd8e1b41).

2.) Meta Governors can decide what the next steps should be with the resulting MTA and ETH in case option 2 is the winning option.

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).