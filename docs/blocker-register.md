# Blocker register

- Register owner: Repository maintainers; each blocker names its decision owner.
- Last updated: 2026-11-02
- Source: User-approved twelve-record inventory supplied for [issue #6](https://github.com/nasa-nccs-hpda/ilab-agentic-ai/issues/6) on 2026-11-02. Repository sources below provide context; importing a record does not independently validate the underlying science.

This dashboard owns blocker lifecycle, ownership, current resolution steps, and evidence. The [repository improvement plan](repository-improvement-plan.md) owns workstreams and sequencing. Follow the [glossary](../GLOSSARY.md) and the [agent update rule](../AGENTS.md#blocker-tracking).

## Relationship to the repository refactor

Per the user's scope clarification on 2026-11-02, leave all project blockers open during the initial repository refactor. They prevent the claims or project decisions named in their records; they do not prevent structural cleanup that preserves scientific content and evidence. Resolution remains with the authorized project owners, including ownership decisions still unassigned in this register. Defer any cleanup edit requiring scientific adjudication or evidence deletion, and continue independent navigation and documentation work within the [initial-pass scope](repository-improvement-plan.md#initial-pass-scope).

The user's subsequent [project-author authorization](../projects/imvi/rocke3d-jax-removal.md) on 2026-11-02 permits removal of `projects/imvi/rocke3d_jax/`. IMVI-002 through IMVI-005 now track historical concerns relevant before restoring or reusing that material; their sources link the last pushed snapshot. Deletion permission does not establish scientific validation, defect correction, or withdrawal of historical claims, so these records remain open. The author's name and an ongoing scientific decision owner were not supplied. IMVI-001 continues to apply to the remaining IMVI workspace.

## Lifecycle and maintenance

- `open`: the blocking condition applies.
- `resolution-proposed`: evidence or a proposed resolution awaits authorized owner verification.
- `resolved`: an authorized owner has accepted the evidence or withdrawn the blocked claim. Record who accepted it, when, and the supporting evidence or decision.

Update the summary and detailed record together when state, owner, step, required evidence, or issue links materially change. Preserve stable IDs, sources, limitations, and last-updated dates. Keep required evidence distinct from accepted evidence; issue completion and passing tests do not establish owner acceptance. Unassigned scientific records require an authorized owner before adjudication. Execution issues may be created in future grilling sessions; none is implied by a related refactoring ticket.

## Blocker summary

| ID | Tag | Status | Owner | Current resolution step | Last updated |
|---|---|---|---|---|---|
| [REPO-001](#repo-001) | governance | resolved | Repository maintainers | Acceptance recorded; no remaining resolution step | 2026-11-02 |
| [PACE-001](#pace-001) | claim | open | Melanie Frost | Obtain authorized reproducibility evidence from the NCCS environment | 2026-11-02 |
| [PACE-002](#pace-002) | claim | open | Melanie Frost | Evaluate generalization with a whole-tile split | 2026-11-02 |
| [PACE-003](#pace-003) | claim | open | Melanie Frost | Decide and validate handling of two unsupported polar tiles | 2026-11-02 |
| [PACE-004](#pace-004) | claim | open | Melanie Frost | Compare super-resolution methods under one evaluation design | 2026-11-02 |
| [PACE-005](#pace-005) | claim | open | Melanie Frost | Reconfirm historical v2 neural results with real target labels | 2026-11-02 |
| [PACE-006](#pace-006) | claim | open | Melanie Frost | Investigate the v4 Spatial-CNN full-tile regression | 2026-11-02 |
| [IMVI-001](#imvi-001) | governance | open | unassigned | Name a maintainer and review remaining IMVI scope after the authorized removal | 2026-11-02 |
| [IMVI-002](#imvi-002) | claim | open | unassigned | Determine disposition of historical module-completion claims before reuse | 2026-11-02 |
| [IMVI-003](#imvi-003) | implementation | open | unassigned | Obtain approved shared-module correction and regression evidence before reuse | 2026-11-02 |
| [IMVI-004](#imvi-004) | claim | open | unassigned | Review historical accuracy/readiness claims and obtain validation before reuse | 2026-11-02 |
| [IMVI-005](#imvi-005) | claim | open | unassigned | Review historical GPU/ROI claims and benchmark or narrow them before reuse | 2026-11-02 |

## REPO-001

### Blocker [governance] — Repository governance controls accepted

- Status: resolved
- Owner: Repository maintainers
- Current step: Acceptance recorded; no remaining resolution step.
- Last updated: 2026-11-02
- Required evidence: The glossary, agent-domain guidance, issue-tracker guidance, improvement plan, blocker dashboard, and blocker-update agent rule are present in the active tree.
- Accepted evidence: Governance controls committed in `9029346`, accepted by the user on 2026-11-02: “REPO-001 direction approved.”
- Issue: [#6](https://github.com/nasa-nccs-hpda/ilab-agentic-ai/issues/6).
- Sources: [Glossary](../GLOSSARY.md), [domain guidance](agents/domain.md), [issue-tracker guidance](agents/issue-tracker.md), [plan](repository-improvement-plan.md), this register, and [agent update rule](../AGENTS.md#blocker-tracking), committed in `9029346`; the user's approval in this conversation records acceptance.

## PACE-001

### Blocker [claim] — Results are not independently reproducible from this repository

- Status: open
- Owner: Melanie Frost
- Current step: Obtain authorized NCCS execution evidence and reviewer sign-off.
- Last updated: 2026-11-02
- Required evidence: Reproducible run evidence or approved compact evidence artifacts with regeneration provenance.
- Accepted evidence: None recorded.
- Issue: Not created; resolve through a future grilling session.
- Source: [PACE landing page](../projects/PACE-VCF/README.md) describes the private working code, NCCS environment, restricted inputs, and repository execution limitations.

## PACE-002

### Blocker [claim] — Unseen-area generalization is not established

- Status: open
- Owner: Melanie Frost
- Current step: Design and run a whole-tile train/test split.
- Last updated: 2026-11-02
- Required evidence: Owner-approved tile-level evaluation results.
- Accepted evidence: None recorded.
- Issue: Not created; resolve through a future grilling session.
- Sources: [Project future work](../projects/PACE-VCF/knowledge/overview/project-overview.md#future-work) and [three-model comparison](../projects/PACE-VCF/knowledge/models/three-model-comparison.md) describe the chip-level split and limits on interpreting held-out scores.

## PACE-003

### Blocker [claim] — Complete global coverage is not established

- Status: open
- Owner: Melanie Frost
- Current step: Decide whether to exclude, fall back, or change models for the two polar tiles.
- Last updated: 2026-11-02
- Required evidence: Approved coverage policy and output evidence for all claimed tiles.
- Accepted evidence: None recorded.
- Issue: Not created; resolve through a future grilling session.
- Source: [Polar tiles with empty bands](../projects/PACE-VCF/knowledge/troubleshooting/polar-tiles-empty-bands.md).

## PACE-004

### Blocker [claim] — Super-resolution methods are not directly comparable

- Status: open
- Owner: Melanie Frost
- Current step: Select one shared evaluation design.
- Last updated: 2026-11-02
- Required evidence: Results for all compared methods under the same holdout methodology.
- Accepted evidence: None recorded.
- Issue: Not created; resolve through a future grilling session.
- Source: [Super-resolution comparison](../projects/PACE-VCF/knowledge/models/super-resolution-2km-to-250m.md) documents differing within-tile checkerboard and whole-tile holdout designs.

## PACE-005

### Blocker [claim] — Historical v2 neural target labels remain unverified

- Status: open
- Owner: Melanie Frost
- Current step: Rerun the historical output with real target names displayed.
- Last updated: 2026-11-02
- Required evidence: Output confirming the reported values map to the intended target bands.
- Accepted evidence: None recorded.
- Issue: Not created; resolve through a future grilling session.
- Source: [Historical three-model comparison](../projects/PACE-VCF/knowledge/models/three-model-comparison.md) discusses recovering target names from label rasters and the risk of generic band labels. Its reported mapping is not independently reconfirmed by this register.

## PACE-006

### Blocker [claim] — The v4 Spatial-CNN global regression is unexplained

- Status: open
- Owner: Melanie Frost
- Current step: Perform controlled reruns and investigate the full-tile bias/regression.
- Last updated: 2026-11-02
- Required evidence: Reproduction evidence and owner interpretation of the cause.
- Accepted evidence: None recorded.
- Issue: Not created; resolve through a future grilling session.
- Sources: [Project future work](../projects/PACE-VCF/knowledge/overview/project-overview.md#future-work) and [three-model comparison](../projects/PACE-VCF/knowledge/models/three-model-comparison.md) record the full-tile regression despite normal chip scores.

## IMVI-001

### Blocker [governance] — IMVI lacks authoritative scope and ownership

- Status: open
- Owner: unassigned
- Current step: Identify a responsible maintainer and review the remaining IMVI scope, architecture, and inventory after the authorized subtree removal.
- Last updated: 2026-11-02
- Required evidence: Reviewed scope, architecture, ownership, and manifest inventory.
- Accepted evidence: None recorded.
- Issue: No scientific resolution issue; the scoped removal is tracked in [#12](https://github.com/nasa-nccs-hpda/ilab-agentic-ai/issues/12).
- Scope update: The [author-approved removal](../projects/imvi/rocke3d-jax-removal.md) does not establish reviewed scope or appoint an ongoing maintainer for the remaining workspace.
- Sources: [IMVI landing page](../projects/imvi/README.md) states that authoritative scope, inventory, and architecture are not defined; [project metadata](../projects/imvi/project.yaml) has no assigned owners.

## IMVI-002

### Blocker [claim] — Historical “all modules ported and validated” claim remains unverified

- Status: open
- Owner: unassigned
- Current step: Obtain an authorized owner's disposition of the historical module-completion claims before reuse; if retained, define “ported” and “validated” and assess every module against those definitions.
- Last updated: 2026-11-02
- Required evidence: Owner-approved module inventory, fidelity classification, and direct validation evidence.
- Accepted evidence: None recorded.
- Issue: No scientific resolution issue; the scoped removal is tracked in [#12](https://github.com/nasa-nccs-hpda/ilab-agentic-ai/issues/12).
- Scope update: Applies to restoration or reuse of the [removed subtree](../projects/imvi/rocke3d-jax-removal.md). Removal permission does not validate or explicitly withdraw these historical claims.
- Sources: Historical [porting status](https://github.com/nasa-nccs-hpda/ilab-agentic-ai/blob/fdf2892/projects/imvi/rocke3d_jax/PORTING_STATUS.md) and [executive summary](https://github.com/nasa-nccs-hpda/ilab-agentic-ai/blob/fdf2892/projects/imvi/rocke3d_jax/EXECUTIVE_SUMMARY.md) retain completion claims alongside qualifications about placeholder physics and validation scope. This register does not reconcile those claims.

## IMVI-003

### Blocker [implementation] — Historical shared FLUXES/SURFACE defect requires review before reuse

- Status: open
- Owner: unassigned
- Current step: Before restoration or reuse, obtain an approved shared-module correction replacing the orchestration-only workaround and realistic boundary-condition regression evidence.
- Last updated: 2026-11-02
- Required evidence: Realistic boundary-condition regression test and owner-approved fix.
- Accepted evidence: None recorded.
- Issue: No scientific resolution issue; the scoped removal is tracked in [#12](https://github.com/nasa-nccs-hpda/ilab-agentic-ai/issues/12).
- Scope update: The affected modules were [removed with author approval](../projects/imvi/rocke3d-jax-removal.md); removal does not constitute a validated fix.
- Source: Historical [porting status](https://github.com/nasa-nccs-hpda/ilab-agentic-ai/blob/fdf2892/projects/imvi/rocke3d_jax/PORTING_STATUS.md) describes zeroed land/land-ice fluxes under no-slip conditions and the local workaround in `p2saom40_driver.py`, leaving the shared modules unchanged in that snapshot.

## IMVI-004

### Blocker [claim] — Historical production accuracy and full-model readiness remain unverified

- Status: open
- Owner: unassigned
- Current step: Review the historical accuracy/readiness claims before reuse; obtain matching instantaneous Fortran output and integrated climate validation for any retained claims.
- Last updated: 2026-11-02
- Required evidence: Per-step reference comparison and JAX-versus-Fortran climate-statistics validation.
- Accepted evidence: None recorded.
- Issue: No scientific resolution issue; the scoped removal is tracked in [#12](https://github.com/nasa-nccs-hpda/ilab-agentic-ai/issues/12).
- Scope update: Applies to restoration or reuse of the [removed material](../projects/imvi/rocke3d-jax-removal.md); deletion permission supplies no validation evidence or explicit withdrawal of historical claims.
- Sources: Historical [porting status](https://github.com/nasa-nccs-hpda/ilab-agentic-ai/blob/fdf2892/projects/imvi/rocke3d_jax/PORTING_STATUS.md), [benchmark findings](https://github.com/nasa-nccs-hpda/ilab-agentic-ai/blob/fdf2892/projects/imvi/rocke3d_jax/FINDINGS.md), and [executive summary](https://github.com/nasa-nccs-hpda/ilab-agentic-ai/blob/fdf2892/projects/imvi/rocke3d_jax/EXECUTIVE_SUMMARY.md) distinguish production-data and kernel comparisons from future integrated validation. Existing results do not resolve the approved requirement for matching per-step and climate-statistics evidence.

## IMVI-005

### Blocker [claim] — Historical broad GPU and ROI claims exceed available evidence

- Status: open
- Owner: unassigned
- Current step: Review historical GPU/ROI claims before reuse; either obtain owner-approved restricted wording or benchmark equivalent end-to-end physics on the target hardware.
- Last updated: 2026-11-02
- Required evidence: Target-hardware comparison against compiled Fortran using equivalent physics, or owner-approved restricted wording.
- Accepted evidence: None recorded.
- Issue: No scientific resolution issue; the scoped removal is tracked in [#12](https://github.com/nasa-nccs-hpda/ilab-agentic-ai/issues/12).
- Scope update: Applies to restoration or reuse of the [removed material](../projects/imvi/rocke3d-jax-removal.md); deletion permission does not validate or explicitly withdraw historical performance claims.
- Sources: Historical [benchmark findings](https://github.com/nasa-nccs-hpda/ilab-agentic-ai/blob/fdf2892/projects/imvi/rocke3d_jax/FINDINGS.md) and [executive summary](https://github.com/nasa-nccs-hpda/ilab-agentic-ai/blob/fdf2892/projects/imvi/rocke3d_jax/EXECUTIVE_SUMMARY.md) contain kernel measurements, broader GPU estimates, and a radiation fidelity caveat. Those different scopes require owner review before supporting end-to-end GPU or return-on-investment (ROI) claims.
