# ROCKE-3D/JAX removal record

- Decision source: Nexus project author, as relayed by the user on 2026-11-02.
  The author's name was not provided; this does not assign project maintainership.
- Last reviewed: 2026-11-02 (removal scope and references only).
- Execution: [issue #12](https://github.com/nasa-nccs-hpda/ilab-agentic-ai/issues/12),
  whose earlier deferred-inventory scope is superseded by this authorization.

## Authorization and scope

The user relayed the author's statement:

> If you are talking about imvi/rocke3d_jax, yes that can go

The user confirmed: “He says we can delete that folder.” This authorizes
removal of `projects/imvi/rocke3d_jax/` from the active tree, including its
implementation, tests, compiled programs, saved arrays, notebooks, generated
reports, summaries, and local deferred-cleanup inventory. It is a specific
exception to the refactor's original scientific-artifact preservation scope.

The removed subtree contains **245 tracked files, 481,697,664 bytes
(459.383 MiB)** at the last pushed commit, `fdf2892`. The locally drafted
inventory and its additions to the technical README were not committed and
are superseded. This record replaces that deferred cleanup deliverable.

The [remaining Nexus workspace](README.md), including the
[Figure 6 example](examples/rocke3d-figure6/README.md), is outside the deletion
scope. The removal does not change the Figure 6 script, notebook, or retained
image, or the other project-level implementations and tests.

## Historical sources and scientific limits

The [last pushed subtree](https://github.com/nasa-nccs-hpda/ilab-agentic-ai/tree/fdf2892/projects/imvi/rocke3d_jax)
retains the historical source context. Git history is not rewritten; this
removal reduces active-tree content rather than reclaiming historical Git
storage.

The author authorized deletion. No scientific validation, defect correction,
withdrawal of historical claims, or appointment of a scientific decision owner
was supplied. [IMVI-001 through IMVI-005](../../docs/blocker-register.md#imvi-001)
retain their stable records and unresolved ownership/evidence requirements.
The register links removed sources at the historical commit and identifies
the scope review needed before any restoration or reuse.
