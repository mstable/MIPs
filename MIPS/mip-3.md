---
mip: 3
title: Add a cache to reduce gas costs
status: Proposed
author: Alex Scott <alex@mstable.org>
discussions-to: https://forum.mstable.org/
created: 2020-10-27
---

## Simple Summary

<!--"If you can't explain it simply, you don't understand it well enough." Simply describe the outcome the proposed changes intends to achieve. This should be non-technical and accessible to a casual community member.-->

Depositing and withdrawing from lending markets (Compound, Aave) constitutes
70-90% of the gas cost of a given transaction. This MIP proposes to implement a
cache to reduce frequency of interactions with the lending pools.

## Abstract

<!--A short (~200 word) description of the proposed change, the abstract should clearly describe the proposed change. This is what *will* be done if the MIP is implemented, not *why* it should be done or *how* it will be done. If the MIP proposes deploying a new contract, write, "we propose to deploy a new contract that will do x".-->

We propose upgrading the `Masset.sol` contract, allowing it to track and retain a percentage of
all collateral in it's "cache". Only if necessary will the `Masset` then deposit or withdraw from
the lending markets. Subsequently, the `BasketManager.sol` will be upgraded to use the cache data
during normal interest collection.

## Motivation

<!--This is the problem statement. This is the *why* of the MIP. It should clearly explain *why* the current state of the protocol is inadequate.  It is critical that you explain *why* the change is needed, if the MIP proposes changing how something is calculated, you must address *why* the current calculation is innaccurate or wrong. This is not the place to describe how the MIP will address the issue!-->

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

### Rationale

<!--This is where you explain the reasoning behind how you propose to solve the problem. Why did you propose to implement the change in this way, what were the considerations and trade-offs. The rationale fleshes out what motivated the design and why particular design decisions were made. It should describe alternate designs that were considered and related work. The rationale may also provide evidence of consensus within the community, and should discuss important objections or concerns raised during discussion.-->

### Technical Specification

<!--The technical specification should outline the public API of the changes proposed. That is, changes to any of the interfaces mStable currently exposes or the creations of new ones.-->

### Configurable Values (Via MCCP)

<!--Please list all values configurable via MCCP under this implementation.-->

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).

[1]: https://google.com
