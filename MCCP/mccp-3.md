---
mccp: 3
title: Increase Save liquidator's weekly USD contribution
status: WIP
author: James Eddington <@jameseddington>
discussions-to: https://forum.mstable.org/t/pdp16-increase-save-liquidators-weekly-usd-contribution-mccp-3/370
created: 2021-03-01
---

<!--You can leave these HTML comments in your merged MCCP and delete the visible duplicate text guides, they will not appear and may be helpful to refer to if you edit it again. This is the suggested template for new MCCPs. Note that an MCCP number will be assigned by an editor. When opening a pull request to submit your MCCP, please use an abbreviated title in the filename, `mccp-draft_title_abbrev.md`. The title should be 44 characters or less.-->

## Simple Summary

<!--"If you can't explain it simply, you don't understand it well enough." Provide a simplified and layman-accessible explanation of the MCCP.-->

This mStable Configuration Change Proposal (MCCP) proposes increasing the maximum amount of COMP, AAVE and other lending platform tokens earned via SAVE that can be liquidated each week. The current maximum is 5,000 USD worth of tokens each week. It is proposed to change this parameter to a value somewhere in the range between 10,000 -20,000 USD worth of tokens liquidated weekly.

Numbers out side of this range can also be put forward should community feedback make a strong case for the change.

## Abstract

<!--A short (~200 word) description of the variable change proposed.-->

As defined in [MIP-2](https://mips.mstable.org/MIPS/mip-2.html)reward tokens (such as $COMP, $LEND) that have accrued in the mStable protocol are liquidated, with proceeds being used to bolster the Save product's USD APY. This works through a liquidator mechanism that currently liquidates c.5,000 USD worth of tokens per week.

These reward tokens that have accrued to the protocol have increased in market value since the original MIP, and now represent a more sizeable total USD value pool that can be liquidated. On top of this, it is expected that the protocol will earn tokens from other platforms such as Aave.

It is proposed to increase the liquidation amount to capitalise on these increased price levels while the market is in a favourable position. This will bolster the Save APY, and mean that concurrent proposals seeking to channel some of these Save APY flows to destinations other than savers (such as the Buyback and Make pool) will have a minimal impact on yields.

## Motivation

<!--The motivation is critical for MCCPs that want to update variables within mStable. It should clearly explain why the existing variable is not incentive aligned. MCCP submissions without sufficient motivation may be rejected outright.-->

This has been proposed by the ProtocolDAO as its signers believe that now is an opportune time to bolster Save APYs whilst mStable engages in more aggressive growth strategies. These strategies, such as a Buyback and Make pool detailed in [MIP-8](https://mips.mstable.org/MIPS/mip-8.html), will draw down from flows that were previously going to Savers.

This MCCP is motivated by a desire to pursue these long term growth strategies that benefit mStable as a protocol whilst minimising Save APY dilution.

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
