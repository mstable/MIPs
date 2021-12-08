---
tdp: 20.2
title: MTA/WETH Earn reward changes
status: Implemented
author: James Eddington (@jameseddington)
discussions-to: https://forum.mstable.org/t/mdp20-2-mta-weth-earn-reward-changes/423
created: 2021-03-29
---

## Simple Summary

The mStableDAO is seeking to open a discussion around the potential reduction of rewards for the MTA/WETH Uniswap pool in order to reduce the total amount of MTA being emitted, and to focus incentives upon mStable’s new Feeder pool architecture.

## Abstract

As set out in [MCCP 4](https://mips.mstable.org/MCCP/mccp-4), it has been proposed previously that MTA’s token emission can be optimised. However, whilst MCCP-4 detailed changes to mAssets (mUSD and mBTC) it did not address the rewards going to incentivising the MTA/WETH Uniswap Pool’s 2 liquidity, or Staking V1 rewards. Emissions to these two destinations account for c52% of total outgoing rewards (68,750 of 133,250 MTA each week).

## Motivation

This is being proposed as part of the broader overhaul that was started with MCCP-4, with the intention of comprehensively restructuring MTA reward incentives. This echoes the communicated desire from the Genesis team to lower MTA emission toward liquidity pools outside of the mStable ecosystem, and to refocus rewards where they produce the most utility.

It should be noted too that any loss of liquidity can be partially or fully offset by MTA/DAI liquidity bolstering from the mStableDAO treasury as outlined in [TDP 20.1](https://mips.mstable.org/TDP/tdp-20.1.html) should it be successful.

## Specification

This proposal suggests that rewards to the MTA/WETH Uniswap pool be reduces over time to some new target amount for weekly emission. This could be a round number, or a percentage of the current reward emission:

As MTA liquidity is a critical piece of the broader mStable ecosystem, it is recommended that any changes made should be considered over some sort of transition period that allows LP’s time to move their capital.

Some options are provided below to serve as examples, and begin the conversation on what a potential reduction could look like. Due to the number of variables, they do not intend to capture the full scope of possibilities, and Governors should arrive at their own conclusions about that an appropriate reduction could be:

A reduction to 50% of current weekly rewards (14,375 MTA) over a 4 week transition period
A reduction to 17,500 MTA per week over a 2 week transition period
A reduction to no rewards over an 8 week transition period

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).