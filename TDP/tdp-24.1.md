---
tdp: 24.1
title: Incentivized Liquidity Provision on Convex Finance
status: Implemented
author: mZeroNine (@mzero2nine)
discussions-to: https://forum.mstable.org/t/mdp24-1-incentivized-liquidity-provision-on-convex-finance/599
created: 2021-09-01
---

## Simple Summary & Abstract

The treasury [received over 422k DAI tokens](https://etherscan.io/tx/0xf6678b9612feb25b293c0045d6d3a8caef72d9587986cc60ebbf91a07895beab) from migrating the old DAI/MTA position on Uniswap v2 to Uniswap v3, and it is proposed that they should now be used to bolster our treasury via incentivized liquidity provision on [Convex Finance](https://www.convexfinance.com/).

The mStableDAO suggests to use the DAI tokens in the Asset Management subDAO to provide liquidity on the Convex Finance 1 platform, and regularly harvest and compound the extracted CRV & CVX tokens.

By providing liquidity on the Convex Finance platform and compounding the accumulated tokens, mStable helps maximize capital efficiency and profits for the mstableDAO, as well as enabling other potential co-benefits.

## Motivation

This proposal aims to:

1. Provide maximum capital efficiency for our idle tokens in the treasury
2. Increase TVL of the treasury over time & diversify token allocations held
3. Generate a future revenue stream with the accrued rewards by participating in fee sharing from Convex Finance by compounding both CRV and CVX rewards (on top of any other rewarded tokens)
4. Potentially use accumulated rewards to direct CRV emissions toward the mUSD pool, allowing mStable to simultaneously bootstrap its product while accruing value for the treasury.

## Specification

This proposal suggests that the 422,647 DAI currently held in the Asset Management subDAO be put into a Convex Finance liquidity position in order to begin accruing CRV & CVX (and potentially other protocol tokens from one of their liquidity pools).

In the process of commencing with this opportunity on Convex Finance, the 422,647 DAI would be provided via single-sided entry on Curve Finance, and consequently split up into the pool allocation chosen in [TDP 24.2](./tdp-24.2).

Liquidity rewards will be claimed and compounded back into the Convex Finance platform on a regular basis at the discretion of the Asset Management subDAO, which will consider and weight operational costs against accumulated rewards in the contract to make an informed and economically sound decision on the correct timing of these operations.

Successful passing of this proposal will allow the Asset Management subDAO to continue with this opportunity until the incentivization on Convex Finance ends, or a different proposal be made to change the method or utilization of the tokens in question.

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
