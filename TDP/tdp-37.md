---
tdp: 37
title: Pre-approve BPT Locking & Voting for veBAL
status: Implemented
author: mZeroNine (@mzero2nine)
discussions-to: https://forum.mstable.org/t/tdp-37-pre-approve-bpt-locking-voting-for-vebal/837
created: 2021-03-23
---

## Simple Summary

It is proposed to pre-approve the locking all current and future BPT that the Asset Management subDAO custodies to be used for the upcoming veBAL Tokenomics revamp in order to direct gauge weight and subsequent BAL rewards to the 80/20 MTA/WETH pool on Balancer v2 in order to increase rewards for the mStable ecosystem.

## Abstract

The current ve-tokenomics are all the hype in the DeFi ecosystem, and Balancer is also jumping on this narrative, which does make a lot of sense given their model of BAL distribution. 

In order to be able to have our own treasury take advantage of this upcoming change, it is suggested to pre-approve our own BPTs that sit in the Asset Management subDAO and lock these token as soon as the new tokenomics release on the side of Balancer in order to enable to redirect BAL rewards to our own 80/20 MTA/WETH pool.

This is a strict improvement over our current strategy that regularly compounds all accrued BAL rewards from our 80/20 BAL/WETH pool back into the position and leaves the BPT sitting idle in our multisig wallet. 

Instead, we would now perpetually lock these BPT into the new staking contract and direct the gauge voting power into the 80/20 MTA/WETH pool, which will increase BAL rewards over time to this pool.

Regarding the [MTA/WMATIC/WETH Pool](https://polygon.balancer.fi/#/pool/0x614b5038611729ed49e0ded154d8a5d3af9d1d9e00010000000000000000001d) on Polygon, there remains some slight uncertainty around if the Polygon MTA/WMATIC/WETH pool should be included in the strategy for our veBAL strategy as well.

BAL rewards on Polygon do not directly benefit the treasury, nor the BPT Meta Governors' BAL allocation, but do passively benefit the ecosystem by incentivizing the Polygon pool with additional BAL on top of the inflationary MTA rewards from the Emissions Controller it already receives.

Therefore, the following options for allocation will be presented in the formal vote: 

- Delegate to Ethereum Pool Only
- Delegate to Polygon Pool Only
- Delegate to both Pools (75% ETH / 25% Polygon)
- Delegate to both Pools (50% ETH / 50% Polygon)
- Delegate to both Pools (25% ETH / 75% Polygon)
- Delegate to Neither / Different Strategy

## Motivation

The mStable Asset Management subDAO currently holds roughly 450,000 mUSD worth of 80/20 BAL/WETH BPT, and is compounding 100% of these rewards back into the position. With the release of the updated veBAL tokenomics model, leveraging this position further by locking all accrued BPT in their staking contract for the maximum amount of time (1 year) will give the multisig the ability to direct BAL rewards directly to our native 80/20 MTA/WETH pool and thus increase BAL rewards for for all MTA BPT stakers in our own ecosystem, which is a great value accrual mechanism for MTA itself and gives an additional incentive to stake MTA on this position.

## Specification

1.) Lock current BPT allocation in Balancer staking/locking contract

2.) Delegate voting power to the [Governance Coordinator address](https://etherscan.io/address/0x908db31ce01dc42c8b712f9156e969bc65023119) to be able to participate in gauge voting

3.) Use voting power to vote for the Pool(s) on Balancer according to the outcome on the vote

4.) Compound rewards back into BPT token to increase gauge voting power in perpetuity

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).