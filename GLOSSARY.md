# ILAB Agentic AI Repository

Shared language for organizing repository guidance, project knowledge, agent capabilities, and supporting evidence.

## Language

**Active tree**:
The files and directories present at the current branch tip and therefore presented to contributors as current. Git history is not part of the active tree.
_Avoid_: Current docs, live tree

**Canonical owner**:
The single document responsible for maintaining a particular class of information. Other documents may link to it but do not restate its content.
_Avoid_: Source of truth, master document

**Structural placeholder**:
An otherwise empty tracked directory retained only to advertise a possible future category, usually through a `.gitkeep` file.
_Avoid_: Scaffold, stub directory

**Evidence artifact**:
A retained fixture or compact result that is necessary to verify a scientific or technical claim and cannot be replaced by source code plus documented regeneration steps alone.
_Avoid_: Output file, generated result

**Legacy path**:
An existing repository path retained to avoid disruptive link and history churn even though it does not follow the naming rules applied to new paths.
_Avoid_: Naming exception, grandfathered directory

**Blocker**:
An unresolved condition that prevents a trustworthy decision, claim, or implementation. Ordinary unfinished work is not a blocker.
_Avoid_: Task, backlog item, future work

**Blocker [governance]**:
A blocker that prevents an authoritative ownership or policy decision.

**Blocker [claim]**:
A blocker that prevents making or trusting a scientific, validation, or performance claim.

**Blocker [implementation]**:
A blocker that prevents safe implementation or integration.

**Repository improvement plan**:
The durable repository-level document that organizes improvement work, explains dependencies, and indexes blockers and execution issues. It does not repeat blocker details or status.
_Avoid_: Roadmap, blocker register

**Blocker register**:
The persistent repository-level dashboard of blocker lifecycle, current resolution step, ownership, and accepted evidence. Detailed execution discussion may live in linked GitHub issues.
_Avoid_: Backlog, issue list

**Blocker lifecycle**:
The three allowed blocker states: `open` while the condition applies, `resolution-proposed` while evidence awaits owner verification, and `resolved` after an authorized owner accepts the evidence or withdraws the blocked claim.
_Avoid_: Deferred, in progress, closed
