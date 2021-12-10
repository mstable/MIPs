---
tdp: 31
title: Pre-Approve MTA for Market Making
status: WIP
author: James Eddington (@jameseddington), mZeroNine (@mzero2nine)
discussions-to: https://forum.mstable.org/
created: 2021-12-10
---

## Simple Summary

After [$mUSD](https://www.coingecko.com/en/coins/mstable-usd) was listed on Coinbase last month, it has become apparent that any major CEX listing of mStable assets need also to be accompanied by a market making service to ensure liquidity for that asset on launch day. This is a requirement from the exchanges as a pre-condition to listing on their platforms.

With this in mind, it is proposed to earmark the use of up to 2,000,000 MTA from the TreasuryDAO to serve as a loan to a trusted Market Maker should MTA get listed on a major centralised exchange. The term of this loan would be for a window of service during the first few months of bootstrapping MTA liquidity for that specific CEX.

## Abstract

When mUSD got listed earlier last month on [Coinbase Pro](https://pro.coinbase.com/trade/MUSD-USD), there was a request by the exchange to provide sufficient liquidity for the trading pair. This was provided to a Market Maker on very short notice and with significant overhead by the core contributor team.

In order to avoid any similar bottlenecks in the future, it is proposed to earmark up to 2,000,000 MTA from the TreasuryDAO to loan out to trusted Market Makers over a previously agreed amount of time in order to bootstrap the MTA market on the exchange in question.

A major exchange is classified as a Top 10 exchange in the ecosystem, e.g. [Binance](https://www.binance.com/en), [Coinbase](https://www.coinbase.com/), [Kucoin](https://www.kucoin.com/), etc...

A major market maker is classified as a Top 10 trusted party in the ecosystem, e.g. [Wintermute Trading](https://www.wintermute.com/), [Kairon Labs](https://kaironlabs.com/), [Alameda Research](https://www.alameda-research.com/), [GSR](https://www.gsr.io/), etc...

If approved, these funds would be sent to the Funding subDAO, so that they can be deployed quickly should the need arise.

## Motivation

Historically, when a new market is opened on a major CEX, a certain amount of liquidity needs to be provided by professional market makers in the ecosystem. Since we do not know the exact time and date if or when MTA will get listed, we should prepare ahead of time, as failure to provide a sufficiently liquid market could result in a delisting from the exchange.

## Specification

### Proposed workflow

1.) The earmarked MTA will be sent to the [mStable Funding subDAO](https://etherscan.io/address/0xfcf455d6eb48b3289a712c0b3bc3c7ee0b0ee4c6) upon resolution of the vote.

2.) A market maker deemed trustworthy by the mStable core contributor group will be selected for this venture prior to the CEX listing taking place and be announced once selected in the [official forum](https://forum.mstable.org/).

3.) Upon listing on the CEX, the earmarked MTA will be sent to the previously selected Market Maker for a window of service until the market is deemed established by the core contributor group, and then returned back to the Funding subDAO.

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).