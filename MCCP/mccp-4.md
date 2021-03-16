---
mccp: 4
title: Optimise MTA emission to maximise circular effects
status: WIP
author: Alex Scott <@alsco77>, Onur Solmaz <@osolmaz>
discussions-to: https://forum.mstable.org/
created: 2021-03-16
---

<!--You can leave these HTML comments in your merged MCCP and delete the visible duplicate text guides, they will not appear and may be helpful to refer to if you edit it again. This is the suggested template for new MCCPs. Note that an MCCP number will be assigned by an editor. When opening a pull request to submit your MCCP, please use an abbreviated title in the filename, `mccp-draft_title_abbrev.md`. The title should be 44 characters or less.-->

## Simple Summary

<!--"If you can't explain it simply, you don't understand it well enough." Provide a simplified and layman-accessible explanation of the MCCP.-->

_Note: This MCCP assumes a positive resolution to [MIP-9](../MIPS/mip-9)._

It has long been proposed that major optimisations can be made to the MTA emission. This MCCP proposes a major revamp; bringing all the incentives "in-house" to create better circular effects, reduce MTA sell pressure and maximise TVL.

## Abstract

<!--A short (~200 word) description of the variable change proposed.-->

The MCCP proposes that mStable:

- **a)** stop incentivising **mAsset** liquidity on third party protocols and focus entirely on Feeder Pools (e.g. tBTC/mBTC feeder pool, which has an effect of leveraging **&** giving more fees to mAsset save)
- **b)** change the rewards contracts so that X% of MTA is unlocked immediately and Y% is vested over Z months (like the current imUSD vault), with a boost for being an MTA staker
- **c)** plan and project an emission curve to reduce vote count

This MCCP interacts positively with [MIP-8](../MIPS/mip-8) and has the power to set the tokenomics on a different course: increasing mStable TVL, increasing fees to mAsset SAVE, increasing revenue to buy & make, reducing sell pressure for MTA and causing people to be MTA bulls due to the lockup and the rewards gained from being a staker.

## Motivation

<!--The motivation is critical for MCCPs that want to update variables within mStable. It should clearly explain why the existing variable is not incentive aligned. MCCP submissions without sufficient motivation may be rejected outright.-->

Goals:

- Utilise MTA to generate circular effects for mStable
- Maximise mAsset TVL
- Maximise demand for MTA
  - Reduce sell pressure for MTA
- Increase net fees going in to mAsset SAVE
- Leverage utilisation rate for mAsset SAVE

<!-- ALEX - add numbers about vs Curve & Balancer etc -->
<!-- Comparison with other emissions? -->

![Comparative emissions](../assets/MCCP-4/emissions.png)

Taken from [Aave's forum](https://governance.aave.com/t/proposal-introduce-liquidity-incentives-for-aave-v2/2340), this image shows comparative emission rates. All 4 of these projects rewarded liquidity to their own pools, rather than external platforms. This is much more powerful. In addition, it is worth noting that our

## Specification

<!--Technical rationale and specifics of the change-->

<!-- WEEK 1 numbers -->
<!-- Numbers for new mAssets (mETH, mEUR) -->
<!-- Total emission  -->

<!-- Start: 133k
 Peak: 6 months 288k
 Finish: 5 years after at 0k then inflation
 40k Needs to go to staking each week
 Of the remainder: all to mAssets, mainly mUSD and mBTC
 Internal mAsset: 80% to feeders and 20% to vault (ballpark) -->

<!--

Either include text based Levers, or use the stuff form the Hackmd etc

Levers (should probably address each of these in the specification):

- MTA emission (40m tokens roughly)
  - quantity
  - destination (feeder pool rewards contracts or imAsset vaults probably)
- buy and make revenue (main pool)
  - percentage
- governance fee (feeder pools)
  - percentage
  - destination
- rewards contract config
  - lockup + boost (like the imUSD vault at the min)
    - boost magnitude (**5x rewards for staking to leverage rwds -** this could create major demand for MTA) (e.g. 18-80% shown on the dashboard as 1-5x)
    - boost MTA required
    - % of rewards locked up (benchmark is 33%)
    - length of reward lockup (benchmark is 6 months)
  - rewards token (MTA ... or 80/20 MTA/ETH Balancer pool token)
    - When the airdrop happens, provide single sided liquidity to balancer for the 80/20 BPT
    - Rewards accrue in BPT
    - When user withdraws the reward, it simply withdraws into MTA tokens -->

| Pool allocations   | Current | Proposed (Week 1) |
| ------------------ | ------- | ----------------- |
| imBTC Vault        | 0       | XXX               |
| mBTC/ETH Sushiswap | 15000   | XXX               |
| imUSD Vault        | 12000   | XXX               |
| mUSD Curve         | 13750   | XXX               |
| mUSD/WETH Balancer | 23750   | XXX               |
| **TOT mAssets**    | 64500   | XXX               |
| MTA/WETH Uniswap   | 28750   | XXX               |
| Staking            | 40000   | XXX               |
| **TOT MTA**        | 68750   | XXX               |
| **TOT**            | 133250  | XXX               |

### Rationale

<!-- @Onur Insert epic formulas etc here -->

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
