---
tdp: 44
title: mStableDAO Restructure
status: Approved
author: mZeroNine (@mzero2nine)
discussions-to: https://forum.mstable.org/t/tdp-44-mstabledao-restructure/887
created: 2022-06-20
---

## Simple Summary

It is proposed to restructure the mStableDAO in order to increase its efficiency as well as overall ability to scale in the future without further re-adjustments down the line in order to prepare for the release of mStable v2. 

Since the restructuring process as a whole is extensive, it is also proposed to split the mStableDAO restructuring into multiple TDPs in order to maintain explicitness in the voting outcome as well as ensuring a digestible format for Meta Governors. The entire process will contain 4 TDPs in total.

TDP 44: mStableDAO Restructure is concerned with the overall consensus on

- Whether or not Meta Governors wish the mStableDAO to be restructured as described below
- The format of having subsequent TDPs that will resolve more granular details of the restructuring process as a whole

## Abstract

This first TDP is targeted at the overall proposition to begin the restructuring of the mStableDAO. 

The key actions proposed include:

- Introducing a general universal contributor title which would involve removing current individual rules and holding a full election process (part of the next TDP) for each of the available seats inside of the respective DAO. Both DAOs will operate under a 4/6 multisig.
- Merging the Asset Management subDAO with the TreasuryDAO and absorb primary funding functions of the Funding subDAO back into the TreasuryDAO.
- Creation of a new “Builder subDAO” to separate the ProtocolDAO from the full-time contributor's group that is responsible for the continuous roll-out and operations of the mStable product line. The creation of this subDAO will ensure the long-term success of the protocol while preventing any centralized points of failure or sensitivity to external threats

## Motivation

mStable is transitioning toward a new vision of becoming a leader in 4626 vaults and an efficient DAO structure is critical in making this vision a reality.

Since its inception, the mStableDAO has gone through several iterations in an attempt to improve its efficiency. Examples include [improvements to the ProtocolDAO structure](https://forum.mstable.org/t/mstable-protocoldao-migration-and-upgrade/352), the [creation of the Asset Management subDAO](https://forum.mstable.org/t/proposal-creation-initial-funding-of-the-mstabledao-asset-management-subdao/568) and [creation of the Funding subDAO](https://forum.mstable.org/t/future-funding-of-mstable/543).

Fundamentally, the ProtocolDAO and TreasuryDAO have proven to serve their purpose in executing the will of the Meta Governors. However, we have learned that slow execution in multisigs has not always been resolved by reducing the size of the signer group and that in fact, 2/3 multisigs may be more susceptible to delays than larger structures such as 4/7 multisigs. This is evidenced by the efficiency of the current ProtocolDAO, and the delays that have been experienced in smaller signer structures within the Asset Management and Funding subDAOs. Instead, delays tend to be caused by a lack of clarity in the responsibilities of signers and a lack of availability and engagement, as well as time zone differences in some cases.

**Inefficiencies that have been identified in the current DAO structure include:**

- The complexity of the current DAO structure and a lack of clarity around the responsibilities and purpose of each entity
- A number of disengaged signers on the TreasuryDAO, leading to long delays in transaction execution
- Lack of thorough review and verification of transactions due to low involvement in the governance or decision-making process
- Compromised security in the Asset Management subDAO, which now custodies around $3.5m in assets, without significant gains in efficiency
- Growth of off-chain entity operations and associated costs, leading to more centralization and complexity
- A disconnect between the way the core team works together and the structure of the DAO
- A lack of clear purpose and deliverables for entities funded by the mStableDAO

This proposal aims to address the inefficiencies outlined above through simplification of DAO structure and clarification of the purpose, responsibilities, and decision-making processes within each entity.

Aside from aligning with a new vision and focus for mStable, the timing of this review also coincides with a number of key dates that would have already required individual governance processes, so it’s the perfect time to consolidate all of these requests in this restructuring proposal.

## Specification

1.) Begin parallel rollout of TDP 45 for the election process, TDP 46 for the GrantsDAO and Community subDAO consolidation & review of the GrantsDAOs success after it’s first year of operation, as well as TDP 47 for the proposed compensation model under which the mStableDAO will fund its workforce.

2.) Resolve the voting outcome of TDP 44: mStableDAO Restructure in order to begin the creation of subsequent key proposals in the following epochs. In case of an unfavourable voting outcome, the mStableDAO will not be restructured and votes on subsequent TDPs and further resolutions listed in the specification not take place. 

3.) As each of the TDPs resolves, begin implementing the changes as ratified via Meta Governors in parallel as to reduce overhead and increase efficiency of the rollout.

4.) After the elections have been successfully held, begin the process of replacing all old signers in the respective DAO with the newly elected contributors.

5.) Start the process of migrating all key positions the Asset Management subDAO holds back into the TreasuryDAO. This will be done after elections in order to ensure an agile redeployment.

During this transition period, the Asset Management subDAO will have the TreasuryDAO signer structure replicated. After the migration has been completed, the Asset Management subDAO will be sunset.

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
