---
mip: 13
title: Add Frax/mUSD Feeder Pool on Polygon
status: Approved
author: Dimitri Golecko (@dimsome)
discussions-to: https://forum.mstable.org/t/pdp-26-add-frax-musd-feeder-pool-on-polygon/524
created: 2021-06-21
---

## Simple Summary

It is proposed to add a Feeder Pool as specified in [MIP 9](./mip-9) for [Frax Finance](https://frax.finance/) Frax/mUSD on Polygon. Frax describes itself as the "first fractional-algorithmic stablecoin". A Frax Feeder Pool on Polygon would offer an efficient swap on Polygon that is yet unmatched and benefit mStable as the first mover with this experimental asset. Additionally, a co-incivitization of the Feeder Pool would offer an attractive yield, and bootstrap more users to mStable on Polygon.

## Abstract

Frax is a protocol that describes itself as the "first fractional-algorithmic stablecoin". This means, that the minimum collateral ratio is driven algorithmically. A user can mint Frax with USDC and FXR (Frax Share). The amounts that are needed to mint and/or burn Frax is determined by the demand for Frax (the price). More details can be found in the [Frax documentation](https://docs.frax.finance/).

This Pool would be the first Feeder Pool implementation on Polygon and together with Frax there is the possibility to offer liquidity mining. Since its inception, Frax has held consistently the peg on Ethereum mainnet [around 1 USD](https://www.coingecko.com/en/coins/frax) and only deviated by about ±0.01 USD. On Polygon, however, the liquidity is not as deep as compared to Ethereum mainnet and the swap is only available via [Quickswap](https://info.quickswap.exchange/token/0x104592a158490a9228070e0a8e5343b499e125d0) and SushiSwap, resulting in higher slippage and higher price deviation. The mStable swap is a much more capital efficient implementation and can potentially generate the majority of swap volume for Frax on Polygon. This would potentially benefit the position of mStable in the Polygon ecosystem.

## Motivation

This proposal aims at increasing the utility of mStable on Polygon and at capitalizing the combined incentives provided for this Feeder Pool. This would position mStable as the most capital efficient swap protocol for Frax on Polygon.

Frax is mainly deployed on Ethereum mainnet, the protocol has at the time of writing around [\$250 Million](https://defillama.com/protocol/frax) locked in value. There are currently around [10 Million Frax circulating on Polygon](https://polygonscan.com/token/0x104592a158490a9228070e0a8e5343b499e125d0), with the majority being deposited in SushiSwap. With mStable, the capital deposited into the Feeder Pools would offer much lower slippage and increase the capital efficiency for liquidity providers greatly. This would result in mStable generating the majority of swap volume for Frax on Polygon. With the basket Assets together, a user could easily swap from or into Frax with any of the popular stable coins on Polygon, with a much lower gasfee than on Ethereum mainnet and a better price potentially than current swap solutions on Polygon.

This step would earn MTA holders, savers and, liquidity providers swap fees and help Frax to trade closer to its intended peg. After the successful initial implementation of the Frax/mUSD Feeder Pool on Polygon and after sufficient demand, a Frax/mUSD Feeder Pool on Ethereum mainnet would be proven viable.

## Specification

A new instance of the `FeederPool` contract will be deployed on Polygon with the following parameters:

- Name: mUSD/Frax Feeder Pool
- Symbol: fPmUSD/Frax
- Amplitude coefficient (A): 100
- Swap fee: 0.04% (4 basis points)
- Redemption fee: 0.04% (4 basis points)
- Governance fee: 10% of fees charged
- Min bAsset weight limit: 3%
- Max bAsset weight limit: 97%

The `Frax` smart contract address on Polygon is `0x104592a158490a9228070E0A8e5343B499e125D0`

The `mUSD` smart contract address on Polygon is `0xe840b73e5287865eec17d250bfb1536704b43b21`

This MIP grants the ProtocolDAO permission to adjust the Amplitude coefficient (A) when deemed necessary.

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
