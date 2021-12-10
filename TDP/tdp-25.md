---
tdp: 25
title: Olympus Pro Treasury Diversification
status: Implemented
author: mZeroNine (@mzero2nine)
discussions-to: https://forum.mstable.org/t/tdp25-olympus-pro-treasury-diversification/686
created: 2021-10-22
---

## Simple Summary

The mStable treasury still mainly consists of MTA tokens, and after [this successful internal motion](https://snapshot.org/#/mstabledao.eth/proposal/Qmexd4q2N99KbrC5WiTUHX9VAuopGC7RJjbjJFAprobsZU), the TreasuryDAO would now like to diversify its treasury by leveraging the [Olympus Pro](https://pro.olympusdao.finance/#/bond) platform in order to sell MTA bonds for Curve mUSD/3pool LP tokens deposited on Convex Finance [(cvxmusd3CRV)](https://etherscan.io/token/0xd34d466233c5195193df712936049729140dbbd7) on the open market.

## Abstract & Specification

This proposal suggests that the Asset Management subDAO allocates 1,000,000 MTA on Olympus Pro in order to sell MTA bonds for Curve mUSD/3pool LP tokens deposited on Convex Finance [(cvxmusd3CRV)](https://etherscan.io/token/0xd34d466233c5195193df712936049729140dbbd7).

These would subsequently be staked on Convex Finance, and accrued CRV rewards from these tokens would be converted into cvxCRV, whereas CVX would be directly staked on Convex Finance in order to be used to vote for the mUSD gauge on Curve in perpetuity.

As an additional change to [TDP 24](./tdp-24.1), all accrued CVX and CRV rewards from the existing alUSD position would also be handled in the same fashion as described above in order to maximize gauge voting potential on Curve moving forward.

All liquidity rewards will be claimed, compounded, and locked on a regular basis at the discretion of the Asset Management subDAO, which will consider and weight operational costs against accumulated rewards in the contract to make an informed and economically sound decision on the correct timing of these operations.

Since a Gnosis Safe cannot directly participate in Snapshot votes, the resulting voting power from the above deployment would thus be [delegated](https://help.gnosis-safe.io/en/articles/4820197-how-to-participate-in-a-snapshot-poll) to the Cat Herder of the Asset Management subDAO in order to participate in the gauge votes, and would take a passive stance on all other proposals on the platform.

A successful passing of this proposal will allow the Asset Management subDAO to continue with this operation until the incentivization on Convex Finance ends, or a different proposal replaces the method of utilization of the tokens in question.

## Motivation

This proposal aims to:

1) Diversify the token allocation of the treasury to more stablecoins, and put liquidity into custody of the TreasuryDAO
2) Create positive feedback effects from the revenue generated in order to constantly increase returns for all mStable Save users
3) Create a symbiotic relationship with PDP33 1 to lock in and accumulate as much CRV and CVX tokens as possible to increase voting power for the mUSD gauge on Curve Finance during and after the execution of the bribe centric config
4) Have a potential say on proposals & the decision-making processes in the suggested protocols by holding their native governance tokens custodied by the TreasuryDAO

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).