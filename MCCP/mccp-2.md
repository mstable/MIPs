---
mccp: 2
title: Reduce cache size to 2%
status: Implemented
author: Alex Scott <@alsco77>
discussions-to: https://forum.mstable.org/t/mccp-2-reduce-cache-size-to-2/333
created: 2021-01-26
---

<!--You can leave these HTML comments in your merged MCCP and delete the visible duplicate text guides, they will not appear and may be helpful to refer to if you edit it again. This is the suggested template for new MCCPs. Note that an MCCP number will be assigned by an editor. When opening a pull request to submit your MCCP, please use an abbreviated title in the filename, `mccp-draft_title_abbrev.md`. The title should be 44 characters or less.-->

## Simple Summary

<!--"If you can't explain it simply, you don't understand it well enough." Provide a simplified and layman-accessible explanation of the MCCP.-->

A number of users have highlighted an issue with mint/swap/redeem. When trying to swap 'out' sUSD, and you will get an error "Error during estimation execution reverted: There is not enough liquidity available to redeem".

This is due to the [Cache](https://mips.mstable.org/MIPS/mip-3) attempting to reset the raw basket assets to the optimal levels. Aave does not have enough available sUSD to withdraw from its lending market: [https://app.aave.com/markets](https://app.aave.com/markets) given a high utilisation rate.

The proposed change is to reduce the cache size from 10% to 2%, to enable a smaller amount of sUSD to be withdrawn.

## Abstract

<!--A short (~200 word) description of the variable change proposed.-->

The mUSD cache keeps a certain proportion of each bAsset in raw form (e.g. sUSD, not on Aave), to make mint/swap/redeem cheaper with that asset. When the cache goes to 0, it tries to reset itself to x% of total supply (in this case \$1.6m USD) in raw sUSD by redeeming asUSD (read more [here](https://mips.mstable.org/MIPS/mip-3)). There is not enough available liquidity to do this at the moment on Aave.

**This is nothing to be concerned about and all funds are safe**. AAVE are planning to disable borrowing, so this will mean that loans gradually get repaid and liquidity frees up.

In the short term we propose a significant reduction to the size of our cache size so that most withdrawals are unblocked.

Setting the cache to 2% would free it up and allow it to operate under relatively normal circumstances, keeping between 0-740k USD in the cache at any one time. Still supporting low gas cost transactions, but putting a larger quantity of assets into the lending market to capture yield.

## Motivation

<!--The motivation is critical for MCCPs that want to update variables within mStable. It should clearly explain why the existing variable is not incentive aligned. MCCP submissions without sufficient motivation may be rejected outright.-->

The motivation is to free up the basket and allow swaps to happen with the highly utilised assets. As such, it is quite urgent.

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
