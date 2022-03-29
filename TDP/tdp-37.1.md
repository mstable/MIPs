---
tdp: 37.1
title: Addendum to Pre-approve BPT Locking & Voting for veBAL
status: WIP
author: 0xloth
discussions-to: https://forum.mstable.org
created: 2021-03-29
---

## Simple Summary

[TDP 37 (Pre-approve BPT Locking & Voting for veBAL](https://forum.mstable.org/t/tdp-37-pre-approve-bpt-locking-voting-for-vebal/837)) proposed to use staked BPT (obtained from the 80/20 BAL/WETH pool) to reward BAL rewards to our own 80/20 MTA/WETH pool.
This TDP37.1 proposes to extend the BPT staking approval to a wider array of protocols that could be built on top of the veBAL framework (i.e protocols using BPT to redirect BAL inflation rewards).

Such protocols could be liquidity rewards redirection protocols & others exotic players using the BPT/veBAL primitive.

## Abstract

The incoming veBAL wars if successful (which mStable assume will be) are very likely to see the rise of Convex/Votium-like protocols.
At inception, these new-lego pieces will seek to attract BAL stakers & Balancer Liquidity Providers (BPT holders) through aggressive Liquidity Mining campaigns.
mStable with its BPT holdings could be an early participant in these veBAL wars and choose to take advantage of these substantial and momentary liquidity mining rewards.

## Motivation

Allowing BPT locking/staking on other protocols beyond the Balancer original interface would still enable to redirect rewards towards MTA native pools while getting an extra opportunistic exposition to these platform native tokens, which could turn out to be extremely profitable.
Rewards are spread over a fixed number of epochs, very high at the beginning and divided by the number of participants per epoch. Hence, there is a strong first-mover advantage in staking first on these platforms to get a large portion of the native token rewards.

As an example, [Votium’s first round](https://llama.airforce/#/votium/rounds) was 58.82x less subscribed than the 14th one. 
This under subscription had a direct effect on the ROI early participants had on their bribes: a $ bribed on Votium was earning 6.58x higher CVX rewards during the first round compared to the 14th one
assets/TDP-37.1/votium1.png
assets/TDP-37.1/votium2.png

mStable was an early participant in Votium bribes and saw a huge spike of TVL thanks to this in November 2021:
assets/TDP-37.1/tvl1.png

## Specification

1) Analyse in-depth the potential alternatives to locking mStable BPT token holdings (contracts review, team background check, early platform adopters feedback, Balancer native team feedback) 

2) Lock current BPT allocation in Balancer staking/locking contract OR in other staking/locking protocols using BPT to redirect BAL inflation rewards

3) Delegate voting power to the [Governance Coordinator address](https://etherscan.io/address/0x908db31ce01dc42c8b712f9156e969bc65023119) to be able to participate in gauge voting

4) Use voting power to vote for the Pool(s) on Balancer OR in other staking/locking protocols using BPT to redirect BAL rewards according to the outcome of the vote

5) Compound rewards back into BPT tokens to increase gauge voting power in perpetuity

6) Compound and liquidate rewards from the *staking/locking protocols using BPT to redirect BAL rewards* on a periodic basis to increase the BAL rewards for the mStable pools

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).