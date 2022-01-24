---
tdp: 32
title: Olympus Pro Bond Adjustments
status: Approved
author: James Eddington (@jameseddington), mZeroNine (@mzero2nine)
discussions-to: https://forum.mstable.org/
created: 2021-12-10
---

## Simple Summary

It is proposed to amend [TDP 25](./tdp-25) to change the token used to purchase MTA bonds from [cvxmusd3crv](https://etherscan.io/token/0xd34d466233c5195193df712936049729140dbbd7) to [mUSD](https://etherscan.io/token/0xe2f2a5c287993345a840db3b0845fbc70f5935a5) for the 2nd round of Olympus Pro bond issuance and beyond if required.

## Abstract

When the LP token for the Olympus Pro Bonds was initially picked, we anticipated that owners of a Convex mUSD position would like an easy and simple exit out from the liquidity pair, and we wanted to enable the capture of this via the Olympus Pro bond program.

The first round of bonds have shown us that much more people were interested in purchasing bonds with easy to access collateral, so it is proposed to switch the LP token currently being used to buy MTA Bonds to mUSD to allow for easier entry into the bond program and give the treasury more flexibility on how to utilize this liquidity in the future via governance.

## Motivation

A lot of feedback was received regarding the LP token used for Olympus Pro, and [following the deposits made into the contract](https://etherscan.io/address/0xa8e5fa0072d292646d49999ef0d7f9354ec8e7a5) confirms that a simpler token for bonding is required to satisfy the usability of these bond purchases.

## Specification

### Proposed workflow

1.) The core contributor team will reach out to Olympus Pro and propose an amendment to change the token used for purchasing MTA bonds from [cvxmusd3crv](https://etherscan.io/token/0xd34d466233c5195193df712936049729140dbbd7) to [mUSD](https://etherscan.io/token/0xe2f2a5c287993345a840db3b0845fbc70f5935a5) for the 2nd round of bond issuance.

2.) In this effort, Olympus Pro will also change the maximum amount of mUSD that can be used to bond MTA in order to allow interested parties to purchase bigger bonds in one transaction.

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).