---
mccp: 21
title: Stake BPT staked in mStable into Balancer Staking contracts
status: Draft
author: derc (@derc)
discussions-to: https://forum.mstable.org/t/rfc-stake-bpt-staked-in-mstable-into-balancer-staking-contracts/
created: 2022-04-12
---

## Simple Summary

It is proposed to upgrade mStable’s staking contracts to support staking MTA/ETH BPT tokens currently staked on mStable into Balancer’s new staking contracts for continued BAL LM rewards

## Abstract

Balancer has [launched veBAL](https://medium.com/balancer-protocol/vebal-is-live-aeda1ae13e20) with a new set of staking contracts where Balancer LPs must now stake their LP Tokens (BPTs, Balancer Pool Tokens) to continue to receive liquidity mining incentives.

mStable governors staking the 80/20 MTA/ETH BPT tokens in the staking contract do not enjoy new BAL emissions, which the mStableDAO is currently voting for the pool from the rewards from the [token swap previously announced](https://medium.com/balancer-protocol/mstable-and-balancer-dao-announce-treasury-swap-e0b031b2387d) with Balancer and other veBAL holders voting for MTA/ETH pool.

It is proposed to upgrade the staking contracts to support BPT tokens currently staked in mStable to be further staked into Balancer’s new staking contracts for liquidity mining incentives, currently with fully automated BAL minting and inflation schedule locked.

Note that mStable’s MTA/ETH pools on Balancer currently receive [~0.8% of voting power](https://app.balancer.fi/#/vebal) rewards, and possibly more in future when Convex-esque platforms like [Aura Finance](https://forum.balancer.fi/t/proposal-allowlist-aura-finance-in-balancer-votingescrow/2708) launch and bribes are implemented in future.

## Motivation

MTA/ETH stakers taking part in mStable’s governance can continue receiving BAL LM rewards which have transitioned into a staking model. Furthermore, continued LM rewards will support or increase buy pressure to support MTA’s token price, and upside to MTA secondary market price would support our own LM incentives and ecosystem.

## Specification




## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/)
