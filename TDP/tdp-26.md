---
tdp: 26
title: Uniswap V3 Liquidity Redeployment
status: Implemented
author: mZeroNine (@mzero2nine)
discussions-to: https://forum.mstable.org/t/tdp26-uniswap-v3-liquidity-redeployment/694
created: 2021-11-01
---

## Simple Summary & Abstract

After [this successful internal motion](https://snapshot.org/#/mstabledao.eth/proposal/0x4c98350264c56141b6619a3a1be3f45af95baa0af1b553b73167a8341c1b5791), and in line with the [public launch](https://medium.com/visorfinance/mstable-partners-with-visor-for-management-of-treasury-assets-and-mta-eth-liquidity-positions-on-3b8a56c3bfcb) of the actively managed MTA/ETH pair on Visor Finance, the TreasuryDAO proposes to re-deploy the liquidity currently provided on the [MTA/DAI Uniswap V3 pair](https://app.uniswap.org/#/pool/57642) into more capital efficient pools in the ecosystem.

It is also suggested to inject a one-off liquidity boost of 100,000 MTA into the new pair on Visor Finance in order to ensure continued low slippage trades on Uniswap V3.

The received MTA portion from exiting the position is to be used for liquidity provision on a different AMM, which will form the basis of a subsequent TDP, and the received DAI portion of the pair is to be put into a Convex Finance position to accrue further CRV and CVX rewards for the treasury.

## Motivation

This proposal aims to:

1) Increase effectiveness of the active liquidity management provided by Visor Finance by removing our passive pairing from Uniswap V3
2) Create positive feedback effects from the newly deployed DAI in order to perpetually increase returns for all mStable Save users & mUSD liquidity providers on Curve
3) Free up additional MTA to deploy on a different AMM to further diversify the availability of MTA in the ecosystem
4) Have a potential say on proposals & the decision-making processes in the suggested protocols by holding their native governance tokens custodied by the TreasuryDAO

## Specification

This proposal suggests that the TreasuryDAO removes the entire liquidity from the existing MTA/DAI Uniswap V3 position 1, and redeploy the DAI portion of the pair on Convex Finance in the pool that receives the highest amount of votes.

The following pools will be available to be voted upon:

**3pool hedge**

[saave](https://curve.fi/saave/deposit)

[compound](https://curve.fi/compound/deposit)

**3pool native**

[susdv2](https://curve.fi/susdv2/deposit)

[frax](https://curve.fi/frax/deposit)

[alusd](https://curve.fi/alusd/deposit) (already [hodled](https://zapper.fi/account/0x67905d3e4fec0c85dce68195f66dc8eb32f59179/protocols/ethereum/convex))

In the process of commencing with this opportunity on Convex Finance, the DAI would be provided via single-sided liquidity, and consequently split up into the respective allocation of the winning pool.

All liquidity rewards will be claimed, compounded, and locked on a regular basis at the discretion of the Asset Management subDAO, which will consider and weight operational costs against accumulated rewards in the contract to make an informed and economically sound decision on the correct timing of these operations.

Since a Gnosis Safe cannot directly participate in Snapshot votes, the resulting voting power from the above deployment would thus be [delegated](https://help.gnosis-safe.io/en/articles/4820197-how-to-participate-in-a-snapshot-poll) to the Cat Herder of the Asset Management subDAO in order to participate in gauge & other votes that will result in a beneficial outcome for the mStable ecosystem, and take a passive stance on all other proposals on the platform.

A successful passing of this proposal will allow the Asset Management subDAO to continue with this operation until the incentivization on Convex Finance ends, or a different proposal replaces the method of utilization of the tokens in question.

Additionally, a total of 100,000 MTA (roughly 60% of these coming from fees the old position generated, with the remainder coming directly from the MTA portion of the position) will be injected into the [existing MTA/ETH position](https://vault.visor.finance/dashboard) on Visor Finance in order to ensure continued low slippage trades on Uniswap V3.

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).