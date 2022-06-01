---
tdp: 42
title: Continue Loan to Market Maker Supporting Coinbase mUSD Listing
status: WIP
author: Cam Soulsby (@camsoulsby)
discussions-to: https://forum.mstable.org/t/tdp-42-continue-loan-to-market-maker-supporting-coinbase-musd-listing/874
created: 2022-05-26
---

## Simple Summary

It is proposed that 1,000,000 mUSD be sourced from the mStable Asset Management subDAO to maintain a 1,000,000 mUSD interest-free loan to [KBIT](http://www.kbit.com), a market maker supporting mUSD liquidity on [Coinbase](https://www.coinbase.com/price/mstable-usd). The loan is currently provided on a short-term basis from pre-approved project funding from the mStable Funding subDAO, as well as through a loan from an investor.

## Abstract

In November 2021, an offer arose to have mUSD listed on Coinbase. This was seen as a great opportunity but came with an unforeseen requirement to almost immediately provide an interest-free loan to a professional market maker to support the liquidity of the mUSD/USD pair on the platform. At the time, the core team and Funding subDAO signers made the decision to support this listing of mUSD by lending 2,000,000 mUSD to a market maker called [KBIT](https://www.kbit.com/).

This was achieved by lending 500,000 mUSD from pre-approved project funding, which was idle in the mStable Funding subDAO, along with a short-term loan of 1,500,000 mUSD from an investor.

In February 2022, the total amount loaned to KBIT was reduced to 1,000,000 mUSD and the loan from the investor reduced to 500,000 mUSD.

1,000,000 mUSD is currently seen as the minimum liquidity requirement to retain the mUSD listing on Coinbase. A short-term trial of only 500,000 mUSD led to price volatility that was unacceptable to Coinbase.

A decision to stop providing this interest free-loan would therefore result in mUSD being de-listed from Coinbase.

## Motivation

The 1,000,000 mUSD currently loaned to the market maker is financed through the use of pre-approved project funding and a loan from an investor, which are not seen as sustainable sources of funds moving forward for the following reasons:

1.) The 500,000 mUSD loan from the investor is borrowed at an annualized interest rate of 10%. Since this is more than is currently generated on stablecoins in the Asset Management subDAO, it would make sense to repay this loan and use treasury assets to support the loan instead.

2.) The approved project funding that has been used to finance the other 500,000 mUSD was available primarily because expenditure was below budget over the last year. However, to safely see the project funded through until the end of June 2022 and allow time to plan for future funding, these funds will need to be returned to the Funding subDAO before the end of June.

Therefore, to maintain the mUSD listing on Coinbase on an ongoing basis, 1,000,000 mUSD will need to be sourced from treasury reserves.

Maintaining liquidity on Coinbase is seen as a valuable use of treasury funds in the short-to-medium term, as it offers benefits for the mStable ecosystem and will help to build and maintain a positive relationship with Coinbase.

Longer term, the value of continuing to provide this loan to maintain the mUSD listing should be reevaluated in line with mStable’s future strategy and product direction.

## Specification

It is proposed to convert $1,000,000 of the saave position [on Convex](https://zapper.fi/account/0x67905d3e4fec0c85dce68195f66dc8eb32f59179/protocols/ethereum/convex) into DAI, which would then be deposited into Alchemix allowing 500,000 alUSD to be borrowed and swapped to mUSD. Additionally, a further 500,000 mUSD would be sourced by liquidating the remaining saave position and by utilizing a small amount of DAI from the Treasury if required.

1,000,000 mUSD would then be transferred to the mStable Funding subDAO. 500,000 mUSD would be used to immediately pay back the loan to the investor, and the remaining 500,000 mUSD would be used to replenish the pre-approved project funding.

The 1,000,000 mUSD loan to KBIT can be recalled within 48 hours notice if the funds are required for other uses and/or the decision is made to stop supporting mUSD liquidity on Coinbase.

As part of this proposal, it is also suggested that the TreasuryDAO be given discretionary power to recall the loan and delist mUSD if the benefits are no longer seen to outweigh the opportunity cost and risk. This will avoid the need for another full governance proposal in the case that this is deemed appropriate, and therefore may reduce operational workload in the future.

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
