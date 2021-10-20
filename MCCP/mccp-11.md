---
mccp: 11
title: Bribe centric config set
status: Proposed
author: Alex Scott (@alsco77)
discussions-to: https://forum.mstable.org/t/pdp-33-bribe-centric-config-set/669
created: 2021-10-12
---

## Simple Summary

It is proposed to modify system configuration for a 6 week period, specifically the `govFee` and `RevenueRecipient` for `mUSD`, to redirect a predefined percentage of system revenue to [Votium](https://votium.app/) in order to capitalise on the under-utilised vote bribing market and generate circular effects for `mUSD`.

## Abstract

This proposal is based on the following pieces of information:

- Curve emits huge rewards each week, distributed proportionately to votes on their [gauges](https://dao.curve.fi/gaugeweight)
- Current mStable yield farming methods are inefficient and produce a low ROI for the protocol
- It is possible to "bribe" `veCRV`/`cvxCRV` voters to vote for a specific gauge. This effectively allows for very **high leveraged yield farming** opportunities due to the huge CRV emission

mStable trialed this for one week with a $9k bribe through [https://votium.app/](https://votium.app/) (targeting all `cvxCRV` votes) and seen mUSD supply in the `mUSD-3Crv` pool increase from 1.2 - 14m.

Source 1: [https://curve.fi/musd](https://curve.fi/musd)

Source 2: [https://twitter.com/VotiumProtocol/status/1447550501109829633](https://twitter.com/VotiumProtocol/status/1447550501109829633)

This proposal seeks to provide a set of experimental configurations that allow mStable to fully capitalise on this opportunity. This will be done in coordination with a large initial injection of $MTA, to ensure that the initial TVL is high and this configuration has sufficient network effects to take effect.

## Motivation

As defined in the abstract, current mStable yield farming methods are inefficient. This proposal seeks to generate circular effects for mUSD without the use of the existing `$MTA` emission.

mStable is in a unique position, because when the mUSD supply rises, so does the system revenue. **The system can then use this revenue (collected in `$mUSD`) to buy $MTA and to fund the next batch of bribes.** This causes a **positive feedback loop** that can grow `$mUSD` supply (until the market becomes 3-4x more saturated, however even after this point, the bribes should still cause the TVL to float high).

- Having higher system revenue will have knock on effects to SAVE, increasing the TVL and user base there independently
- This should have positive effects on the `$MTA` price as our overall network effects will dramatically increase

The bribe market is still unsaturated/inefficient. This [is changing](https://twitter.com/VotiumProtocol/status/1447537117165506561) and is likely to get more saturated in the coming weeks, so capitalising asap is important.

## Specification

A new `IRevenueRecipient` will be deployed, with the following features:

- ability to deposit `$MTA` into Votium, once per two weeks
- configurable `bribePct` variable, that determines the % of `$mUSD` held to be deposited into a child `IRevenueRecipient` (could be used for sending surplus bribe $ to for example buy CVX for longer term farming)
- configurable `IRevenueRecipient`, initially set to be the existing [Buy & Make pool depositor](https://etherscan.io/address/0xa7824292efdee1177a1c1bed0649cfdd6114fed5)

The following settings will be changed:

- `setSavingsRate` will be called with `5e17` on SavingsManager, setting the percentage of system revenue set aside to be 50% (note: this requires an upgrade to SavingsManager)
- `setRevenueRecipient` will be called, setting the `mUSD` Revenue Recipient to be the above
- Swap and Redemption fee on `mUSD` will be changed to `4e14` and `20e14` respectively
- Caps will be removed on the `Liquidator` for the `mUSD` integrations (note: there is currently less than the existing cap available, so this in effect has no change)

During this period, `mUSD` system revenue from Feeder Pools and Polygon will also flow to the new `IRevenueRecipient` by default.

Should the parameter set seem to be operating poorly during this period, resulting in a net negative revenue for SAVE (i.e. mUSD TVL goes below $60m), the `savingsRate` will be updated with a relative amount, between 10% (existing) and 50% (proposed).

Start date will be immediately following successful resolution of this proposal, and **last for 6 weeks**, after which time the settings will be reverted.

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/)
