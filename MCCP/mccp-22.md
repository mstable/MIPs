---
mccp: 22
title: Disable underutilized dials
status: Implemented
author: Dimitri Golecko (@dimsome)
discussions-to: https://forum.mstable.org/t/mccp-22-disable-underutilized-dials/875/5
created: 2022-05-30
---

## Simple Summary

It is proposed to disable the first batch of underutilized dials in the Emissions Controller as launched with [MIP 24](https://mips.mstable.org/MIPS/mip-24.html) in order to avoid dust amounts of MTA, make the Emissions Controller calculation more efficient and less gas-intensive and focus on emissions towards revenue-generating products.

## Abstract

Dials receive votes from MTA stakers that decide the allocation of newly emitted MTA. Some participants choose to actively shift their allocation while others allocate once and allow it to be dormant. This creates a dynamic in which some of the dials receive fairly few votes from a few individuals that haven’t adjusted their weights in a long while.

The effect of it is that there are some dials that receive a very minor MTA allocation. This leads to very little (dust) MTA to be sent to the respective recipients without offering much in value for the protocol. On the contrary, it adds gas costs to send minute amounts of MTA and the users would likely not be able to claim it without paying substantially more in gas (therefore it’s likely to be locked in the Vault).

## Motivation

This proposal aims to streamline the process of the MTA emissions and to avoid subsidizing products that are underutilized, don’t offer much value for the protocol, and receive a small amount of votes only.

After successful implementation, the benefit should be that the Emissions Controller transactions are less in gas and that less MTA gets wasted and locked in Vaults that don’t get much usage.

## Specification

The following dials are proposed to be disabled in the Emissions Controller ([0xBa69e6FC7Df49a3b75b565068Fb91ff2d9d91780](https://etherscan.io/address/0xBa69e6FC7Df49a3b75b565068Fb91ff2d9d91780)) on Ethereum Mainnet:

| Dial                     | Recipient address                          | Dial Id |
| ------------------------ | ------------------------------------------ | ------- |
| alUSD Feeder Pool Vault  | 0x0997dDdc038c8A958a3A3d00425C16f8ECa87deb | 6       |
| FEI Feeder Pool Vault    | 0xD24099Eb4CD604198071958655E4f2D263a5539B | 8       |
| HBTC Feeder Pool Vault   | 0xF65D53AA6e2E4A5f4F026e73cb3e22C22D75E35C | 9       |
| tBTCv2 Feeder Pool Vault | 0x97e2a2f97a2e9a4cfb462a49ab7c8d205abb9ed9 | 10      |
| Visor Finance            | 0xceF5df9d514bF0619c2ee87e2dDF1Af93FfAc0F6 | 16      |

## Technical Specification

For each of the dials to be disabled the following function will be called from the ProtocolDAO multisig:

Emissions Controller ([0xBa69e6FC7Df49a3b75b565068Fb91ff2d9d91780](https://etherscan.io/address/0xBa69e6FC7Df49a3b75b565068Fb91ff2d9d91780#code)):

- `updateDial(uint256 _dialId, bool _disabled, bool _notify)`
  - `_dialId =` See table in specifications
  - `_disabled = true` Changing the flag to diasbled the dial
  - `_notify =` get the current value of the flag, set to the same value

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/)
