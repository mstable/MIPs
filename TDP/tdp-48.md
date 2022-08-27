---
tdp: 48
title: Funding Request - mStable Builder subDAO (Sep-Dec 2022)
status: Proposed
author: Cam Soulsby (@camsoulsby),  mZeroNine (@mzero2nine),  0xloth (@LDeroccha),  
discussions-to: https://forum.mstable.org/t/funding-request-mstable-builder-subdao-sep-dec-2022/924
created: 2022-08-26
---

## Simple Summary

This proposal requests 4 months of operational funding for the proposed mStable Builder subDAO, originally defined in [TDP 44](./tdp-44.html). The proposal will:

* Describe the structure and internal decision-making processes of the proposed Builder subDAO entity
* Outline a budget proposal for the period of September - December 2022
* Describe deliverables and transparency reporting commitments over the funding period

## Abstract

Previously, the ongoing maintenance and development of the mStable protocol was funded through a [12-month funding request](https://forum.mstable.org/t/future-funding-of-mstable/543). Funds allocated under that request were left within the control of the mStable TreasuryDAO and sent to the Funding subDAO to be allocated in line with the broadly approved funding purposes. This request follows a slightly different model in line with the recent restructure of the mStableDAO.

Rather than simply leaving approved funding within the Treasury and having it allocated by a Funding subDAO, approved funds would be dispersed to the Builder subDAO over time, where the funds can be utilized within budget guidelines at the discretion of the Builder subDAO. This offers the following benefits:

* Easier accounting for actual spend vs. budget within the subDAO multisig wallet
* More agile and timely decision-making due independent signer structure
* Increased clarity around the specific purpose of funding
* Improved accountability and transparency reporting

## Motivation

### Purpose of the mStable Builder subDAO
The purpose of the Builder subDAO is to fund a team of core contributors whose mandate is to design, develop, launch and promote upgrades to the mStable product suite as well as new products. The intent of the subDAO is to foster innovation through allowing this team to work with efficiency, autonomy and flexibility, while still ensuring that funds are allocated in line with the wishes of Meta governors and that the subDAO has accountability to stakeholders for producing results.

### Mandate of the Builder subDAO
* Fund compensation of all Builder subDAO contributors as well all associated operational costs
* Nominate two contributors to act as Operational Signers on the mStable ProtocolDAO who will ensure smooth execution of approved governance proposals as well as discretionary decisions made within the granted power of the ProtocolDAO
* Develop and maintain shared resources for the mStableDAO, including the mStable codebase, brand guidelines and assets, as well as creation and maintenance of the public documentation
* Make proposals to governance to implement changes impacting mStable’s smart contracts
* Develop and maintain the mStable front end application built on top of the mStable protocol
* Work closely with other subDAOs to promote consistency and alignment across the mStable ecosystem, including the provision of design services and developer support to the Ecosystem subDAO

## Specification

### SubDAO Structure
It is proposed that a new Gnosis Safe be created on Ethereum Mainnet, with the option to deploy additional safes with the same signer structure on Polygon or any other chains in the future to meet the operational needs of the subDAO. The proposed signer structure is a 2/3 multisig, with the signer group consisting of 3 current mStable core team members who will contribute to the Builder subDAO. The proposed signer addresses are as follows:

`0x89901e7d025df331e9eC84120D3f81603e50364e (Core Team Member)`

`0xE76Be9C1e10910d6Bc6b63D8031729747910c2f6 (Core Team Member)`

`0xB27a7bD98421EB9eAEE522335F45A6F5B65C5C8d (Core Team Member)`

The Builder subDAO will be authorized to make changes to the signer structure through consensus within the subDAO signer group.

### Builder subDAO Representative
For communications with the mStableDAO, the nominated representative for the Builder subDAO will be the Builder subDAO’s Head of Operations. The representative will be accountable for ensuring that communication and transparency reporting requirements are met by the Builder subDAO. If the representative changes, the mStableDAO Cat Herder will be notified.

### Internal Decision-making
The subDAO signer group will have discretionary power to disburse subDAO funds, provided that the funding use is in line with the proposed funding categories and within the total budgeted amount for the period, including any buffer amount.

Any spending for uses outside the proposed categories would require an additional governance process.

### Proposed budget

***mUSD***

The total amount of mUSD requested under this funding request is $196,614 per month or $786,456 for 4 months.

The current value of non-MTA assets held by the TreasuryDAO & subDAOs is around $3.4 millon. When considering likely costs across other areas such as the Ecosystem subDAO, protocol costs and signer costs, and considering current protocol revenue, this gives the project a runway of around 13 months based on non-MTA assets. This runway length assumes maximum spend by the Builder subDAO, including the buffer amount described below, and therefore reflects the ‘worst case’ rather than intended spend.

It is proposed that $196,614 is transferred upon approval of this funding request, with a [LlamaPay](https://llamapay.io/) stream set up for the remaining amount, delivered between the earliest practical start date and the 30th of November, 2022.

This will provide an upfront balance to be used immediately, while ensuring that the overall amount custodied by the subDAO is no larger than necessary.

The mStableDAO is expected to hold the subDAO accountable for using the funds as outlined and for meeting deliverables over the funding period as defined in this proposal.

The breakdown of this proposed budget is below. Note that these are estimates and it is expected that there will be variance in the exact distribution of funds across each month and across each category.

| Funding Use | Monthly Budget |
| --- | --- |
| Salaries (Product & Engineering) | $102,137 |
| Salaries (Operations & Growth) | $30,903 |
| Security Audits | $25,000 |
| Operational Expenditure | $20,700 |
| Buffer (10%) | $17,874 |
| Total | $196,614 |

A 10% buffer has been added to allow flexibility and ensure that smaller unexpected costs can be met.

Where salaries are denominated in Euro, an exchange rate of 0.96 USD/EUR has been used for conversion to allow small amount of room for movement in the rate.

All unallocated budget after 4 months will be returned to the TreasuryDAO or, at the discretion of the TreasuryDAO, may be subtracted from any subsequent approved funding request. Note that any calculation of unallocated budget should take into account any outstanding accounts payable to ensure that the subDAO can meet future obligations.

To ensure that the subDAO is not incentivized to overspend and use the buffer amount, the TreasuryDAO should hold the Builder subDAO accountable to the original budget and consider use of the buffer as a negative indicator of performance.

***MTA***

In addition to the proposed funding in USD stablecoins, a total amount of 1,175,000 MTA is requested to allow the Builder subDAO to handle the MTA allocations for current team members as per their current agreements with the mStableDAO.

| Funding Use | Amount |
| --- | --- |
| Team bonuses (as specified in current contracts) | 50,000 MTA |
| MTA streams to be initialized for 5 recent hires as specified in current contracts. | 1,000,000 MTA |
| Other uses | 125,000 MTA |

Note that the amount of MTA requested for team allocations cover full entitlements over 3 years, rather than just 4 months of funding. The MTA requested in this proposal will need to be delivered up front to allow the establishment of streams for current contributors. This is considered an appropriate way to fund contributor MTA streams as it allows for simple accounting of MTA treasury and ensures that the Builder subDAO can make a commitment to new contributors around their long term MTA allocation.

For current contributors with MTA streams already underway as per their agreements with the mStableDAO, streams will continue to be issued from the legacy Funding subDAO, which will remain under the custody of the TreasuryDAO. If agreed by both parties at any time, the remaining MTA balance can be transferred to the Builder subDAO and the steam can be reissued by that entity. It is the responsibility of the Builder subDAO representative to inform the TreasuryDAO if a contributor’s agreement will be terminated to ensure that any stream from the Legacy Funding subDAO safe can be discontinued.

If a contributor’s agreement is terminated, the Builder subDAO can hold on to the unallocated MTA from the cancelled stream to compensate a replacement team member if required. Otherwise it must be returned to the TreasuryDAO at the end of the funding period. It should not be used for other uses.

The amount of MTA allocated for ‘other uses’ is primarily requested to cover fees for any MTA streams that might be managed through WorkDAO in the future. It is unlikely that the full amount will be required for this use. ‘Other uses’ could also include small costs such as reimbursing users who have support issues.

Any unallocated MTA at the end of the period will be returned to the TreasuryDAO.

### Areas outside scope of the Builder subDAO

To help clarify the separation difference in responsibilities between the Builder subDAO and the TreasuryDAO/ProtocolDAO, it is important to note some costs that will not be covered under this funding request and would therefore be expected to remain with the TreasuryDAO or be funded by another subDAO.

The following costs are not covered under this proposal:

* Payment for ProtocolDAO and TreasuryDAO signer roles
* Payment of protocol gas costs (only gas costs for Builder subDAO transactions will be covered)
* Payment of any bug bounties that may be awarded by the mStableDAO
* Payment of operational costs that relate to the mStableDAO, rather than to product development. This would include, but is not limited to, the cost of shared Notion workspaces, GitHub, Google Suite, public documentation, public forums, and web hosting.

### Deliverables
* The primary focus and deliverable of the team during this period will be launching and promoting the first Metavault, before turning attention to the next product.
* The team will provide regular updates through Community Calls in collaboration with the proposed Ecosystem subDAO. These calls should be expected to happen every 4-6 weeks on average.
* The Builder subDAO will provide a separate document to the TreasuryDAO prior to the 30th of September, outlining specific OKRs for the remainder of the funding period, which will help the TreasuryDAO to assess performance of the Builder subDAO during the period and prior to the next funding proposal.

### Accountability & Transparency
It is suggested that the mStable TreasuryDAO conducts a monthly review to hold the Builder subDAO accountable to the deliverables defined above, as well as the deliverables provided in the OKR document.

The Builder subDAO commits to providing the TreasuryDAO access to information on all expenditure for each month prior to the 10th of the following month, including the category of expenditure. This will either be provided through a report, or through another tool such as [Parcel](https://www.parcel.money) if the functionality is available.

The TreasuryDAO can also monitor the ongoing development work of the Builder subDAO through the mStable GitHub repository.

### Additional and Future Funding Requests
If the Builder subDAO requires additional funding during this funding period (for example if a new hire is proposed) this will require an additional governance proposal.

To ensure a smooth transition between funding periods, the Builder subDAO will present a subsequent proposal to Meta Governors in late November to early December 2022, proposing funding for the next period. The length of future funding periods will be proposed in the associated funding request.

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
