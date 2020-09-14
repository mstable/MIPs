---
mccp: 1
title: MCCP Purpose and Guidelines
status: Implemented
author: Tom Nash <@tomnashflex>
discussions-to: https://discord.gg/y2r3jXm
created: 2020-09-12
---

## What is an MCCP?

MCCP stands for mStable Configuration Change Proposal. MCCP's are documents to make a case for modifying one of the system configuration variables. The intent is to provide a clear and detailed history behind each configuration change and the rationale behind it at the time it was implemented. The author of the document is responsible for building consensus within the community and documenting dissenting opinions.

## MCCP Rationale

We intend MCCPs to be the primary mechanisms for proposing configuration changes to mStable. Because they are maintained as text files in a versioned repository, their revision history is the historical record of the configuration change proposal.

It is highly recommended that a single MCCP contain a single variable change. The more focused the MCCP, the more successful it is likely to be.

An MCCP must meet certain minimum criteria. It must be a clear and complete description of the proposed variable change.

## MCCP Work Flow

Parties involved in the process are the *author*, the [*MIP editors*](#mip-editors), and the [mStable Engineering Team].

:warning: Before you begin, vet your idea, this will save you time. Ask the mStable community first if the proposed change is original to avoid wasting time on something that will be rejected based on prior research (searching the Internet does not always do the trick). It also helps to make sure the idea is applicable to the entire community and not just the author. Just because an idea sounds good to the author does not mean it will have the intend effect. The appropriate public forum to gauge interest around your MCCP is [the mStable Discord].

Your role as the champion is to write the MCCP using the style and format described below, shepherd the discussions in the appropriate forums, and build community consensus around the idea. Following is the process that a successful MCCP will move along:

```
[ WIP ] -> [ PROPOSED ] -> [ APPROVED ] -> [ IMPLEMENTED ]
```

Each status change is requested by the MCCP author and reviewed by the MIP editors. Use a pull request to update the status. Please include a link to where people should continue discussing your MCCP. The MIP editors will process these requests as per the conditions below.

* **Work in progress (WIP)** -- Once the champion has asked the mStable community whether an idea has any chance of support, they will write a draft MCCP as a [pull request].

* **Proposed** If agreeable, MIP editor will assign the MCCP a number (generally the issue or PR number related to the MCCP) and merge your pull request. The MIP editor will not unreasonably deny an MCCP. Proposed MCCPs will be discussed on governance calls and in Discord. If there is a reasonable level of consensus around the change on the governance call the change will be moved to approved. If the change is contentious a vote of token holders may be held to resolve the issue or approval may be delayed until consensus is reached.

* **Approved** -- This MCCP has passed community governance and is now being prioritised.

* **Implemented** -- This MCCP has been implemented and the variable changed on mainnet.

## What belongs in a successful MCCP?

Each MCCP should have the following parts:

- Preamble - RFC 822 style headers containing metadata about the MCCP, including the MCCP number, a short descriptive title (limited to a maximum of 44 characters), and the author details.
- Simple Summary - “If you can’t explain it simply, you don’t understand it well enough.” Provide a simplified and layman-accessible explanation of the MCCP.
- Abstract - a short (~200 word) description of the variable change proposed.
- Motivation (*optional) - The motivation is critical for MCCPs that want to update variables within mStable. It should clearly explain why the existing variable is not incentive aligned. MCCP submissions without sufficient motivation may be rejected outright.
- Copyright Waiver - All MCCPs must be in the public domain. See the bottom of this MCCP for an example copyright waiver.

## MCCP Formats and Templates

MCCPs should be written in [markdown] format.
Image files should be included in a subdirectory of the `assets` folder for that MCCP as follows: `assets/mccp-X` (for mccp **X**). When linking to an image in the MCCP, use relative links such as `../assets/mccp-X/image.png`.

## MCCP Header Preamble

Each MCCP must begin with an [RFC 822](https://www.ietf.org/rfc/rfc822.txt) style header preamble, preceded and followed by three hyphens (`---`). This header is also termed ["front matter" by Jekyll](https://jekyllrb.com/docs/front-matter/). The headers must appear in the following order. Headers marked with "*" are optional and are described below. All other headers are required.

` mip:` <MCCP number> (this is determined by the MIP editor)

` title:` <MCCP title>

` author:` <a list of the author's or authors' name(s) and/or username(s), or name(s) and email(s). Details are below.>

` * discussions-to:` \<a url pointing to the official discussion thread\>

` status:` < WIP | PROPOSED | APPROVED | IMPLEMENTED >

` created:` <date created on>

` * updated:` <comma separated list of dates>

` * requires:` <MIP number(s)>

Headers that permit lists must separate elements with commas.

Headers requiring dates will always do so in the format of ISO 8601 (yyyy-mm-dd).

#### `author` header

The `author` header optionally lists the names, email addresses or usernames of the authors/owners of the MCCP. Those who prefer anonymity may use a username only, or a first name and a username. The format of the author header value must be:

> Random J. User &lt;address@dom.ain&gt;

or

> Random J. User (@username)

if the email address or GitHub username is included, and

> Random J. User

if the email address is not given.

#### `discussions-to` header

While an MCCP is in WIP or Proposed status, a `discussions-to` header will indicate the mailing list or URL where the MCCP is being discussed.

#### `created` header

The `created` header records the date that the MCCP was assigned a number. Both headers should be in yyyy-mm-dd format, e.g. 2001-08-14.

#### `updated` header

The `updated` header records the date(s) when the MCCP was updated with "substantial" changes. This header is only valid for MCCPs of Draft and Active status.

#### `requires` header

MCCPs may have a `requires` header, indicating the MCCP numbers that this MCCP depends on.

## Auxiliary Files

MCCPs may include auxiliary files such as diagrams. Such files must be named MCCP-XXXX-Y.ext, where “XXXX” is the MCCP number, “Y” is a serial number (starting at 1), and “ext” is replaced by the actual file extension (e.g. “png”).

## MIP Editors

The current MIP editors are

` * Alex Scott (@alsco77)`

` * George Ornbo (@shapeshed)`

` * James Lefrère (@JamesLefrere)`

## MIP Editor Responsibilities

For each new MCCP that comes in, an editor does the following:

- Read the MCCP to check if it is ready: sound and complete. The ideas must make technical sense, even if they don't seem likely to get to final status.
- The title should accurately describe the content.
- Check the MCCP for language (spelling, grammar, sentence structure, etc.), markup (Github flavored Markdown), code style

If the MCCP isn't ready, the editor will send it back to the author for revision, with specific instructions.

Once the MCCP is ready for the repository, the MIP editor will:

- Assign an MCCP number (generally the PR number or, if preferred by the author, the Issue # if there was discussion in the Issues section of this repository about this MCCP)

- Merge the corresponding pull request

- Send a message back to the MCCP author with the next step.

Many MCCPs are written and maintained by developers with write access to the mStable codebase. The MIP editors monitor MCCP changes, and correct any structure, grammar, spelling, or markup mistakes we see.

The editors don't pass judgment on MCCPs. We merely do the administrative & editorial part.

## History

The MCCP document was derived heavily from the EIP Ethereum  Improvement Proposal document in many places text was simply copied and modified. Any comments about the MCCP document should be directed to the MIP editors. The history of the EIP is quoted below from the EIP document  for context:

* *"This document (EIP) was derived heavily from [Bitcoin's BIP-0001] written by Amir Taaki which in turn was derived from [Python's PEP-0001]. In many places text was simply copied and modified. Although the PEP-0001 text was written by Barry Warsaw, Jeremy Hylton, and David Goodger, they are not responsible for its use..."* *

June 10, 2019: MCCP-1 has been drafted and submitted as a PR.


See [the revision history for further details](https://github.com/mstable/**), which is also available by clicking on the History button in the top right of the MCCP.

### Bibliography

[the mStable Discord]: https://discord.gg/y2r3jXm
[pull request]: https://github.com/mstable/MIPs/pulls
[markdown]: https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet
[Bitcoin's BIP-0001]: https://github.com/bitcoin/bips
[Python's PEP-0001]: https://www.python.org/dev/peps/
[mStable Engineering Team]: https://github.com/orgs/mstable/people

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
