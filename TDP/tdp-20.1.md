---
tdp: 20.1
title: Use of the mStableDAO treasury to bolster DAI/MTA liquidity
status: Implemented
author: James Eddington (@jameseddington)
discussions-to: https://forum.mstable.org/t/mdp20-1-use-of-the-mstabledao-treasury-to-bolster-dai-mta-liquidity/422
created: 2021-03-29
---

## Simple Summary

The mStableDAO is proposing that it uses some of its treasury balance to create a DAI/MTA pool on Uniswap, which would bolster MTA liquidity, and offset any reductions to rewards for the MTA/WETH pool being proposed as [TDP20 .2](https://mips.mstable.org/TDP/tdp-20.2.html).

## Abstract & Motivation

This proposal aims to:

Provide deeper markets for MTA to reduce slippage during trades
Increase the capital efficiency of the mStableDAO’s treasury by using it to improve MTA liquidity
Generate some fee revenue for the mStableDAO in a market neutral fashion (given existing exposure to MTA)
Help offset any MTA liquidity loss from any reductions in MTA/WETH rewards as detailed in [TDP 20.2](https://mips.mstable.org/TDP/tdp-20.2.html).

It should be noted that if this proposal is successful, the MTA and DAI contributed would be subject to impermanent loss.

DAI has been chosen here as the USD pair due to its decentralisation, and the fact it is what’s currently held by the DAO. Other USD pegged stablecoins could be considered, but it should be noted that swapping out the DAI will incur slippage costs.

With the announcement of Uniswap V3, this proposal should be revisited in future to optimise for the new flexibility and design parameters offered by the upgrade.

This proposal should be considered alongside [TDP 20.2](https://mips.mstable.org/TDP/tdp-20.2.html), however can be implemented independent of any changes to EARN rewards. We look forward to feedback from Meta Governors.

## Specification

This proposal suggests that the c.2.34m DAI currently held in DAO reserves is put into a Uniswap pool with a matching amount of MTA (currently c.810k MTA at current price of $2.90). This would create a total liquidity pool of $4.68m in depth, and leave c.2.4m mUSD as the remaining USD balance in the treasury.

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).