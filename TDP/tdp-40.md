---
tdp: 40
title: Uniswap v3 Liquidity Deployment
status: Implemented
author: mZeroNine (@mzero2nine)
discussions-to: https://forum.mstable.org/t/tdp-40-uniswap-v3-liquidity-deployment/854
created: 2021-04-18
---

## Simple Summary

It is proposed to deploy a protocol-owned MTA/WETH position on Uniswap v3, as the current LaaS incentive from Ondo Finance is coming to an end and has proven to be less effective than anticipated.

It is suggested to deploy in a range that allows us to enter the position with 100% MTA, and have the pair slowly convert to ETH as MTA appreciates in value over time.

## Abstract

Since we began thinking more about Protocol Controlled Value (PCV), we tried several different options, including [Ondo Finance’s LaaS](https://forum.mstable.org/t/tdp-28-fei-protocol-ondo-finance-laas-opportunity/727), as well as [Gamma Strategies actively managed Uniswap v3 position](https://forum.mstable.org/t/proposal-reallocate-public-uniswap-v2-mta-rewards-to-managed-visor-finance-position/567).

We came to the conclusion that Ondo Finance’s offer is very heavily dependent on a stable performance of MTA, while the Gamma Strategies offer is only slowly receiving MTA via the dial from our Emissions Controller.

Previously, we also directly competed with Gamma Strategies due to our own MTA/DAI pairing and arrived at the conclusion that deploying our own MTA/WETH pair on Uniswap v3 makes sense. This move will also stop the competing aspect of these pairs, and instead have them work together for a deeper liquidity offering.

As Gamma offers relatively tight ranges, we would deploy this new pair with a larger range to ensure constant liquidity, while also avoiding selling off any more MTA below a certain threshold.

Based on [these](https://forum.mstable.org/t/rfc-uniswap-v3-liquidity-take-2/822/11) findings by dimsome, an entry in this position at the upper range of around 7381 MTA per ETH is proposed (which can and will be re-adjusted just before entering the position based on the MTA/WETH price at the time of deployment to allow for single-sided entry) and a lower range set to 1130 with a fee of 1%. 

The Asset Management subDAO will deploy the position using 1,000,000 MTA funded from the TreasuryDAO and will have the liberty to re-adjust the range once per quarter if this economically sensible.

## Motivation

In order to keep our liquidity in-house and not spend incentives to get a third party to deploy on our behalf, we have previously consulted with different protocols to do this on our behalf, with varying success.

Given the track record, we believe it is most wholesome for the mStable project to once again deploy our own liquidity on Uniswap v3 and consolidate the current effort with Gamma Strategies one very strong and liquid pair, with easy entry and exit opportunities across the DeFi ecosystem.

The manual process involved combined with the unavoidable realization of some impermanent loss from Ondo Finance made us understand that their offer is currently too risky, given the economic and geopolitical sentiment we have today.

Instead, we will solve this issue once and for all with a bullish range deployment of MTA on Uniswap v3, which also will give the treasury a lot of upside exposure to ETH, and will eventually arrive at the position owning only ETH, which can then be further utilized in the space as we deploy an even more bullish fresh MTA position on Uniswap v3, and at which stage the Gamma position should hold a much healthier portion of MTA [than is currently the case](../assets/TDP-40/gamma-mta.png).

## Specification

1.) Send 1,000,000 MTA from the TreasuryDAO to the Asset Management subDAO

2.) Determine the current upper range at the time of deployment and use that range and a low range of 1130 MTA/ETH

3.) Deploy the position at slightly above (+0.1%) the determined upper range to allow for single-sided entry

4.) Re-adjust the range once per quarter if deemed necessary and economically viable

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).