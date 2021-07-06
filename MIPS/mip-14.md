---
MIP: 14
title: Add MAI(miMatic)/mUSD Feeder Pool on Polygon
status: WIP
author: Dimitri Golecko (@dimsome)
discussions-to:
created: 2021-07-06
---

## Simple Summary

It is proposed to add a Feeder Pool as specified in [MIP 9](./mip-9) for [Mai Finance](https://www.mai.finance/) MAI/mUSD on Polygon. MAI is a stablecoin that is backed by USDC or borrowed for collateral such as wMATIC(wrapped MATIC).

A MAI/mUSD Feeder Pool on Polygon would offer a more capital efficient swap on Polygon compared to current swap protocols. Additionally, co-incentivization of the Feeder Pool would offer an attractive yield, and bootstrap more users to mStable on Polygon.

## Abstract

Mai Finance is a protocol that is focused on Polygon and offers a 'MakerDAO like' feature to borrow MAI against collateral. MAI can also be swapped for USDC, which is then deposited into the treasury to back the value of MAI itself.

At the time of writing, around [\$4.8 Million USD](https://app.mai.finance/analytics) has been lend and around [\$56 Million](https://app.mai.finance/analytics) is held by their [USDC Swap](https://app.mai.finance/swap). A Feeder Pool for MAI/mUSD as specified in [MIP 9](./mip-9) would offer a much more capital-efficient swap implementation, compared to the current highest TVL swap for [MAI/USDC on Quickswap](https://info.quickswap.exchange/pair/0x160532d2536175d65c03b97b0630a9802c274dad). This addition would benefit the position of mStable in the Polygon ecosystem as the go-to AMM for stablecoins, increase TVL and generate more revenue for mStable.

## Motivation

This proposal aims at increasing the utility of mStable on Polygon and at capitalizing on the combined incentives provided for this Feeder Pool. This would position mStable as the most capital-efficient swap protocol for MAI on Polygon. Currently, around $100 Million USD is deposited into the [MAI/USDC liquidity pool on Quickswap](https://info.quickswap.exchange/pair/0x160532d2536175d65c03b97b0630a9802c274dad). With this Feeder Pool, mStable could potentially acquire a portion of this liquidity by offering better swap rates, higher swap fees, and higher yield for LPs. Additionally, incentivization of this Feeder Pool would make it an attractive choice for LPs on Polygon.

With the basket Assets together, a user could easily swap from or into MAI with any of the popular stable coins on Polygon, with a much lower gas fee than on the Ethereum mainnet.

This addition would earn MTA holders, savers and, liquidity providers swap fees and help MAI to trade closer to its intended peg. After the successful initial implementation of the MAI/mUSD Feeder Pool on Polygon, more collaboration with the QiDAO Team is viable to implement use-cases for mUSD or imUSD.

## Specification

A new instance of the `FeederPool` contract will be deployed on Polygon with the following parameters:

- Name: mUSD/MAI Feeder Pool
- Symbol: fPmUSD/MAI
- Amplitude coefficient (A): 100
- Swap fee: 0.04% (4 basis points)
- Redemption fee: 0.04% (4 basis points)
- Governance fee: 10% of fees charged
- Min bAsset weight limit: 3%
- Max bAsset weight limit: 97%

The `MAI(miMATIC)` smart contract address on Polygon is `0xa3fa99a148fa48d14ed51d610c367c61876997f1`

The `mUSD` smart contract address on Polygon is `0xe840b73e5287865eec17d250bfb1536704b43b21`

This MIP grants the ProtocolDAO permission to adjust the Amplitude coefficient (A) when deemed necessary.

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
