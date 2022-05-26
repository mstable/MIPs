---
tdp: 36
title: DTOP Liquidation
status: Implemented
author: mZeroNine (@mzero2nine)
discussions-to: https://forum.mstable.org/t/tdp-36-dtop-liquidation/831
created: 2021-03-14
---

## Simple Summary

It is proposed to liquidate the position the Asset Management subDAO [holds in DTOP](https://zapper.fi/account/0x67905d3e4fec0c85dce68195f66dc8eb32f59179) and swap this token for CVX, as with the recent unlock of all staked CVX there exists now a very opportune time to enter this particular ecosystem and benefit from having voting power on the platform towards perpetually incentivizing the mUSD/3crv pool to benefit liquidity providers and Save users alike.

## Abstract

It has now been almost 1 year since we swapped [200,000 mUSD with dHEDGE](https://forum.mstable.org/t/dao-treasury-management/416) in order to gain an index token which tracks the Top 10 Fund Managers on the dHEDGE platform. 

Over time, this asset has underperformed to all our other holdings, and with the [current market selloff of CVX](https://twitter.com/kamikaz_eth/status/1499771796803186689?s=21) it presents a very opportune time to exchange this asset for oversold CVX to benefit our own ecosystem in perpetuity.

## Motivation

We originally agreed to the swap from dHEDGE because it seemed like a great way to hedge risk by betting on the best Fund Managers there, while also getting the upside of a lazy governance approach in that the token more or less manages itself, and with us only claiming rewards once in a while.

The reality has been different, and the asset has underperformed compared to simply holding one or any of the underlying assets in the treasury that the managers rebalanced on our behalf. 

It is therefore suggested to liquidate this position, and use the resulting liquidity to market buy CVX token to vote on the mUSD/3crv gauge and direct CRV & CVX rewards to this pool. This also directly benefits save users, as more mUSD will be incentivized to deploy liquidity on Convex instead of Save. 

## Specification

1.) Exit the DTOP position [via dHEDGE](https://app.dhedge.org/pool/0x0f4c00139602ab502bc7c1c0e71d6cb72a9fb0e7)

2.) Swap sUSD for CVX via [CowSwap](https://cowswap.exchange/#/swap)

3.) [Lock resulting CVX on Convex](https://www.convexfinance.com/lock-cvx)

4.) Delegate voting power to the [Governance Coordinator address](https://etherscan.io/address/0x908db31ce01dc42c8b712f9156e969bc65023119) to be able to participate in Snapshot voting

5.) Vote for the mUSD/3crv gauge in perpetuity to delegate ecosystem rewards to this pool

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
