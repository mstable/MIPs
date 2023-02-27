---
mccp: 25
title: Increase Governance Fee Flow to Treasury
status: Implemented
author: mZeroNine (@mzero2nine),  Dimitri Golecko (@dimsome),  Cam Soulsby (@camsoulsby)
discussions-to: https://forum.mstable.org/t/mccp-25-increase-governance-fee-flow-to-treasury/929
created: 2022-08-25
---

## Summary

It is proposed that 100% of protocol revenue be directed to the treasury to provide an easier path to profitability and ensure that building long-term value is prioritized over short-term payouts to MTA stakers.

## Abstract

Before the launch of the [Emissions Controller](https://medium.com/mstable/mstable-launches-emissions-controller-173db81e5a1b) last year, the protocol used to deposit the governance fee revenue towards the [Buyback & Make](https://mips.mstable.org/MIPS/mip-8.html) pool on Balancer.

Since then, the DAO decided to reroute these governance fees to [purchase MTA](https://dune.xyz/queries/357907) directly off the market and distribute to stakers. This left the treasury and protocol with no organic way of capturing revenue and accruing value back to the treasury, and thus called into action an initial overhaul of the fee flow in [MCCP 20](https://mips.mstable.org/MCCP/mccp-20.html) in order to redirect 50% of these fees back towards the TreasuryDAO.

It is now suggested to increase this fee flow to 100% in order to ensure a sufficient perpetual runway for the protocol. Once this has been achieved, additional revenue can be considered to be redirected back to stakers.

As previously mentioned, it is suggested to increase the fee flow from all sources, which will also include the upcoming Convex Meta Vault and any future vaults until another proposal is made to alter this fee flow model.

Since stakers are already receiving a substantial amount of inflationary MTA rewards through the [Emissions Controller](https://staking.mstable.org/#/dials), enough incentivization to stake will be left for Meta Governors to ensure continued participation in the ecosystem.

## Motivation

As mStable’s treasury is still [heavily allocated in native governance tokens](https://zapper.fi/account/gnosis.mstabledao.eth), the DAO has to ensure means and ways on how the protocol will continue tho thrive in creating a sustainable business model towards profitability.

The DAO initially granted stakers 50% of the protocol fee revenue (in form of additional MTA streamed into the staking contract) on top of the inflationary MTA rewards from the Emissions Controller dials.

It is now proposed that rewarding stakers with inflationary MTA rewards singularly through the Emissions Controller is a valid and sufficient way to incentivize Meta Governors to stake their tokens, as well as make allocations on the Emissions Controller that would not deviate away significantly from the current allocations they’re currently making.

Additionally, increasing governance fee flow to the treasury will allow for further asset management opportunities, which will ultimately increase the value of MTA by growing mStable’s treasury.

## Specification

The functionality to split the revenue is part of the contract `RevenueSplitBuyBack` deployed on Ethereum Mainnet:

- [0x0E423505A4EB417a75b21f7A35E84ae378e665b9](https://etherscan.io/address/0x0E423505A4EB417a75b21f7A35E84ae378e665b9#writeContract)

The [ProtocolDAO multisig](https://gnosis-safe.io/app/eth:0xF6FF1F7FCEB2cE6d26687EaaB5988b445d0b94a2/home) will queue the following transaction to set the Treasury fee to 100% (effectively removing distribution of revenue to stakers):

- `setTreasuryFee(_treasuryFee)`
  - `_treasuryFee = 1000000000000000000` (1e18)
  - `1e18 = 100%`

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
