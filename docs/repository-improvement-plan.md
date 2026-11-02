# Repository improvement plan

- Owner: Repository maintainers
- Last reviewed: 2026-11-02
- Source: [Approved refactor, issue #5](https://github.com/nasa-nccs-hpda/ilab-agentic-ai/issues/5), its ordered implementation issues, the user's scope clarification, and the later [project-author removal authorization](../projects/imvi/rocke3d-jax-removal.md), relayed on 2026-11-02.

Reduce documentation and structural redundancy while preserving project-specific scientific evidence. This plan owns workstreams, dependencies, and intended document responsibilities. The [blocker register](blocker-register.md) owns blocker details and lifecycle; GitHub issues own execution discussion and status. Use the [glossary](../GLOSSARY.md) for terminology.

## Initial-pass scope

This pass concerns repository structure, navigation, and duplicated guidance. The repository provides curated references, lightweight implementations, and documentation contributed by project teams; it does not require a complete archive of every experiment or a runnable copy of each project's pipeline. Contributors can develop further experiments in their project repositories.

Leave project blockers open for this refactor. They constrain scientific claims and decisions owned by the project teams; resolving them is not a prerequisite for repository cleanup. Preserve existing scientific results, conclusions, limitations, attribution, and evidence. Consolidate entry points and repeated guidance through links to existing project material. If a particular edit would require interpreting competing results or deciding which evidence to discard, defer that edit to the authorized project owner and continue the remaining structural work.

The project author subsequently authorized deletion of `projects/imvi/rocke3d_jax/`, as relayed by the user on 2026-11-02. This specific exception supersedes that subtree's preservation and deferred-inventory work; see the [removal record](../projects/imvi/rocke3d-jax-removal.md). Preserve material outside that directory, including the Figure 6 example. Historical scientific claims remain recorded without treating deletion as scientific validation or claim withdrawal.

## Canonical documentation responsibilities

These responsibilities guide the ordered refactor; the later issues implement the corresponding document changes.

| Information | Canonical owner |
| --- | --- |
| Repository orientation and entry points | [Root README](../README.md) |
| Human contribution policy, placement, lifecycle, standards, and review checks | [CONTRIBUTING.md](../CONTRIBUTING.md) |
| Enforceable agent behavior | [Root AGENTS.md](../AGENTS.md), supplemented by project agent instructions |
| Contribution examples and teaching | [Contribution tutorial](Tutorial-Adding-Information-to-the-Repo.md), linking to policy |
| Shared terminology and accepted architectural decisions | [GLOSSARY.md](../GLOSSARY.md) and `docs/adr/` when decisions warrant records |
| Improvement workstreams and sequencing | This plan |
| Blocker ownership, lifecycle, resolution steps, and evidence | [Blocker register](blocker-register.md) |
| PACE name, status, and maintainers | [PACE project metadata](../projects/PACE-VCF/project.yaml) |
| PACE navigation, ownership entry points, and access constraints | [PACE landing page](../projects/PACE-VCF/README.md), linking to metadata |
| PACE scientific roadmap, results, and future work | [PACE project overview](../projects/PACE-VCF/knowledge/overview/project-overview.md) |
| PACE workflow retrospective | [PACE agentic workflow](../projects/PACE-VCF/knowledge/overview/agentic-workflow.md) |
| IMVI project entry points and reviewed scope | [IMVI landing page](../projects/imvi/README.md), subject to project-owner review |
| Removed IMVI ROCKE-3D/JAX material | [Removal record](../projects/imvi/rocke3d-jax-removal.md) owns authorization, scope, and historical-source navigation; the blocker register retains scientific ownership and evidence requirements |

## Ordered refactor

Execute these eight issues strictly in order. Each issue after #6 depends on the preceding issue; consult GitHub for completion status.

| Order | Execution issue | Result needed by the next step |
| --- | --- | --- |
| 1 | [#6: Establish repository governance and blocker tracking](https://github.com/nasa-nccs-hpda/ilab-agentic-ai/issues/6) | Shared terminology, document responsibilities, plan, register, and agent update rules |
| 2 | [#7: Deduplicate repository-level contribution guidance](https://github.com/nasa-nccs-hpda/ilab-agentic-ai/issues/7) | Distinct orientation, policy, agent, and tutorial responsibilities |
| 3 | [#8: Replace placeholder taxonomy with on-demand structure](https://github.com/nasa-nccs-hpda/ilab-agentic-ai/issues/8) | Active-tree directories containing implemented content and contribution paths that are not ignored |
| 4 | [#9: Move the ROCKE-3D Figure 6 reproduction into IMVI](https://github.com/nasa-nccs-hpda/ilab-agentic-ai/issues/9) | Project-owned example with corrected references and regeneration guidance |
| 5 | [#10: Clarify PACE documentation ownership](https://github.com/nasa-nccs-hpda/ilab-agentic-ai/issues/10) | Metadata, navigation, science, retrospective, and agent responsibilities separated |
| 6 | [#11: Establish IMVI technical navigation without adjudicating science](https://github.com/nasa-nccs-hpda/ilab-agentic-ai/issues/11) | Document responsibilities and unresolved scientific authority; subsequent author-approved removal is recorded by #12 |
| 7 | [#12: Remove the ROCKE-3D/JAX subtree with project-author approval](https://github.com/nasa-nccs-hpda/ilab-agentic-ai/issues/12) | Scoped removal, authorization record, historical references, and updated navigation; supersedes the original deferred inventory |
| 8 | [#13: Verify and hand off the redundancy refactor](https://github.com/nasa-nccs-hpda/ilab-agentic-ai/issues/13) | Navigation, links, exclusions, scientific preservation, and tracking handoff verified |

## On-demand structure

Keep project-specific information under `projects/<project>/`; promote information to `knowledge/` only when reuse is demonstrated. Repeatable procedures belong in `skills/`, reusable roles in `agents/`, external-platform guidance in `integrations/`, and behavioral verification in `evals/`.

Retain [templates](../templates/) as starting points. Create dataset, model, sensor, algorithm, troubleshooting, prompt, example, evaluation, skill, or agent subareas when real content needs them. Keep repository documentation flat except where a subarea contains real content, such as agent guidance or accepted decision records. Future categories belong in this plan and templates rather than empty tracked directories.

The following are possible categories, not an inventory of implemented directories. Create only the subareas needed by a contribution; do not recreate the entire taxonomy.

| Area | Possible subareas and purpose |
| --- | --- |
| Shared knowledge | `missions/`, `sensors/`, `datasets/`, `models/`, `algorithms/`, `scientific-domains/`, and `computing-platforms/` for cross-project references |
| Project knowledge | `overview/`, `datasets/`, `models/`, `sensors/`, `algorithms/`, and `troubleshooting/` for project-specific context |
| Skills | `data-engineering/`, `earth-observation/`, `model-development/`, `scientific-computing/`, and `software-engineering/` for focused procedures when implemented |
| Integrations | `slurm/` for scheduler guidance, `github/` for collaboration guidance, and `mcp/` for Model Context Protocol guidance |
| Evaluations | `skills/` for focused skill scenarios, `agents/` for role behavior, and `projects/` for project acceptance cases |
| Tools | `scaffold/` for creating entries, `validate/` for repository checks, and `catalog/` for indexes and inventories |

Project prompts, examples, evaluations, skills, and agents follow the [project template](../templates/project/README.md). Documentation subareas such as `docs/adr/` require actual records; general guides remain directly under `docs/`.

New directories use lowercase, hyphen-separated names. The existing `projects/PACE-VCF/` directory is a legacy path, retained to avoid disruptive link and history churn. Personal repository-local skills stay untracked through checkout-only exclusions in `.git/info/exclude`, rather than a shared ignore rule.

## Follow-on scientific and evidence work

Project teams may take up scientific and evidence work separately after the refactor. When an authorized project owner chooses to pursue a blocker, use its stable ID for a focused grilling session and create an execution issue when a concrete resolution path is agreed. This follow-on work is outside the initial pass. For PACE, consult [PACE-001 through PACE-006](blocker-register.md#pace-001) before extending reproducibility, generalization, coverage, method-comparison, historical-label, or regression claims. For IMVI, begin with [IMVI-001](blocker-register.md#imvi-001) before decisions that require scientific ownership; consult the remaining IMVI records before consolidating claims or deleting evidence artifacts.

The [author-approved removal record](../projects/imvi/rocke3d-jax-removal.md) replaces #12's original deferred-inventory deliverable for `projects/imvi/rocke3d_jax/`. Any future restoration or reuse of that material requires review against the historical sources and applicable blocker requirements. Record resulting blocker changes in the register rather than copying their status into this plan.

## Boundaries and verification

Preserve NMC AI Hub, Mantle, Codex, and Claude setup documentation and PACE metrics-v4 conclusions. The sole scientific-artifact deletion exception is the author-approved `projects/imvi/rocke3d_jax/` removal above. Preserve unresolved IMVI scientific, validation, and performance concerns through the blocker register and historical sources; no disputed-claim reconciliation is authorized.

Validate changed internal links, repository navigation, absence of tracked structural placeholders after #8, checkout-only personal-skill exclusions, and the final blocker handoff in #13. A completed execution issue does not resolve a scientific blocker without the authorized owner's recorded acceptance.

The [final verification ticket, #13](https://github.com/nasa-nccs-hpda/ilab-agentic-ai/issues/13), owns the refactor's verification evidence, comparison baseline, limitations, and delivery handoff. Use the [issue-tracker workflow](agents/issue-tracker.md) for commit, push, PR, and merge progress. Future project work follows the [scientific and evidence handoff](#follow-on-scientific-and-evidence-work) above and the current blocker records rather than treating the structural refactor as scientific acceptance.
