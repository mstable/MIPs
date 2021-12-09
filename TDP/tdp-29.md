---
tdp: 29
title: DAO 2 DAO Swap - Balancer
status: Proposed
author: Théo Clochard (@LDeroccha), mZeroNine (@mzero2nine)
discussions-to: https://forum.mstable.org/
created: 2021-12-01
---

## Simple Summary

It is proposed to engage in a swap opportunity with [Balancer Finance](https://balancer.fi/), arising from the upcoming launch of [mStable's Emission Controller](https://mips.mstable.org/MIPS/mip-24.html).

An amount of 20k BAL against the equivalent USD value worth of MTA is to be considered for this swap, which would then be used to enter into the [80/20 BAL/ETH](https://app.balancer.fi/#/pool/0x5c6ee304399dbdb9c8ef030ab642b10820db8f56000200000000000000000014) pool on Balancer. At current prices, it would represent roughly a $400k swap.

Both protocols also agree to hold the swapped position for a minimum of 1 year from the date of the swap.

## Abstract

mStable is about to release its version of the Gauge controller, inspired from Curve's, which will dictate rewards distribution over the next 6 years (~30m MTA).

As we speak, two Balancer pools are receiving MTA rewards:

- One on Mainnet ( [MTA / WETH Balancer pool](https://app.balancer.fi/#/pool/0xe2469f47ab58cf9cf59f9822e3c5de4950a41c49000200000000000000000089) )
- One on Polygon( [MTA/WETH/WMATIC Balancer pool](https://polygon.balancer.fi/#/pool/0x614b5038611729ed49e0ded154d8a5d3af9d1d9e00010000000000000000001d) )

Balancer & mStable have been maintaining a long-standing relationship: mStable was one of the first user of Balancer in August 2020 and had the biggest pool at some point there.

It is thought that it would be highly mutually beneficial for the Balancer and mStable Treasury DAOs to perform a DAO<>DAO token swap:

- mStable would get exposure to a blue-chip DeFi project as well as diversify its treasury. Moreover, BAL has strong utility within the DeFI ecosytem: mStable could opt to leverage them in several ways.
- Balancer would get a MTA position and could vote for their pools with the Emission Controller. Balancer would then direct higher rewards that will inevitably attract more liquidity (i.e Total Value Locked) to its pools.
- Both protocols could choose to stake the exchanged tokens. They would be then eligible for subsequent boosts in rewards

## Motivation

DAO<>DAO swaps are very strong market signals and often represent significant amounts of money: Balancer [recently swapped $9m worth of BAL with FEI](https://medium.com/balancer-protocol/balancer-dao-commits-to-dao-agreement-and-token-swap-with-fei-dao-in-unprecedented-move-fbedda688236).

Therefore, we think swapping 20k BAL against the equivalent USD value of MTA is an amount that would reflect both the longstanding relationship mStable has with Balancer and the strong optimism felt towards the BAL token.

### Why now?

- The Convex /Curve way of getting inflation is becoming very competitive and unaffordable. This swap (in the Emission Controller framework) would showcase that there exists a cheap and effective way to make Liquidity Pools more attractive
- Having Balancer as a lead for the first epochs would send a clear and strong bull signal to the market
- Balancer swapping MTA against its own token is very likely to hold its position. It would create long-holding use cases for MTA
- This is an opportunity to go a step further with shared governance as well as a nice way to do a joint marketing campaign highlighting both protocols

### Treasury Considerations

The mStable DAO treasury has approximately [5m of liquid MTA](https://etherscan.io/address/0x3dd46846eed8d147841ae162c8425c08bd8e1b41) that's available to be deployed. It is acknowledged that this DAO<>DAO initiative with the Emission Controller could represent an important share of the current treasury, especially were other partners to also be interested in a swap

It is proposed to use the Emission Controller to redirect inflation rewards back to the mStable DAO Treasury and "reimburse" the total amount allocated for this operation over time. This will require high, weekly coordination within the community and mStable's stakeholder group.

Furthermore, we will use the swapped tokens in further asset management opportunities to earn yield and offset the temporary expenditure of tokens

## Specification

_a) Swapped amounts and origination_

- 20k BAL against the equivalent USD value worth of MTA were agreed upon for this swap
- MTA tokens would be sent from the mStable Treasury Asset Management subDAO (`0x67905d3e4fec0c85dce68195f66dc8eb32f59179`) to the Balancer Treasury DAO (`0x10A19e7eE7d7F8a52822f6817de8ea18204F2e4f`)
- BAL tokens would be sent from the Balancer Treasury DAO (`0x10A19e7eE7d7F8a52822f6817de8ea18204F2e4f`) to the mStable Treasury Asset Management subDAO (`0x67905d3e4fec0c85dce68195f66dc8eb32f59179`)

_b) Timeline and swap execution_

This TDP will go to a Snapshot vote on the side of mStable on the 6th of December, and resolve on the 10th of December. Balancer voting will start at 7am EST Dec 6th, and resolve 7am EST Dec 9th and execution extendend until the 10th of December, so that both protocols have the same voting window.

Swap execution: Tokens will be swapped on-chain from the 13th of December onward, and the 1 year holding time will begin at the time the tokens from the transfer enter the wallet of the corresponding DAO.

_c) Pricing method and price feeds_

It has been agreed to use a 30-days smooth average. The time window for the 30 days average would be from the 10th of November until the 10th of December 2021.

MTA Price feed: MTA/ USD [(Chainlink)](https://market.link/feeds/1ce7ead3-6466-4bdc-8f0c-0d5509820a0f)

BAL Price feeds: BAL/USDT ([Binance](https://www.binance.com/en/trade/BAL_USDT))

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
