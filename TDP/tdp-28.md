---
tdp: 28
title: Fei Protocol & Ondo Finance LaaS Opportunity
status: Implemented
author: mZeroNine (@mzero2nine)
discussions-to: https://forum.mstable.org/t/tdp-28-fei-protocol-ondo-finance-laas-opportunity/727
created: 2021-12-01
---

## Simple Summary

Fei Protocol recently [teamed up](https://medium.com/fei-protocol/if-you-are-part-of-a-dao-or-protocol-that-wants-to-create-liquidity-for-your-token-without-f49a01f02863) with Ondo Finance in order to introduce a Liquidity-as-a-Service model to the ecosystem, and it is proposed that the mStable Asset Management subDAO use this service in order to increase the liquidity of MTA via a protocol-owned MTA/FEI pool on Uniswap v2.

## Abstract

With the recent liquidation of the [MTA/DAI position](https://snapshot.org/#/mstablegovernance.eth/proposal/0xe836d35eb889e039a7d5f616d290339d874a129c3de24fb49d38b64068b578e0) on Uniswap v3, there is now a lack of a stablecoin pairing for MTA to allow for easy access and exit on Ethereum Mainnet, and it is suggested to take advantage of the offering from Fei Protocol & Ondo to create a new MTA/FEI pair on Uniswap v2 for this purpose.

A choice between 850,000, 1,000,000 and 1,250,000 MTA is proposed, which would be equally matched with FEI from Fei Protocol. It is proposed to source this liquidity by removing MTA from the existing MTA/BNT pair on Bancor ([410k MTA](https://zapper.fi/account/0x3dd46846eed8d147841ae162c8425c08bd8e1b41/protocols/ethereum/bancor)), as well as utilize the BadgerDAO loan from the Funding subDAO that is due ([400k MTA](https://snapshot.org/#/mstablegovernance.eth/proposal/QmfCWb6RxmLrLyfR4ZGzKCP6ehzafrdr3BVKJDxEnh36Np)), and source any remaining MTA directly from the mStable Treasury if required, which will depend on the MTA price at the time of deployment.

This amount will also qualify mStable to receive [additional TRIBE incentives](https://snapshot.org/#/fei.eth/proposal/0x6cb44737ef462019d65d33b4164684a6786e6c8d0222d4caa55952d067789846) from Fei Protocol, which would subsequently be deposited on [their Rari Fuse Pool](https://app.rari.capital/fuse/pool/8) to then engage in further opportunities for the Asset Management subDAO, while diversifying the treasury and building rapport with Fei Protocol for further mutually beneficial endeavours down the line.

## Motivation

In an effort to consolidate liquidity for MTA related pairs, we recently redeployed liquidity for MTA/ETH into an actively managed position on Visor Finance.

To further this idea, it is now suggested to re-allocate MTA that are already deployed in the ecosystem (namely from Bancor and the upcoming loan repayment from BadgerDAO) to create a new MTA/FEI pair on Uniswap v2 to re-enable an MTA-to-stablecoin pairing on Ethereum Mainnet that carries much better upside than the previous one.

This endeavor will also allow us to take advantage of TRIBE incentives that Fei Protocol generously disburses to ecosystem launch group participants, which the Asset Management subDAO intends to hold and utilize in perpetuity for further TRIBE rewards, and to create the ability to leverage these rewards on the Rari Fuse Pool for further asset management ventures in the ecosystem.

## Specification

### Proposed workflow

The Fei DAO will provide FEI, then invest these into an Ondo fixed tranche pool. mStable will invest MTA in the variable tranche pool from the mstable Asset Management subDAO. The Ondo Vault will then provide this liquidity together to create a FEI-MTA liquidity pool on Uniswap v2. After a fixed duration, Ondo will withdraw this liquidity, then pay back the Fei DAO its FEI plus a predetermined fixed yield. Finally, MTA will receive the remaining assets paid out in MTA.

If the LP yield more than covers the fixed yield for FEI, then MTA earns a positive yield on MTA. Even if trading fees are near zero and the underlying LP is not incentivized, then the Asset Management subDAO is effectively just paying for providing liquidity to the market, without needing to disburse any liquidity mining rewards to the ecosystem.

### Duration and Fees

It is proposed to start with four vaults with the following durations: 90 days, 83 days, 76 days, 69 days.

Fei will accept a fixed yield of 5% APR for each of these vaults (1.23%, 1.14%, 1.04%, and 0.95% for the 90d, 83d, 76d, and 69d durations, respectively).

The purpose of launching with vaults of different durations is to stagger the redemption of these vaults. At redemption, the liquidity from one vault is removed, then the Ondo smart contracts will either buy MTA with FEI or sell MTA for FEI in order to obtain exactly the amount of FEI owed to the fixed tranche investors. To minimize the market impact on the price of MTA at this redemption, we want to ensure that no single vault represents too large a percentage of the total liquidity in the pool.

### TRIBE Incentives

Fei has also approved TRIBE incentives for launch group participants for the first three months of the program. These incentives will be on the variable tranches specifically — so the MTA variable tranche in this case. The incentives scale with liquidity provided, at 10 AP per $1mm in liquidity provided by mStable. There are 2500 AP total in the Fei TribalChief rewarder. Based on current prices (as of November 18) this amounts to ~50% APY in boosted yield.

This AP is set based on the contribution from mStable, and does not scale based on later contributions from mStable community members. There are no specific plans to renew TRIBE incentives after this three month period. The total AP provided for this program is capped at 500 AP.

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
