# Contributing

Contributions can be as small as a corrected link or as substantial as a tested agent skill. This document owns contribution placement, lifecycle, standards, and review checks. For worked examples, use the [contribution tutorial](docs/Tutorial-Adding-Information-to-the-Repo.md); agents must also follow [AGENTS.md](AGENTS.md).

## Choose the contribution type

| You want to add | Start here |
| --- | --- |
| Context or information useful to one project | `projects/<project>/`, usually its `knowledge/` area |
| A project-specific implementation or notebook | `projects/<project>/examples/` |
| A dataset, sensor, mission, model, or algorithm used by several projects | `knowledge/` |
| A repeatable procedure an agent should follow | `skills/` or `projects/<project>/skills/` |
| A reusable agent role or configuration | `agents/` or `projects/<project>/agents/` |
| Instructions for an external platform or service | `integrations/` |
| A prompt used only by one project | `projects/<project>/prompts/` |
| A test case or expected outcome | `evals/` or `projects/<project>/evals/` |

If you are uncertain, put the contribution under the project that needs it. Promote material into shared areas only when another project needs it; do not generalize speculative or project-specific practices into shared guidance. Lightweight documentation and references to a project's working repository are valid contributions; a complete experiment archive or runnable pipeline is not required.

## Basic workflow

1. Search the repository for an existing entry before creating one.
2. Copy the closest [template](templates/). A new project starts with `README.md`, `AGENTS.md`, and `project.yaml` from [the project template](templates/project/).
3. Use lowercase, hyphen-separated names for new directories. Preserve documented [legacy paths](docs/repository-improvement-plan.md#on-demand-structure).
4. Fill in ownership, status, sources, and review information. Create subdirectories only when the contribution needs them, and remove `.gitkeep` when adding real content to a directory.
5. Add links from the nearest `README.md` when appropriate; list new projects in the [project index](projects/README.md).
6. Check that examples contain no secrets or restricted data.
7. Open a pull request explaining who uses the contribution and how it was verified.

## Contribution lifecycle

New knowledge usually begins close to the people using it:

```text
projects/imvi/knowledge/datasets/example.md
    -> knowledge/datasets/example.md
    -> skills/earth-observation/process-example-data/
    -> evals/skills/process-example-data/
```

A second project's need justifies promotion to a shared area. Within either scope, a stabilized procedure or repeated source of mistakes can justify a skill, and evaluations can check its behavior. These are possible steps, not a required progression for every contribution.

Reference shared resources from the project's `project.yaml` rather than duplicating their content in the project directory.

Project session-status and handoff files are optional. Use a project's existing tracking process when it serves the need; create files such as `status/current.md` or `status/decisions.md` only when the project chooses that pattern. Repository execution issues live in the [configured issue tracker](docs/agents/issue-tracker.md).

## Documentation standards

- Write for someone who is familiar with the field but new to the project.
- Explain acronyms on first use.
- Separate observed facts, decisions, recommendations, assumptions, and open questions. Agent-generated text must not silently become project fact.
- Extract durable context, decisions, and findings from agent sessions rather than committing entire chat transcripts.
- Link to authoritative sources when possible.
- Record limitations, access restrictions, and known failure modes.
- Preserve existing ownership, sources, limitations, and review dates when editing material. Record dataset provenance and relevant units, spatial and temporal resolution, and coordinate systems for scientific entries.
- Describe failed approaches with what was tried, the observed outcome, and what would justify revisiting them.
- Use examples with synthetic, public, or explicitly approved data.
- Prefer one focused page over one very large reference document.

## Information handling

Never commit credentials, tokens, passwords, private keys, authentication cookies, proprietary information, export-controlled information, restricted datasets, or secrets copied from environment files or agent sessions. Personal information and production endpoints require explicit authorization. Use synthetic, public, or explicitly approved examples and placeholders for secrets.

## Prompts and agent roles

Keep prompts that encode useful, tested behavior and are worth reusing. One-off requests do not need their own files. Project-specific prompts and roles stay with the project; shared agent roles compose reusable knowledge, skills, integrations, and constraints. Use the [agent template](templates/agent/) for a new role.

## Skill standards

Every actual skill is a self-contained directory whose name matches the skill name:

```text
skills/<category>/<skill-name>/
├── SKILL.md
├── agents/
│   └── openai.yaml  # recommended
├── scripts/       # only when needed
├── references/    # only when needed
└── assets/        # only when needed
```

Skill names must use lowercase letters, digits, and hyphens. Prefer verb-led names such as `analyze-hyperspectral-imagery` or `submit-slurm-jobs`; the skill should describe a focused action rather than a broad topic such as `python` or `hpc`.

`SKILL.md` frontmatter must contain only `name` and `description`. Put both what the skill does and when it should trigger in the description. Keep detailed domain material in `references/`, and include resource directories only when the skill actually needs them.

Start with the [skill template](templates/skill/example-skill/), and use the applicable skill tooling to initialize and validate actual skills.

Scripts included in a skill must be run against a representative input before review. Include evaluation cases for fragile, safety-sensitive, or complex behavior.

## Pull request checklist

- [ ] The contribution is in the narrowest sensible location.
- [ ] New directory and skill names are lowercase and hyphen-separated.
- [ ] Owners and sources are identified where applicable.
- [ ] Links and commands have been checked.
- [ ] Examples do not contain credentials or restricted information.
- [ ] Scripts or procedures were tested, or the PR explains why they were not.
- [ ] Shared content does not unnecessarily duplicate project content.
- [ ] Any agent-generated context has been reviewed for accuracy.
