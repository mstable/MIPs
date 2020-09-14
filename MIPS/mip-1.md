---
mip: 1
title: MIP Purpose and Guidelines
status: Implemented
author: Tom Nash (@morelazers)
discussions-to: https://forums.mstable.org/
created: 2020-09-12
updated: N/A
---

## What is an MIP?

MIP stands for mStable Improvement Proposal, it has been adapted from the EIP (Ethereum Improvement Proposal). The purpose of this process is to ensure changes to mStable are transparent and well governed. An MIP is a design document providing information to the mStable community about a proposed change to the system. The author is responsible for building consensus within the community and documenting dissenting opinions.

## What is an MCCP?

MCCP stands for mStable Configuration Change Proposal. MCCP's are documents for making a case for modifying one of the system configuration variables. The intent is to provide a clear and detailed history behind each configuration change and the rationale behind it at the time it was implemented. The author of the document is responsible for building consensus within the community and documenting dissenting opinions.

## MIP & MCCP Rationale

We intend MIPs and MCCPs to be the primary mechanisms for proposing new features, collecting community input on an issue, and for documenting the design decisions for changes to mStable. Because they are maintained as text files in a versioned repository, their revision history is the historical record of the feature proposal.

It is highly recommended that a single MIP contain a single key proposal or new idea. The more focused the MIP, the more successful it is likely to be.

An MIP or MCCP must meet certain minimum criteria. It must be a clear and complete description of the proposed enhancement. The enhancement must represent a net improvement.

## MIP Work Flow

