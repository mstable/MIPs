---
mccp: 6
title: Reduce Swap Fees to Bootstrap Users
status: WIP
author: Cold Summer
discussions-to: 
created: 2021-05-17
---


## Simple Summary

This mStable Configuration Change Proposal (MCCP) proposes reducing mStable’s swap fee of mAssets (mUSD and mBTC) to 0.02% from the current swap fee of 0.06%. Since the new AMM no longer offers zero slippage, our key competitive advantages lie in (1) reflexivity and (2) composability. Reducing swap fees to bootstrap users allows mStable to unlock and leverage these two competitive advantages.


## Abstract

As outlined in [MIP-7](../MIPS/mip-7), the new AMM enables greater scalability and composability by removing the old Constant Sum Market Maker (CSMM) design, creating bAsset weightings, and introducing feeder pools. Leveraging the host of advantages offered by this new design meant abandoning the CSMM zero slippage feature. Despite this change, swap fees currently remain at 0.06%. Given that the new AMM is designed to operate at scale, the Protocol DAO should focus on limiting barriers to entry for users to achieve this scale. It is proposed to decrease the swap fee to 0.02% to bootstrap a larger userbase and drive swap volume. Swap volume drives Save APY and attracts more Save liquidity. Userbase and Save growth unlock greater opportunity for liquidity pool integrations, driving the utility and composability of imUSD as collateral. Composability and utility generate network effect. Network effect leads to long-term value accrual and user stickiness even in a low emission environment.

“Success” of this proposal would be defined as increasing mStable Protocol volume while maintaining the same or greater levels of daily average fee revenue after a 3-month trial period as compared to pre-proposal levels. If after this period, this condition is not met, then this proposal should be re-evaluated.


## Motivation

User acquisition cost is a key component of the modern network-driven economy. The common pathway many successful DeFi platforms have followed is:

1. Develop an innovative product.
2. Lower barriers to entry & subsidize users → bootstrap the network & generate a network effect.
3. Focus on capturing value from the network.

While mStable has an innovative, capital-efficient product, having a swap fee higher than Curve and Uniswap v3 inhibits network growth and creates a barrier to entry for users. A higher swap fee implies focus on value capture from the network, which at this stage of the Protocol, is inconsistent with the pathway outlined above. Lowering swap fees to 0.02% would enable mStable to offer a material discount to Curve (0.04%) and Uniswap (0.05%).

Since mStable is not the incumbent leader in the stablecoin swap space, dropping swap fees below competition would manufacture a marketable attribute to attract users and drive swap volume. mStable does not necessarily need to outcompete these incumbents in their market vertical, since their brand is “swap-first” and mStable’s brand is “composability-first.” However, imAssets are effectively composable, capital-efficient LP tokens that accrue 90% of platform fees back to Save depositors (effectively LPs) via a simple, clean UX, whereas Curve diverts 50% of fees.

With that perspective, mStable positions itself to attract liquidity through increased swap volume by lowering fees and communicating that lower fee structure with a marketing campaign. Significantly greater swap volume, even at a lower swap fee, will generate more fees in aggregate. 

For context, mStable on Ethereum currently generates approximately $4.5 million per day in swap volume at a 0.06% fee. Therefore, growing to $13.5 million per day in swap volume would represent “break-even” fee generation if a 0.02% fee is adopted. Curve processes approximately $250 million in daily swap volume, so capturing even 4% of Curve’s daily volume through a lower fee structure would generate more aggregate fees for mStable. More fees drive Save APY higher, reflexively leading to the minting of more mAssets and imAssets.

As more mAssets and imAssets are minted by a growing userbase, mStable is better positioned to achieve integrations with leading liquidity platforms and CEXs because the Protocol can prove demand for these integrations by communicating the scale of the addressable userbase to these platforms. Once more broadly integrated, imAssets can truly leverage their composability as interest-bearing collateral, reflexively leading to more minting of imAssets as now the assets have greater utility. With this utility, comes network effect. From there, the Protocol can shift focus toward value accrual once its network effect has been solidified. 

Again, this feedback loop all starts with building the userbase to prove to liquidity platforms/CEXs that there is demand for integration. And building the userbase boils down to lowering barriers to entry by reducing swap fees, effectively an upfront spend on user acquisition to kick off this virtuous cycle.

This MCCP is motivated by a desire to leverage the inherent reflexivity within mStable’s product design and new AMM, initiate the next growth phase for mStable, and enhance the Protocol’s long-term network effect, user stickiness, and value accrual.


## Specification

This MCCP would use the existing functionality that is available in the currently deployed mAsset smart contracts: `contracts/masset/versions/MV2.sol`. 

The following two transactions would be made by the mStable ProtocolDAO multisig wallet:

1. For mBTC: Call `setFees` on address `0x69AD1387dA6b2Ab2eA4bF2BEE68246bc042B587f` with the parameter `_swapFee` set to `0.0002*1e18`
2. For mUSD: Call `setSwapFee` on address `0xE0d0D052d5B1082E52C6b8422Acd23415c3DF1c4` with the parameter `_swapFee` set to `0.0002*1e18`


## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/)
