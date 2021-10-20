---
mip: <to be assigned>
title: Move idle alUSD in fPool to Rari Fuse Lending Markets 
status: WIP
author: derc
discussions-to: https://forum.mstable.org/t/discussion-incentivise-rari-fuse-lending-markets/665/11

created: 2021-10-20
requires (*optional): <MIP number(s)>
---

<!--You can leave these HTML comments in your merged MIP and delete the visible duplicate text guides, they will not appear and may be helpful to refer to if you edit it again. This is the suggested template for new MIPs. Note that an MIP number will be assigned by an editor. When opening a pull request to submit your MIP, please use an abbreviated title in the filename, `mip-draft_title_abbrev.md`. The title should be 44 characters or less.-->

## Simple Summary
<!--"If you can't explain it simply, you don't understand it well enough." Simply describe the outcome the proposed changes intends to achieve. This should be non-technical and accessible to a casual community member.-->
This proposal aims to increase the capital efficiency of mUSD in the alUSD Feeder Pool which currently sits idle by deploying it into Rari Fuse. Similar to MIP 11, the mUSD could be further utilized by supplying it to Rari Fuse lending markets. A future proposal could be made to move mUSD currently deposited in Iron Bank to Rari Fuse if there is sufficient demand.

## Abstract
<!--A short (~200 word) description of the proposed change, the abstract should clearly describe the proposed change. This is what *will* be done if the MIP is implemented, not *why* it should be done or *how* it will be done. If the MIP proposes deploying a new contract, write, "we propose to deploy a new contract that will do x".-->
This change will move idle mUSD currently sitting in the mUSD/alUSD Feeder Pool into Rari Fuse and enable it for borrowing, bootstrapping mUSD liquidity in Fuse. The available amount that can be deposited into Fuse lending markets is the total amount of deposited mUSD minus the `cache size` (as outlined in MIP-9 Section: Configurable Values). This allows enough mUSD to remain available for offering gas efficient swaps. At the time of writing, the `cache size` is set to 10%, but can be further adjusted with future MCCPs.

## Motivation
<!--This is the problem statement. This is the *why* of the MIP. It should clearly explain *why* the current state of the protocol is inadequate.  It is critical that you explain *why* the change is needed, if the MIP proposes changing how something is calculated, you must address *why* the current calculation is innaccurate or wrong. This is not the place to describe how the MIP will address the issue!-->
mStable assets do not have a native lending and borrowing market due to their relatively low on-chain liquidity. Protocols like Aave have minimum liquidity and trading volume thresholds for listing, and require a Chainlink oracle as a price feed
Chainlink oracles only exist for MTA, and not mAssets/imAssets due to their lack of on-chain liquidity, trading volume and CEX listing. Lending and borrowing markets are key to growth, especially for stablecoins as they allow users to obtain leverage.

## Specification
<!--The specification should describe the syntax and semantics of any new feature, there are five sections
1. Overview
2. Rationale
3. Technical Specification
4. Test Cases
5. Configurable Values
-->

### Overview
<!--This is a high level overview of *how* the MIP will solve the problem. The overview should clearly describe how the new feature will be implemented.-->
For this integration the existing contract CompoundInegration.sol can be reused just as it was reused for Iron Bank and Compound.



## Copyright
Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