Parties involved in the process are the *author*, the [*MIP editors*](#mip-editors), the [mStable Core Contributors] and the mStable community.

:warning: Before you begin, vet your idea, this will save you time. Ask the mStable community first if an idea is original to avoid wasting time on something that will be rejected based on prior research (searching the Internet does not always do the trick). It also helps to make sure the idea is applicable to the entire community and not just the author. Just because an idea sounds good to the author does not mean it will have the intend effect. The appropriate public forum to gauge interest around your MIP or MCCP is [the mStable Discord].

Your role as the champion is to write the MIP using the style and format described below, shepherd the discussions in the appropriate forums, and build community consensus around the idea. Following is the process that a successful MIP will move along:

```
[ WIP ] -> [ PROPOSED ] -> [ APPROVED ] -> [ IMPLEMENTED ] X [ REJECTED ]
```

Each status change is requested by the MIP author and reviewed by the MIP editors. Use a pull request to update the status. Please include a link to where people should continue discussing your MIP. The MIP editors will process these requests as per the conditions below.

* **Work in progress (WIP)** -- Once the champion has asked the mStable community whether an idea has any chance of support, they will write a draft MIP as a [pull request]. Consider including an implementation if this will aid people in studying the MIP.
* **Proposed** If agreeable, MIP editor will assign the MIP a number (generally the issue or PR number related to the MIP) and merge your pull request. The MIP editor will not unreasonably deny an MIP. Proposed MIPs will be discussed on governance calls and in Discord. If there is a reasonable level of consensus around the change on the governance call the change will be moved to approved. If the change is contentious a vote of token holders may be held to resolve the issue or approval may be delayed until consensus is reached.
* **Approved** -- This MIP has passed community governance and is now being prioritised for development.

* **Implemented** -- This MIP has been implemented and deployed to mainnet.

* **Rejected** -- This MIP has failed to reach community consensus.

## What belongs in a successful MIP?

Each MIP or MCCP should have the following parts:

- Preamble - RFC 822 style headers containing metadata about the MIP, including the MIP number, a short descriptive title (limited to a maximum of 44 characters), and the author details.
- Simple Summary - “If you can’t explain it simply, you don’t understand it well enough.” Provide a simplified and layman-accessible explanation of the MIP.
- Abstract - a short (~200 word) description of the technical issue being addressed.
- Motivation (*optional) - The motivation is critical for MIPs that want to change mStable. It should clearly explain why the existing specification is inadequate to address the problem that the MIP solves. MIP submissions without sufficient motivation may be rejected outright.
- Specification - The technical specification should describe the syntax and semantics of any new feature.
- Rationale - The rationale fleshes out the specification by describing what motivated the design and why particular design decisions were made. It should describe alternate designs that were considered and related work, e.g. how the feature is supported in other languages. The rationale may also provide evidence of consensus within the community, and should discuss important objections or concerns raised during discussion.
- Test Cases - Test cases may be added during the implementation phase but are required before implementation.
- Copyright Waiver - All MIPs must be in the public domain. See the bottom of this MIP for an example copyright waiver.

## MIP Formats and Templates

MIPs should be written in [markdown] format.
Image files should be included in a subdirectory of the `assets` folder for that MIP as follows: `assets/mip-X` (for mip **X**). When linking to an image in the MIP, use relative links such as `../assets/mip-X/image.png`.

## MIP Header Preamble

Each MIP must begin with an [RFC 822](https://www.ietf.org/rfc/rfc822.txt) style header preamble, preceded and followed by three hyphens (`---`). This header is also termed ["front matter" by Jekyll](https://jekyllrb.com/docs/front-matter/). The headers must appear in the following order. Headers marked with "*" are optional and are described below. All other headers are required.

` mip:` <MIP number> (this is determined by the MIP editor)

` title:` <MIP title>

` author:` <a list of the author's or authors' name(s) and/or username(s), or name(s) and email(s). Details are below.>

` * discussions-to:` \<a url pointing to the official discussion thread at forum.mstable.org\>

` status:` < WIP | PROPOSED | APPROVED | IMPLEMENTED >

` created:` <date created on>

` * updated:` <comma separated list of dates>

` * requires:` <MIP number(s)>

` * resolution:` \<a url pointing to the resolution of this MIP\>

Headers that permit lists must separate elements with commas.

Headers requiring dates will always do so in the format of ISO 8601 (yyyy-mm-dd).

#### `author` header

The `author` header optionally lists the names, email addresses or usernames of the authors/owners of the MIP. Those who prefer anonymity may use a username only, or a first name and a username. The format of the author header value must be:

> Random J. User &lt;address@dom.ain&gt;

or

> Random J. User (@username)

if the email address or GitHub username is included, and

> Random J. User

if the email address is not given.

#### `discussions-to` header

While an MIP is in WIP or Proposed status, a `discussions-to` header will indicate the URL at [forum.mstable.org](https://forum.mstable.org/) where the MIP is being discussed.

#### `created` header

The `created` header records the date that the MIP was assigned a number. Both headers should be in yyyy-mm-dd format, e.g. 2001-08-14.

#### `updated` header

The `updated` header records the date(s) when the MIP was updated with "substantial" changes. This header is only valid for MIPs of Draft and Active status.

#### `requires` header

MIPs may have a `requires` header, indicating the MIP numbers that this MIP depends on.

## Auxiliary Files

MIPs may include auxiliary files such as diagrams. Such files must be named MIP-XXXX-Y.ext, where “XXXX” is the MIP number, “Y” is a serial number (starting at 1), and “ext” is replaced by the actual file extension (e.g. “png”).

## MIP Editors

The current MIP editors are

` * Alex Scott (@alsco77)`

` * George Ornbo (@shapeshed)`

` * James Lefrère (@JamesLefrere)`

## MIP Editor Responsibilities

For each new MIP that comes in, an editor does the following:

- Read the MIP to check if it is ready: sound and complete. The ideas must make technical sense, even if they don't seem likely to get to final status.
- The title should accurately describe the content.
- Check the MIP for language (spelling, grammar, sentence structure, etc.), markup (Github flavored Markdown), code style

If the MIP isn't ready, the editor will send it back to the author for revision, with specific instructions.

Once the MIP is ready for the repository, the MIP editor will:

- Assign an MIP number (generally the PR number or, if preferred by the author, the Issue # if there was discussion in the Issues section of this repository about this MIP)

- Merge the corresponding pull request

- Send a message back to the MIP author with the next step.

Many MIPs are written and maintained by developers with write access to the mStable codebase. The MIP editors monitor MIP changes, and correct any structure, grammar, spelling, or markup mistakes we see.

The editors don't pass judgment on MIPs. We merely do the administrative & editorial part.

## History

The MIP document was derived heavily from the EIP Ethereum Improvement Proposal document in many places text was simply copied and modified. Any comments about the MIP document should be directed to the MIP editors. The history of the EIP is quoted below from the EIP document  for context:

* *"This document (EIP) was derived heavily from [Bitcoin's BIP-0001] written by Amir Taaki which in turn was derived from [Python's PEP-0001]. In many places text was simply copied and modified. Although the PEP-0001 text was written by Barry Warsaw, Jeremy Hylton, and David Goodger, they are not responsible for its use..."* *

June 10, 2019: MIP 1 has been drafted and submitted as a PR.


See [the revision history for further details](https://github.com/mstable/), which is also available by clicking on the History button in the top right of the MIP.

### Bibliography

[the mStable Discord]: https://discord.gg/y2r3jXm
[pull request]: https://github.com/mstable/MIPs/pulls
[markdown]: https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet
[Bitcoin's BIP-0001]: https://github.com/bitcoin/bips
[Python's PEP-0001]: https://www.python.org/dev/peps/
[mStable Engineering Team]: https://github.com/orgs/mstable/people

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
