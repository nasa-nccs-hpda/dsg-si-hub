# Blocker register

- Register owner: Repository maintainers; each blocker names its decision owner.
- Last updated: 2026-11-02
- Source: User-approved twelve-record inventory supplied for [issue #6](https://github.com/nasa-nccs-hpda/ilab-agentic-ai/issues/6) on 2026-11-02. Repository sources below provide context; importing a record does not independently validate the underlying science.

This dashboard owns blocker lifecycle, ownership, current resolution steps, and evidence. The [repository improvement plan](repository-improvement-plan.md) owns workstreams and sequencing. Follow the [glossary](../GLOSSARY.md) and the [agent update rule](../AGENTS.md#blocker-tracking).

## Lifecycle and maintenance

- `open`: the blocking condition applies.
- `resolution-proposed`: evidence or a proposed resolution awaits authorized owner verification.
- `resolved`: an authorized owner has accepted the evidence or withdrawn the blocked claim. Record who accepted it, when, and the supporting evidence or decision.

Update the summary and detailed record together when state, owner, step, required evidence, or issue links materially change. Preserve stable IDs, sources, limitations, and last-updated dates. Keep required evidence distinct from accepted evidence; issue completion and passing tests do not establish owner acceptance. Unassigned scientific records require an authorized owner before adjudication. Execution issues may be created in future grilling sessions; none is implied by a related refactoring ticket.

## Blocker summary

| ID | Tag | Status | Owner | Current resolution step | Last updated |
|---|---|---|---|---|---|
| [REPO-001](#repo-001) | governance | resolution-proposed | Repository maintainers | Review the governance commit and record acceptance of the approved controls | 2026-11-02 |
| [PACE-001](#pace-001) | claim | open | Melanie Frost | Obtain authorized reproducibility evidence from the NCCS environment | 2026-11-02 |
| [PACE-002](#pace-002) | claim | open | Melanie Frost | Evaluate generalization with a whole-tile split | 2026-11-02 |
| [PACE-003](#pace-003) | claim | open | Melanie Frost | Decide and validate handling of two unsupported polar tiles | 2026-11-02 |
| [PACE-004](#pace-004) | claim | open | Melanie Frost | Compare super-resolution methods under one evaluation design | 2026-11-02 |
| [PACE-005](#pace-005) | claim | open | Melanie Frost | Reconfirm historical v2 neural results with real target labels | 2026-11-02 |
| [PACE-006](#pace-006) | claim | open | Melanie Frost | Investigate the v4 Spatial-CNN full-tile regression | 2026-11-02 |
| [IMVI-001](#imvi-001) | governance | open | unassigned | Name a maintainer and review IMVI scope, architecture, and inventory | 2026-11-02 |
| [IMVI-002](#imvi-002) | claim | open | unassigned | Define “ported” and “validated” and reconcile module-level evidence | 2026-11-02 |
| [IMVI-003](#imvi-003) | implementation | open | unassigned | Correct the shared FLUXES/SURFACE defect and add realistic regression evidence | 2026-11-02 |
| [IMVI-004](#imvi-004) | claim | open | unassigned | Produce matching reference output and integrated climate validation | 2026-11-02 |
| [IMVI-005](#imvi-005) | claim | open | unassigned | Benchmark equivalent end-to-end physics or narrow GPU/ROI claims | 2026-11-02 |

## REPO-001

### Blocker [governance] — Repository governance awaits maintainer acceptance

- Status: resolution-proposed
- Owner: Repository maintainers
- Current step: Review the governance commit for [issue #6](https://github.com/nasa-nccs-hpda/ilab-agentic-ai/issues/6) and record maintainer acceptance of the approved controls.
- Last updated: 2026-11-02
- Required evidence: The glossary, agent-domain guidance, issue-tracker guidance, improvement plan, blocker dashboard, and blocker-update agent rule are present in the active tree.
- Accepted evidence: None recorded; maintainer verification is pending.
- Issue: [#6](https://github.com/nasa-nccs-hpda/ilab-agentic-ai/issues/6).
- Sources: [Glossary](../GLOSSARY.md), [domain guidance](agents/domain.md), [issue-tracker guidance](agents/issue-tracker.md), [plan](repository-improvement-plan.md), this register, and [agent update rule](../AGENTS.md#blocker-tracking). These controls are proposed evidence until committed and accepted by a repository maintainer.

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
- Current step: Identify a responsible maintainer.
- Last updated: 2026-11-02
- Required evidence: Reviewed scope, architecture, ownership, and manifest inventory.
- Accepted evidence: None recorded.
- Issue: Not created; resolve through a future grilling session.
- Sources: [IMVI landing page](../projects/imvi/README.md) states that authoritative scope, inventory, and architecture are not defined; [project metadata](../projects/imvi/project.yaml) has no assigned owners.

## IMVI-002

### Blocker [claim] — “All modules ported and validated” is not trustworthy

- Status: open
- Owner: unassigned
- Current step: Define “ported” and “validated” and assess every module against those definitions.
- Last updated: 2026-11-02
- Required evidence: Owner-approved module inventory, fidelity classification, and direct validation evidence.
- Accepted evidence: None recorded.
- Issue: Not created; resolve through a future grilling session.
- Sources: [Porting status](../projects/imvi/rocke3d_jax/PORTING_STATUS.md) and [executive summary](../projects/imvi/rocke3d_jax/EXECUTIVE_SUMMARY.md) retain completion claims alongside qualifications about placeholder physics and validation scope. This register does not reconcile those claims.

## IMVI-003

### Blocker [implementation] — Shared FLUXES/SURFACE modules retain a production-path defect

- Status: open
- Owner: unassigned
- Current step: Replace the orchestration-only workaround with an approved shared-module correction.
- Last updated: 2026-11-02
- Required evidence: Realistic boundary-condition regression test and owner-approved fix.
- Accepted evidence: None recorded.
- Issue: Not created; resolve through a future grilling session.
- Source: [Porting status](../projects/imvi/rocke3d_jax/PORTING_STATUS.md) describes zeroed land/land-ice fluxes under no-slip conditions and the local workaround in `p2saom40_driver.py`, leaving the shared modules unchanged.

## IMVI-004

### Blocker [claim] — Exact production accuracy and full-model readiness are unverified

- Status: open
- Owner: unassigned
- Current step: Obtain matching instantaneous Fortran output and plan integrated validation.
- Last updated: 2026-11-02
- Required evidence: Per-step reference comparison and JAX-versus-Fortran climate-statistics validation.
- Accepted evidence: None recorded.
- Issue: Not created; resolve through a future grilling session.
- Sources: [Porting status](../projects/imvi/rocke3d_jax/PORTING_STATUS.md), [benchmark findings](../projects/imvi/rocke3d_jax/FINDINGS.md), and [executive summary](../projects/imvi/rocke3d_jax/EXECUTIVE_SUMMARY.md) distinguish production-data and kernel comparisons from future integrated validation. Existing results do not resolve the approved requirement for matching per-step and climate-statistics evidence.

## IMVI-005

### Blocker [claim] — Broad GPU and ROI claims exceed available evidence

- Status: open
- Owner: unassigned
- Current step: Either narrow the claims or design an equivalent end-to-end benchmark.
- Last updated: 2026-11-02
- Required evidence: Target-hardware comparison against compiled Fortran using equivalent physics, or owner-approved restricted wording.
- Accepted evidence: None recorded.
- Issue: Not created; resolve through a future grilling session.
- Sources: [Benchmark findings](../projects/imvi/rocke3d_jax/FINDINGS.md) and [executive summary](../projects/imvi/rocke3d_jax/EXECUTIVE_SUMMARY.md) contain kernel measurements, broader GPU estimates, and a radiation fidelity caveat. Those different scopes require owner review before supporting end-to-end GPU or return-on-investment (ROI) claims.
