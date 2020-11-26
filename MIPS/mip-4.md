---
mip: 4
title: Batch yield collection to reduce SAVE gas costs
status: Approved
author: Alex Scott <alex@mstable.org>
discussions-to: https://forum.mstable.org/t/mip-4-batch-yield-collection-to-reduce-save-gas-costs/230
created: 2020-10-30
---

## Simple Summary

<!--"If you can't explain it simply, you don't understand it well enough." Simply describe the outcome the proposed changes intends to achieve. This should be non-technical and accessible to a casual community member.-->

Currently the yield produced from lending markets Compound/Aave is collected upon
each deposit into SAVE. This is an expensive operation and is performed more frequently than
is necessary. This proposal provides a more passive method of collecting the yield, reducing
SAVE deposit gas costs by >= 50% while delivering a smoother result.

This upgrade is something that could be bundled nicely to [mip-3](./mip-3)

## Abstract

<!--A short (~200 word) description of the proposed change, the abstract should clearly describe the proposed change. This is what *will* be done if the MIP is implemented, not *why* it should be done or *how* it will be done. If the MIP proposes deploying a new contract, write, "we propose to deploy a new contract that will do x".-->

There are 2 primary sources of income from mAsset - SWAP fees, and Lending market income.
This MIP will make 2 fundamental changes to the way system income is collected and distributed.
The first of which is how the SWAP fees are tracked over time, and the second of which is the frequency
of lending market interest is collected. The lending market interest will be collected intermittently and
streamed second by second to SAVE.

## Motivation

<!--This is the problem statement. This is the *why* of the MIP. It should clearly explain *why* the current state of the protocol is inadequate.  It is critical that you explain *why* the change is needed, if the MIP proposes changing how something is calculated, you must address *why* the current calculation is innaccurate or wrong. This is not the place to describe how the MIP will address the issue!-->

On deposit, currently there are a number of interactions involved in collecting system interest before it is credited
to SAVE to the benefit of the existing savers. The flow goes something like `SavingsContract` > `SavingsManager` > `Masset` >
`BasketManager` > eachBasset[`PlatformIntegration`].

Example of a deposit transaction:
[tenderly.co/tx/main/0xf73...](https://dashboard.tenderly.co/tx/main/0xf730ff62dfe989fda27c18c858e897db31402dff3ab811105fcf20c55829db8f/gas-usage)

Current gas cost: ~390,739

The part of the transaction, from `BasketManager` onwards, is proposed to be omitted. In this function,
for each basset a `IPlatformIntegration(integrations[i]).checkBalance(b.addr);` call is made - this is expensive due to the way
Aave and Compound check balances for underlying assets.

**Potential savings: ~210k or ~54%**

If we were to continue without this change, the gas costs would increase by ~30k for each bAsset added in to the system.

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

This MIP will solve the problem by making the following changes:

**1 - Change the way SWAP fees are recorded in `Masset.sol`**

Currently the SWAP fees are implicitly recorded as deltas in each bAssets `vaultBalance` property by subtracting
the full amount (including fee) during a SWAP. When the interest is collected in `BasketManager`, the gain is
calculated as `delta = balance.sub(oldVaultBalance);`. Instead of recording fees implicitly like this, we will instead
track fees natively in the `Masset.sol` at the cost of an extra SSTORE to each SWAP/REDEEM.

**2 - Change the default behaviour of the `collectInterest` function in `Masset.sol`**

Simply remove the call `basketManager.collectInterest();` and mint mAsset to the amount of fees that have been collected.

**3 - Change the method of lending market interest collection & distribution (`SavingsManager.sol` && `Masset.sol`)**

As opposed to collecting lending market interest each deposit, we will add a new function to `Masset.sol` that specifically collects
the interest from the lending markets and deposits it to the SavingsManager. Following the mechanism in [mip-2](./mip-2) in which
a publicly accessible function is called intermittently, we will then **stream the collected yield over the course of a DAY** to SAVE.

### Rationale

The ideal solution:

- a) Lowers gas costs for SAVE deposit
- b) Does not present unfair opportunities for participants to time SAVE deposits and "steal" yield
- c) Does not increase gas costs substantially (1 SSTORE is fine) for mint/swap/redeem

The above properties were taken into account and used as benchmarks on the following decisions:

**1 - SWAP fee collection: immediate vs streamed**

The SWAP fee collection could have been bundled in with the lending market collections and made once per day.
While this would offer significant gas advantages, it would give market participants the opportunity to time their
SAVE deposits with high SWAP volumes, and thus steal yield from loyal participants (b).

**2 - Lending market fee collection: immediate vs streamed**

The lending market yield could simply be immediately distributed to SAVE (during the next SWAP fee collection cycle)
but this would provide unfair advantages for participants who could time their deposits correctly (b).

**3 - SWAP fee tracking**

Given the active proposal in [MIP-3](./mip-3) which sees gas costs vastly reduced across the board, spending an extra 5k to
update a global param is not much of a problem. Instead of setting the variable to `0`, we will set it to `1`, thus causing
5k for both swap/redeem, as well as 5k for SAVE. This is a compromise for both user groups.

<!--This is where you explain the reasoning behind how you propose to solve the problem. Why did you propose to implement the change in this way, what were the considerations and trade-offs. The rationale fleshes out what motivated the design and why particular design decisions were made. It should describe alternate designs that were considered and related work. The rationale may also provide evidence of consensus within the community, and should discuss important objections or concerns raised during discussion.-->

### Technical Specification

<!--The technical specification should outline the public API of the changes proposed. That is, changes to any of the interfaces mStable currently exposes or the creations of new ones.-->

#### Contract changes

**Masset.sol (UPGRADE)**

New property: `surplus`
Tracks the units of fees that have been accrued since last collection (in mAsset terms)

Modify function: `collectInterest` -> `collectFees`
Turns accrued SWAP fees into mAsset and sends to SavingsManager

New function: `collectInterest`
Collects the lending market interest and sends to the SavingsManager to
be streamed over the course of a day

**SavingsManager.sol (UPGRADE)**

New function: `streamInterest`
Deposits the lending market yield and streams over the course of a day, bundling with existing stream.

### Configurable Values (Via MCCP)

<!--Please list all values configurable via MCCP under this implementation.-->

N/A

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
