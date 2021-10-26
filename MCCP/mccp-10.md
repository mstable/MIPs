---
mccp: 10
title: MTA emission and distribution pre Emission Controller launch
status: Implemented
author: Dimitri Golecko (@dimsome)
discussions-to: https://forum.mstable.org/t/pdp-31-mta-emission-and-distribution-pre-emission-controller-launch/660/1
created: 2021-10-04
---

## Simple Summary

It is proposed to adjust the MTA topline emission and distribution scheme after [MCCP 9](./mccp-9) is approaching expiration. This adjustment is pre Emission Controller launch and will be replaced by the Emission Controller or before that by another proposal. This proposal outlines the reduction of the topline MTA emission by 20% compared to [MCCP 9](./mccp-9) and adjustments to the distribution to different products.

## Abstract

This proposal follows directly [MCCP 9](./mccp-9) and suggests a further reduction of the topline MTA emission to 166,153 MTA weekly, a 20% reduction compared to [MCCP 9](./mccp-9). This emission reduction in comparison to earlier proposals is shown in the following figure.

![weekly-emissions](/assets/MCCP-10/weekly-emissions.png)

Following the proposed topline emission is also a breakdown of the emission towards the individual products. This new breakdown is necessary because [MCCP 7](./mccp-7) suggested carving out 20% towards polygon. Since then, the protocol has grown and Polygon has seen an increase in interest and TVL. Additionally, this is a step to increase transparency and allows MTA Governors to influence and approve distribution schemes more granular. The breakdown of the item "Vaults & Feeder Pools" to individual pools will continue to be calculated based on [MCCP 4](./mccp-4), which takes TVL and volume metrics into consideration.

| Network  | Pool                           |   MTA   |
| -------- | ------------------------------ | :-----: |
| Ethereum | Staking V2 MTA                 | 32,500  |
| Ethereum | Staking V2 mBPT                | 20,000  |
| Ethereum | Visor Finance Uniswap V3       |  5,000  |
| Ethereum | Vaults & Feeder Pools (MCCP 4) | 68,654  |
| Ethereum | Subtotal                       | 126,154 |
|          |                                |         |
| Polygon  | imUSD Vault                    | 15,000  |
| Polygon  | FRAX Feeder Pool               | 10,000  |
| Polygon  | BAL pool                       | 15,000  |
| Polygon  | Subtotal                       | 42,360  |
|          |                                |         |
| All      | Total                          | 166,154 |

## Motivation

The reward emission is a key part of the mStable ecosystem. Not only does it bind liquidity, but also rewards participation and usage of the mStable protocol - It allows protocol users to become its owners. Therefore an extension of the mentioned rewards is important to keep this momentum going and to continue to incentivise liquidity providing, staking and participation.

The reduction in emission is proposed to decrease the weekly inflation rate of MTA and to allow MTA to appreciate over the longer term. MTA holders and stakers benefit the most from a reduction of emission since sell pressure from liquidity mining can be reduced that way.

Initially, MTA generous emission schedule was designed to reward protocol users and to allow users to have a path to become its owners, contributing to the protocol and participate in its growth. This initial stage resulted in a vibrant community around mStable and gave users a path to an active governor role within the protocol. This stage is now coming to a quiet end; the effect of fostering a community by the distribution of the MTA token has diminishing returns. This is an opportune time to curb emissions further, to make MTA a more scarce asset and allow the strengthening of the community around mStable.

## Permission

This Proposal grants the ProtocolDAO permission to repurpose the MTA distribution to third-party pools, in case of co-incentives from third-party protocol cease or a better opportunity presents itself.

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/)
