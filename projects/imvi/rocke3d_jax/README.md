# ROCKE-3D/JAX technical navigation

- Scientific owner: unassigned; see [IMVI project metadata](../project.yaml)
  and [IMVI-001](../../../docs/blocker-register.md#imvi-001).
- Last reviewed: 2026-11-02 (navigation and document responsibilities only).
- Source: [refactor issue #11](https://github.com/nasa-nccs-hpda/ilab-agentic-ai/issues/11)
  and the existing project documents linked below.

Use this page to find implementation fidelity, benchmark evidence, retained
summaries, and graphics processing unit (GPU) operating guidance. IMVI's
authoritative scope, architecture, and model inventory still require project
owner review; start from the [project landing page](../README.md) for that
boundary and contribution guidance.

## Documentation responsibilities

These are navigation responsibilities for the refactor. Scientific authority
remains subject to the blocker register's ownership and evidence requirements.

| Information needed | Start here | Reading limits |
| --- | --- | --- |
| Module inventory and implementation fidelity | [Porting status](PORTING_STATUS.md) | Read the orchestration-fidelity table, shared-module workaround, and next steps alongside the completion table. Module-completion claims require [IMVI-002](../../../docs/blocker-register.md#imvi-002) review. |
| Benchmark setups, numerical comparisons, results, and limitations | [Benchmark findings](FINDINGS.md) | The report contains different comparison scopes. Sections 2c and 2d distinguish production-data orchestration from the narrower kernel CPU/GPU comparison; validation and broad performance claims remain subject to [IMVI-004](../../../docs/blocker-register.md#imvi-004) and [IMVI-005](../../../docs/blocker-register.md#imvi-005). |
| GPU environment setup and operation | [GPU benchmarking guide](README_GPU.md) | Existing Docker, manual, Slurm, and troubleshooting instructions. Its expected-performance estimates require the same IMVI-005 review; environment commands were not revalidated in this navigation pass. |
| Management-facing summary, proposed impact, and return on investment (ROI) | [Executive summary](EXECUTIVE_SUMMARY.md) | Retained with its revision note, placeholder-physics qualifications, and illustrative cost/ROI caveats. Read through to the implementation and benchmark evidence before using its claims. |
| Implementation summary and earlier roadmap | [Implementation summary](SUMMARY.md) | Retained as an overlapping account with its original date and qualifications. Its completion and validation claims remain subject to owner review. |
| Session history and estimated effort | [Session summary](SESSION_SUMMARY.md) | Retained as a workflow record. Its time and cost estimates are approximate; it does not establish accepted scientific validation. |

## Evidence entry points

Follow the scope descriptions in [benchmark findings](FINDINGS.md) to the
corresponding code and retained results:

- Production-data physics orchestration: [driver](p2saom40_driver.py) and
  [comparison code](p2saom40_compare.py), discussed in section 2c.
- Kernel comparison: [Fortran reference](compare_fortran.f90),
  [JAX comparison](compare_jax.py), [report code](compare_report.py), and
  [retained results](compare_data/summary.json), discussed in section 2d.

These links identify evidence for review. This navigation pass did not rerun
the code or independently validate the reported results.

## Scientific authority and consolidation

Conflicting module, validation, and performance claims remain blocked pending
an authorized scientific owner and the required evidence. The
[blocker register](../../../docs/blocker-register.md#imvi-001) owns the
current resolution steps, decision owners, required evidence, and acceptance:

- [IMVI-001](../../../docs/blocker-register.md#imvi-001): scope and scientific ownership.
- [IMVI-002](../../../docs/blocker-register.md#imvi-002): module inventory, fidelity, and validation definitions.
- [IMVI-003](../../../docs/blocker-register.md#imvi-003): shared FLUXES/SURFACE correction and realistic regression evidence.
- [IMVI-004](../../../docs/blocker-register.md#imvi-004): matching reference output and integrated climate validation.
- [IMVI-005](../../../docs/blocker-register.md#imvi-005): equivalent end-to-end performance evidence or owner-approved restricted claims.

All existing summaries and scientific artifacts remain present during this
refactor. Future consolidation or removal requires the applicable blockers
to be resolved through recorded authorized owner acceptance; passing tests or
completing a refactor ticket does not supply that acceptance. The
[improvement plan](../../../docs/repository-improvement-plan.md#follow-on-scientific-and-evidence-work)
sequences the separate deferred inventory and follow-on work.
