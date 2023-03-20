---
mip: 35
title: Idle + mStable Merge
status: Proposed
author: Idle Finance (@idle.finance)
discussions-to: https://forum.mstable.org/t/mip-35-idle-mstable-merge/1020
created: 2023-03-18
---

## Summary

This MIP seeks to officially propose the merger of Idle DAO and mStable DAO, following the related [RFC](https://forum.mstable.org/t/rfc-idle-mstable-merge/1006) and conversations with both teams confirming the clear synergies between the ecosystems. The goal of the merger is to leverage existing resources and amplify potential outcomes toward becoming the major yield aggregator and optimization protocol.

The proposed path for product and governance continuity, along with team inclusion, involves a token swap allowing MTA holders to receive IDLE tokens in proportion to their mStable protocol ownership.

The merger aims to streamline efforts, increase productivity, and achieve common objectives more effectively.

## Motivation

### Clear Product Synergy

After having productive discussions with the mStable team last week, we are pleased to confirm that our shared vision and product suite compatibility have been reinforced. As a result, we now have a clearer view of the three layers of yield optimization that our product suite offers. The top layer is composed of Best Yield Vaults, designed to provide the highest level of abstraction and aggregation for integrators. The middle layer is composed of Yield Tranches, which offer risk diversification and allow sophisticated users to create their own yield portfolio based on their risk tolerance. Finally, the base layer is composed of Meta Vaults, which optimize yield across different yield verticals.

The updated product suite structure below shows this concept:

![|647x404](https://lh6.googleusercontent.com/CMmwt_ze3hvM-Icbh__5xMN7eZxLAVVOJdA7W4hefjcQ7JrrJkSsC--wo9PQRv1iElxzNhY3_dLg3J_Bo2jZe0Mol2Mvw9-I5KNsGKKWzT7vqfXAGWj2lqNxaCgIhfO31HKLfiKjNB1A85oS2DiSQQ)

![|647x404](upload://gDW3lZ06OUpUDQkBGp0j2GCAeS1.jpeg)

Thanks to this design, Meta Vaults will onboard Idle as a first customer, leveraging Yield Tranches and Best Yield Vaults to access the existing user base and business relationships. In the future, new yield sources will start from Meta Vaults and will then be integrated across the yield stack.

Looking at the bigger picture, we would also be amped to strategize over an expansion to other chains, potentially using Meta Vaults as a router at the base layer to optimize yield on any chain. On top of this, account abstraction with EIP-4337 would simplify the onboarding process.

And as mentioned, regarding mUSD, we are open to considering its continuity, but only if there's an agreement on its actual purpose. The “stablecoin business” is an intricate system, where there is the need to be laser-focused on it. It is a system truly unlike any other in DeFi because beneath a deceivingly simple product (a $1 coin) hides a mountain of difficult tradeoffs and decisions. From oracle choice to collateral choice to parametrization to interest rate model to peg-arbitragers incentives to liquidation mechanisms.

If the primary goal we want to give to the stablecoin infra of mUSD is to allow leverage, then it may be better off to create an embedded tool for it or work with DeFi leverage components such as Gearbox. We can eventually assess if partnering up with other stablecoin issuers to provide the yield optimization, aggregation, and risk-diversification infrastructure for their collaterals if we want to play a role in the stablecoin ecosystem. Overall, we remain committed to our shared vision and look forward to continuing this synergy with the mStable team.

### Matching Team Structure

As outlined in our [RFC](https://forum.mstable.org/t/rfc-idle-mstable-merge/1006), we recognize the critical importance of building a solid and committed team that shares our values and vision. Therefore, we are placing a strong emphasis on the onboarding of team members who have a proven track record of contributing to the concept, development, and optimization of Meta Vaults, which we view as a base layer of our product suite.

After engaging with the mStable team members, we have come to the understanding that a significant portion of the team can be instrumental to the success of our Meta Vaults as a base layer in the yield product stack we envision. Although the final structure of the merged team will be determined, to a certain extent, by the actual value of the treasury upon merge completion, we recognize that the ongoing improvement and development of Meta Vaults is crucial to our shared success and want to schedule further meetings to mStable team in the next weeks to appropriately define the final structure. We believe that by prioritizing the onboarding of these team members, we can continue to innovate and lead in the DeFi space with a strong team department focused on this product.

Thanks to this design, Meta Vaults will onboard Idle as a first customer, leveraging Yield Tranches and Best Yield Vaults to access the existing user base and business relationships. In the future, new yield sources will start from Meta Vaults and will then be integrated across the yield stack.

Looking at the bigger picture, we would also be amped to strategize over an expansion to other chains, potentially using Meta Vaults as a router at the base layer to optimize yield on any chain. On top of this, account abstraction with EIP-4337 would simplify the onboarding process.

And as mentioned, regarding mUSD, we are open to considering its continuity, but only if there's an agreement on its actual purpose. The “stablecoin business” is an intricate system, where there is the need to be laser-focused on it. It is a system truly unlike any other in DeFi because beneath a deceivingly simple product (a $1 coin) hides a mountain of difficult tradeoffs and decisions. From oracle choice to collateral choice to parametrization to interest rate model to peg-arbitragers incentives to liquidation mechanisms.

If the primary goal we want to give to the stablecoin infra of mUSD is to allow leverage, then it may be better off to create an embedded tool for it or work with DeFi leverage components such as Gearbox. We can eventually assess if partnering up with other stablecoin issuers to provide the yield optimization, aggregation, and risk-diversification infrastructure for their collaterals if we want to play a role in the stablecoin ecosystem. Overall, we remain committed to our shared vision and look forward to continuing this synergy with the mStable team.

### Matching Team Structure

As outlined in our [RFC](https://forum.mstable.org/t/rfc-idle-mstable-merge/1006), we recognize the critical importance of building a solid and committed team that shares our values and vision. Therefore, we are placing a strong emphasis on the onboarding of team members who have a proven track record of contributing to the concept, development, and optimization of Meta Vaults, which we view as a base layer of our product suite.

After engaging with the mStable team members, we have come to the understanding that a significant portion of the team can be instrumental to the success of our Meta Vaults as a base layer in the yield product stack we envision. Although the final structure of the merged team will be determined, to a certain extent, by the actual value of the treasury upon merge completion, we recognize that the ongoing improvement and development of Meta Vaults is crucial to our shared success and want to schedule further meetings to mStable team in the next weeks to appropriately define the final structure. We believe that by prioritizing the onboarding of these team members, we can continue to innovate and lead in the DeFi space with a strong team department focused on this product.

**![|635x360](https://lh4.googleusercontent.com/R6fzb418kv2PesaB5esaJD1VpC2uKtENUg2V0D-wq5ZqCFlbSW6gfgbjAGYVo1SbI2IIdJGZVbzSj6i6tpeoAUKcOj8nE7eI2U9um8-Wubq3DOMUe-rnVaLLz53BRHpUwQQiZVVJaP7Q1Cjdcm6BIA)**

**![|635x360](upload://1MevtR9feU5Bv7vG51SjXIQKpSM.jpeg)**

Starting from the structure reported in the RFC, as we expand our team, we are also considering forming a dedicated product team (in addition to the current growth, comms, and development) to bring more focus to high-value team verticals. The Dev team can focus solely on yield strategies integration, development, and maintenance, while the Product team can bring dashboard improvements, analyze strategies performances and expand integration tools. This is intended to ensure that our strategies and platform remain at the forefront of the rapidly evolving DeFi ecosystem.

### Governance Migration

Pending a collective consensus about the future of existing mStable products on Ethereum and Polygon, the mStable team will oversee their maintenance until an eventual user migration is completed.

With the aim of providing continuity to Meta Vaults, a secure transition will require the relaunch of new Vaults following Idle DAO deployment process: internal and third-party peer reviews, the assessment for a full audit, and then a guarded launch.

The existing Meta Vault will be maintained under the control of mStable team, with the goal of finalizing its sunsetting and facilitating user redeems.

The eventual sunset of mUSD and Save products would follow the approach described in [MIP 31](./mip-31).

[quote="dimsome, post:1, topic:992"]

### mAssets and Save

- Upgrade the mAssets’s `migrateBassets` to support migrating bAssets from platforms back to the mAsset contract

- Remove platform integration

- Set swap and redeem fee to 0

- Set new min-max weights (5% and 95%)

- This applies to mUSD and mBTC on Ethereum mainnet and to mUSD on Polygon

### Feeder Pools

- Upgrade the Feeder Pool’s `migrateBassets` to support migrating bAssets from platforms back to the Feeder Pool contract

- Remove integration contracts if present

- Set swap and redeem fee to 0

- This applies to mUSD and mBTC on Ethereum mainnet and to mUSD on Polygon

- Exception: GUSD is still integrated with Iron Bank, a full withdrawal from the integration contract to cache as specified in [MIP 23](./mip-23) was not possible without further changes. The GUSD contract will be adjusted to allow partial migration of assets back to the cache.

[/quote]

Specifications have been reported [here](https://forum.mstable.org/t/mip-31-product-sunset-approach/992/2?u=idle_leagues).

In terms of front-end, the integration of Meta Vault will be progressively phased out on the mStable website, with a focus on prioritizing its integration on the Idle dashboard. To this end, a banner will be displayed on the mStable website highlighting the migration process to new Meta Vaults on Idle UI.

If the decision to sunset mUSD is implemented, the redeemability of mUSD will remain active for a minimum of six months. mStable team will follow the procedures outlined in [MIP 31](./mip-31) during this period

[quote="dimsome, post:1, topic:992"]

### Front-ends

- In all front-ends and the landing page, a banner will be added to notify everyone of the sunsetting of the product and to encourage withdrawals.

- The front-end will be kept alive for at least 6 months after the vote of the sunset in the subsequent proposal has been conducted.

- The possibility to access the contracts afterward is still possible via a locally run front-end or directly with the smart contracts (i.e. Etherscan).

[/quote]

Idle DAO will evaluate to devise incentivization campaigns aimed at encouraging mUSD liquidity providers to migrate to Meta Vaults, thereby improving the retention rate of the current user base.

mStable team will manage Phase 1 of the Deal Terms section, resulting in the transfer of unclaimed treasury assets to Idle DAO.

Idle DAO, together with the new Leagues members, will undertake the following activities:

- Facilitate a seamless transition of knowledge base, material and immaterial assets.
- Provide assistance to community members, MTA token holders, and liquidity providers.
- Update documentation with migration and redeem guides.
- Timely communication of the product timeline and next steps.
- New OKRs setup with the unified product roadmap.
- Consolidate communication channels under Idle platforms (Twitter, Discord, Telegram, and LinkedIn) with a migration plan that maximizes follower retention, with the possibility to maintain part of the channels to have different communication styles and amplify the reach (e.g. an “Idle intern” style Twitter account).
- Maintain the mStable front-end until the product sunset is completed.

The estimated cost for these activities is $160k, which will be deducted from the transferred liquid treasury and will be operatively implemented by mStable team in collaboration with Idle Leagues.

## Deal terms

The mStable treasury addresses and amounts stated in the [MIP 32](./mip-32) were used as a base to structure the deal terms reported below.

To allow MTA holders to be flexible in their final decision, our merger solution is divided into two phases:

### Phase 1

Token holders not aligned with the mStable <> Idle merge can exit with no penalties and will receive a pro-rata share of the treasury value. The estimated redemption value per eligible MTA would be $0.03, comparable with [MIP 32](./mip-32). This phase will last 1 month, and volatile tokens (excluding AURA/auraBAL, which represents a strategic asset) will be swapped for stablecoins. Redeem value will be denominated in stablecoin.

### Phase 2

After 1 month, token holders aligned with the mStable <> Idle merge and interested in the upside potential will get access to

#### Fixed-term IDLE

Up to 1.7M IDLE claimable from a vesting contract with 3 months cliff and 6 months linear vesting

#### KPI-based IDLE

Up to additional 1.3M IDLE subject to a [TVL-based KPI option](https://medium.com/uma-project/introducing-milestone-kpi-options-2a8ea4cf480e) with

| Tier (TVL\*) | Payout (IDLE) |
| ------------ | ------------- |
| $100m        | 260,000       |
| $250m        | 520,000       |
| $500m        | 780,000       |
| $750m        | 1,040,000     |
| $1b          | 1,300,000     |

\*TVL will be measured as a 6-month weighted average across all Idle-based products (Best Yield, Yield Tranches, Meta Vaults), starting 1.5 years after the opening of MTA/IDLE swap and ending at the beginning of the second year.

The allocation of IDLE in the vesting contract and via KPI option are proportional to each $1 of the treasury transferred to Idle DAO, with the total IDLE amount unlocked with the full treasury migration. For example, a $1.5M worth of treasury represents 75% of the par value, thus 2.25M IDLE (1.27M via vesting and 975k via KPI option) will be allocated. Supposing that not all MTA holders execute the swap, unclaimed IDLE funds will be proportionally split at swap expiry between token holders that completed the migration.

### Fee-Sharing

Via fee-sharing, MTA holders will receive an additional stream to cover the difference between the par value of the mStable treasury at swap inception (beginning of Phase 2), and the market value of IDLE tokens claimed by MTA holders at swap expiry (after 3 months).

MTA holders will receive on-chain right to receive 30% of the Idle DAO surplus fees. To this end, "surplus fees" refer to any fees generated by the Idle DAO in excess of $200’000 per month (with a 30-day rolling price for non-stablecoin assets). The fee-sharing arrangement will commence every time the Idle DAO's will generate monthly surplus fees and remain in effect until the aforementioned difference is reached (within a 1-year since the first fee-sharing event). According to the cashflow analysis done, the starting point of the fee-sharing is expected 10 months after the merger.

Starting from the structure reported in the RFC, as we expand our team, we are also considering forming a dedicated product team (in addition to the current growth, comms, and development) to bring more focus to high-value team verticals. The Dev team can focus solely on yield strategies integration, development, and maintenance, while the Product team can bring dashboard improvements, analyze strategies performances and expand integration tools. This is intended to ensure that our strategies and platform remain at the forefront of the rapidly evolving DeFi ecosystem.

## Governance Migration

Pending a collective consensus about the future of existing mStable products on Ethereum and Polygon, the mStable team will oversee their maintenance until an eventual user migration is completed.

With the aim of providing continuity to Meta Vaults, a secure transition will require the relaunch of new Vaults following Idle DAO deployment process: internal and third-party peer reviews, the assessment for a full audit, and then a guarded launch.

The existing Meta Vault will be maintained under the control of mStable team, with the goal of finalizing its sunsetting and facilitating user redeems.

The eventual sunset of mUSD and Save products would follow the approach described in [MIP 31](./mip-31).

[quote="dimsome, post:1, topic:992"]

### mAssets and Save

- Upgrade the mAssets’s `migrateBassets` to support migrating bAssets from platforms back to the mAsset contract

- Remove platform integration

- Set swap and redeem fee to 0

- Set new min-max weights (5% and 95%)

- This applies to mUSD and mBTC on Ethereum mainnet and to mUSD on Polygon

### Feeder Pools

- Upgrade the Feeder Pool’s `migrateBassets` to support migrating bAssets from platforms back to the Feeder Pool contract

- Remove integration contracts if present

- Set swap and redeem fee to 0

- This applies to mUSD and mBTC on Ethereum mainnet and to mUSD on Polygon

- Exception: GUSD is still integrated with Iron Bank, a full withdrawal from the integration contract to cache as specified in [MIP 23](./mip-23) was not possible without further changes. The GUSD contract will be adjusted to allow partial migration of assets back to the cache.

[/quote]

Specifications have been reported [here](https://forum.mstable.org/t/mip-31-product-sunset-approach/992/2?u=idle_leagues).

In terms of front-end, the integration of Meta Vault will be progressively phased out on the mStable website, with a focus on prioritizing its integration on the Idle dashboard. To this end, a banner will be displayed on the mStable website highlighting the migration process to new Meta Vaults on Idle UI.

If the decision to sunset mUSD is implemented, the redeemability of mUSD will remain active for a minimum of six months. mStable team will follow the procedures outlined in [MIP 31](./mip-31) during this period

[quote="dimsome, post:1, topic:992"]

### Front-ends

- In all front-ends and the landing page, a banner will be added to notify everyone of the sunsetting of the product and to encourage withdrawals.

- The front-end will be kept alive for at least 6 months after the vote of the sunset in the subsequent proposal has been conducted.

- The possibility to access the contracts afterward is still possible via a locally run front-end or directly with the smart contracts (i.e. Etherscan).

[/quote]

Idle DAO will evaluate to devise incentivization campaigns aimed at encouraging mUSD liquidity providers to migrate to Meta Vaults, thereby improving the retention rate of the current user base.

mStable team will manage Phase 1 of the Deal Terms section, resulting in the transfer of unclaimed treasury assets to Idle DAO.

Idle DAO, together with the new Leagues members, will undertake the following activities:

- Facilitate a seamless transition of knowledge base, material and immaterial assets.
- Provide assistance to community members, MTA token holders, and liquidity providers.
- Update documentation with migration and redeem guides.
- Timely communication of the product timeline and next steps.
- New OKRs setup with the unified product roadmap.
- Consolidate communication channels under Idle platforms (Twitter, Discord, Telegram, and LinkedIn) with a migration plan that maximizes follower retention, with the possibility to maintain part of the channels to have different communication styles and amplify the reach (e.g. an “Idle intern” style Twitter account).
- Maintain the mStable front-end until the product sunset is completed.

The estimated cost for these activities is $160k, which will be deducted from the transferred liquid treasury and will be operatively implemented by mStable team in collaboration with Idle Leagues.

## Deal terms

The mStable treasury addresses and amounts stated in the [MIP 32](./mip-32) were used as a base to structure the deal terms reported below.

To allow MTA holders to be flexible in their final decision, our merger solution is divided into two phases:

### Phase 1

Token holders not aligned with the mStable <> Idle merge can exit with no penalties and will receive a pro-rata share of the treasury value. The estimated redemption value per eligible MTA would be $0.03, comparable with [MIP32](./mip-32)). This phase will last 1 month, and volatile tokens (excluding AURA/auraBAL, which represents a strategic asset) will be swapped for stablecoins. Redeem value will be denominated in stablecoin.

### Phase 2

After 1 month, token holders aligned with the mStable <> Idle merge and interested in the upside potential will get access to

**Fixed-term IDLE**

Up to 1.7M IDLE claimable from a vesting contract with 3 months cliff and 6 months linear vesting

**KPI-based IDLE**

Up to additional 1.3M IDLE subject to a [TVL-based KPI option](https://medium.com/uma-project/introducing-milestone-kpi-options-2a8ea4cf480e) with

| Tier (TVL\*) | Payout (IDLE) |
| ------------ | ------------- |
| $100m        | 260,000       |
| $250m        | 520,000       |
| $500m        | 780,000       |
| $750m        | 1,040,000     |
| $1b          | 1,300,000     |

\*TVL will be measured as a 6-month weighted average across all Idle-based products (Best Yield, Yield Tranches, Meta Vaults), starting 1.5 years after the opening of MTA/IDLE swap and ending at the beginning of the second year.

The allocation of IDLE in the vesting contract and via KPI option are proportional to each $1 of the treasury transferred to Idle DAO, with the total IDLE amount unlocked with the full treasury migration. For example, a $1.5M worth of treasury represents 75% of the par value, thus 2.25M IDLE (1.27M via vesting and 975k via KPI option) will be allocated. Supposing that not all MTA holders execute the swap, unclaimed IDLE funds will be proportionally split at swap expiry between token holders that completed the migration.

### Fee-Sharing

Via fee-sharing, MTA holders will receive an additional stream to cover the difference between the par value of the mStable treasury at swap inception (beginning of Phase 2), and the market value of IDLE tokens claimed by MTA holders at swap expiry (after 3 months).

MTA holders will receive on-chain right to receive 30% of the Idle DAO surplus fees. To this end, "surplus fees" refer to any fees generated by the Idle DAO in excess of $200’000 per month (with a 30-day rolling price for non-stablecoin assets). The fee-sharing arrangement will commence every time the Idle DAO's will generate monthly surplus fees and remain in effect until the aforementioned difference is reached (within a 1-year since the first fee-sharing event). According to the cashflow analysis done, the starting point of the fee-sharing is expected 10 months after the merger.

**![|624x327](https://lh3.googleusercontent.com/cMM0jR85Yt4FNd3wSN0gWkLBMu5UWb9kG1iITqcHncFmkJSkyQvzYOy3RxMd8GoPjOUTecLleapHbgddYM1KkEiRdHaSFZBiRqDTaVLkuMgZaoev2zPvDeMIoY_PEWm0ss0DRsx2LaWRG10vDUXjtQ)**

<!-- **![|624x327](upload://zl0C6CQpqAtxbV1D0252Un3V8qU.jpeg)** -->

MTA token holders will have 3 months to complete the IDLE swap (which includes IDLE + KPI option + fee-sharing). The technical migration will be designed to minimize the effort for MTA holders, aggregating actions as much as possible.

## Cash flow analysis & sustainability

To assist in the merger analysis, we have prepared a detailed cash flow analysis that provides a comprehensive summary of the TVL growth of the product suite, as outlined in the Product Synergy section.

The complete analysis is available here:

https://docs.google.com/spreadsheets/d/1Spm9x1OrVEmIRvaFfV-1uCCC_JtRZRIb4RHUtyMYn4A/edit?usp=sharing

The analysis assumptions are:

- Meta Vault base APY: 7.5%
- Tranches’ coverage: 30%
- Burn rate: $150k
- Surplus fees threshold: $200k
- Fee-sharing: 30%
- Hypothetical amount covered by fee-sharing: $800k
- TVL growth rate: 15% the first year and 10% the second year

As an outcome, a break-even point will be reached on the 14th month. The MTA token holder will entirely fill the hypothetical gap between mStable treasury par value and IDLE market value (MTA holder P&L). Treasury holdings will always be above $1.5m in net value, guaranteeing sustainability and business continuity in the long term.

The applied fee structure mirrors the existing [Best Yield and Yield Tranches performance fees](https://docs.idle.finance/products/fees), but it can be revisited with Meta Vault integration.MTA token holders will have 3 months to complete the IDLE swap (which includes IDLE + KPI option + fee-sharing). The technical migration will be designed to minimize the effort for MTA holders, aggregating actions as much as possible.

## Cash flow analysis & sustainability

To assist in the merger analysis, we have prepared a detailed cash flow analysis that provides a comprehensive summary of the TVL growth of the product suite, as outlined in the Product Synergy section.

The complete analysis is available here:

https://docs.google.com/spreadsheets/d/1Spm9x1OrVEmIRvaFfV-1uCCC_JtRZRIb4RHUtyMYn4A/edit?usp=sharing

The analysis assumptions are:

- Meta Vault base APY: 7.5%
- Tranches’ coverage: 30%
- Burn rate: $150k
- Surplus fees threshold: $200k
- Fee-sharing: 30%
- Hypothetical amount covered by fee-sharing: $800k
- TVL growth rate: 15% the first year and 10% the second year

As an outcome, a break-even point will be reached on the 14th month. The MTA token holder will entirely fill the hypothetical gap between mStable treasury par value and IDLE market value (MTA holder P&L). Treasury holdings will always be above $1.5m in net value, guaranteeing sustainability and business continuity in the long term.

The applied fee structure mirrors the existing [Best Yield and Yield Tranches performance fees](https://docs.idle.finance/products/fees), but it can be revisited with Meta Vault integration.

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
