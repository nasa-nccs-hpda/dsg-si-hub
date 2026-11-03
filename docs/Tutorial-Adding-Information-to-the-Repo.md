# How to Add Agent Context to `ilab-agentic-ai`

This tutorial shows how to turn an agent session into useful project context. It uses hypothetical examples, not findings about the projects already in this repository.

Use [CONTRIBUTING.md](../../CONTRIBUTING.md) for placement, lifecycle, standards, and review policy. [AGENTS.md](../../AGENTS.md) owns instructions for agents working here. The examples below illustrate those policies; they do not introduce additional requirements.

## Choose what survives the session

Imagine a session debugging distributed training. You learned that one- and two-GPU jobs work, an eight-GPU job hangs during initialization, and three environment-variable changes did not fix it.

A useful summary distinguishes:

- **Observed:** the smaller jobs completed and the eight-GPU job hung.
- **Hypothesis:** initialization in the NVIDIA Collective Communications Library (NCCL) may be involved.
- **Already tried:** the three changes and their observed outcomes.
- **Next action:** check whether every rank reaches `dist.init_process_group()`.

This gives the next person an actionable starting point. A pasted conversation would make them reconstruct those distinctions from debugging noise. See the [documentation standards](../../CONTRIBUTING.md#documentation-standards) for what to retain.

## Start a project from the template

Following the [basic workflow](../../CONTRIBUTING.md#basic-workflow), a new project could start with:

```bash
mkdir -p projects/example-project
cp projects/template-project/{README.md,AGENTS.md,project.yaml} projects/example-project/
```

The [project template](../../projects/template-project/README.md) provides `README.md`, `AGENTS.md`, and `project.yaml`. Fill them with the project's actual context; a useful contribution can be a small reference to work maintained in the project's own repository. Copy the template's optional skill, agent, and evaluation examples individually when the project needs them.

A landing page might look like this:

```markdown
# Example project

A short description of the project and the resources collected here.

- [Metadata and maintainers](project.yaml)
- [Project overview](knowledge/overview.md)
- [Agent instructions](AGENTS.md)
- Working repository: <project repository link>
```

The overview link is illustrative: add its target when there is real context to publish. The landing page helps readers find that context without copying it into several documents.

Project agent instructions could capture a specific operational constraint:

```markdown
# Project agent instructions

- Read the dataset manifest before changing loader assumptions.
- Keep raw input files unchanged; write derived data to a separate location.
```

Adapt the example to documented project needs. The root agent instructions still apply, so project instructions can concentrate on what is specific to that project.

## Write a focused knowledge entry

Suppose the session clarified how a project uses Cloud Physics Lidar (CPL) data. Start from the [dataset template](../../knowledge/templates/dataset-entry.md) and the [placement policy](../../CONTRIBUTING.md#choose-the-contribution-type).

An illustrative entry under `projects/example-project/knowledge/datasets/cpl.md` could contain:

```markdown
# CPL

## Project usage

<Describe the project's documented use and any approved fallback.>

## Variables and coordinates

<List variables, units, vertical coordinate, and geolocation conventions.>

## Known issues

<Describe missing observations, sampling differences, and fill values
confirmed for the data being used.>

## Source

<Authoritative documentation and the dataset version inspected.>

## Owner and last reviewed

<Responsible maintainer and review date.>
```

The placeholders show which questions the entry answers. Replace them with sourced information before submitting it. If a second project needs the same reference, the [contribution lifecycle](../../CONTRIBUTING.md#contribution-lifecycle) explains promotion; project-specific usage can stay near its users.

## Optionally keep session-status files

Some teams benefit from a small handoff file. Others use their project issue tracker or another existing record. **Project session-status files are optional**, as described in the [contribution lifecycle](../../CONTRIBUTING.md#contribution-lifecycle).

If a team chooses this pattern, `status/current.md` might contain:

```markdown
# Current status

Last updated: 2026-09-04

## Objective

Enable distributed training of the model.

## Working

The dataset loader and the one- and two-GPU training jobs completed.

## Current problem

An eight-GPU job hangs after `Initializing process group`.

## Already tried

`NCCL_DEBUG=INFO`, an explicit `MASTER_ADDR`, and an explicit `MASTER_PORT`
did not resolve the hang.

## Next action

Check whether every rank reaches `dist.init_process_group()`, then inspect
the logs from the eight-GPU run.
```

The date and outcomes are part of this hypothetical example. Its value is the distinction between an observation, attempts already made, and the next investigation.

A separate decision entry can prevent the same design discussion from recurring. For example, `status/decisions.md` could include:

```markdown
# Decisions

## 2026-09-02 — Keep time as an explicit tensor dimension

### Decision

Use [B, T, C, H, W] for model input.

### Reason

The planned architectures need to operate over time explicitly.

### Rejected alternative

Flattening time and channels into [B, T*C, H, W].

### Consequence

Dataset loaders and augmentations must preserve the temporal dimension.
```

This illustrates the reasoning a later contributor needs, rather than just recording the chosen shape. Use the project's existing decision-record format when one exists.

## Turn a repeated procedure into a skill

If several sessions repeat the same scheduler investigation, that procedure may be worth capturing as a skill. Follow the [skill standards](../../CONTRIBUTING.md#skill-standards) and use the [example skill](../../projects/template-project/skills/example-skill/) as a starting point.

A hypothetical scheduler skill could begin:

```markdown
---
name: diagnose-slurm-gpu-jobs
description: Diagnose failed or stalled Slurm GPU jobs when a contributor needs to inspect scheduler state, job logs, and resource requests.
---

# Diagnose Slurm GPU jobs

## Procedure

1. Identify the job and the failure or stall being investigated.
2. Inspect scheduler state and the job's requested resources.
3. Compare the job logs with the last successful run.
4. Record the observed failure and recommend the next diagnostic step.

## References

Link to the project's scheduler guidance and known failure cases.
```

This captures an action an agent can repeat. The underlying scientific context can remain in a knowledge entry, linked from the skill. A reusable reviewer role would instead start from the [agent template](../../projects/template-project/agents/example-agent/) and compose the skills and references it needs; see [prompts and agent roles](../../CONTRIBUTING.md#prompts-and-agent-roles).

## Prepare a handoff and resume from it

At the end of a substantial session, this prompt can help extract useful context:

```text
Prepare a handoff using this project's existing tracking process.

Capture the objective, completed work, files changed, checks run and their
results, decisions and their reasoning, failed approaches, unresolved
questions, and the exact next recommended step.

Link to existing records rather than repeating them. Identify observations,
hypotheses, and recommendations separately.
```

Review the result against the [documentation standards](../../CONTRIBUTING.md#documentation-standards) and [information-handling policy](../../CONTRIBUTING.md#information-handling). For the distributed-training example, the handoff should preserve the failed attempts and the next diagnostic, rather than imply that the hang has been fixed.

The next session could start with:

```text
Read the root and project AGENTS.md files, then the project entry point,
metadata, relevant knowledge, and existing handoff or issue records.

Inspect git status, recent history, and the existing diff. Summarize the
current objective, unresolved question, and next action before continuing.
```

Only name status files that actually exist. This makes the example usable for teams that choose a file-based handoff and teams that use an issue tracker.

## Submit the contribution

For a new example project, a Git workflow might be:

```bash
git switch -c docs/add-example-project-context
# Add and review the project files.
git diff
git add projects/example-project
git diff --cached
git commit -m "Add example project context"
git push -u origin docs/add-example-project-context
```

Open a pull request describing who uses the contribution, why the context is useful, and how it was verified. Apply the canonical [pull request checklist](../../CONTRIBUTING.md#pull-request-checklist) instead of maintaining a second checklist here.
