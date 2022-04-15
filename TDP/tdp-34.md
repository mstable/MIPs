---
tdp: 34
title: Add HAL Plugin to Snapshot
status: Implemented
author: mZeroNine (@mzero2nine)
discussions-to: https://forum.mstable.org/t/tdp-34-add-hal-plugin-to-snapshot/817
created: 2021-02-25
---

## Simple Summary

It is proposed to add the HAL Snapshot plugin to the [mStable Snapshot page](https://vote.mstable.org/#/) in order to give users an easy-to-access way for staying up to date with mStable Governance.

## Abstract

HAL [recently launched their new Snapshot Plugin](https://twitter.com/HAL_Team/status/1473609416675147790?s=20&t=-rQOHNXjQLf8KwOkPZ2tyw), and it is suggested to add this feature to our own Snapshot page in order to make it easier for Meta Governors to stay on top of current proposals outside of the current offering via Discord, Twitter, and EPNS. 

After adding the plugin, users can simply subscribe to future mStable Governance updates directly on the Snapshot page.

Further information can be found in [this handy tutorial](https://www.hal.xyz/resources/turorial-how-to-set-up-hal-snapshot-plugin) provided by HAL.

## Motivation

Staying up to date in DeFi is no easy task, and much less so if users are part of multiple communities. Therefore, offering updates on mStable governance proposals in as many different ways as possible to users is extremely important, and this Snapshot plugin marks a very direct and interactive way of doing so.

## Specification

1.) Alter the IPFS-hosted Snapshot file document referenced on the [mstablegovernance.eth domain page](https://app.ens.domains/name/mstablegovernance.eth/details) by adding the `hal: {}` argument.

2.) Upload the updated file to IPFS and change the link on the ENS domain page in the `snapshot` text record to the newly uploaded location.

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
