# Repository instructions for agents

## Purpose

Treat this repository as a shared agent platform and institutional knowledge base. Preserve the distinction between project-local material and reusable components.

## Placement rules

- Put new, project-specific information in `projects/<project>/`.
- Put information reused by multiple projects in `knowledge/`.
- Put repeatable agent procedures in `skills/`.
- Put reusable role configurations in `agents/`.
- Put external service and platform instructions in `integrations/`.
- Put behavioral verification in `evals/`.

When placement is unclear, prefer the relevant project directory. Do not generalize speculative or project-specific practices into shared guidance.

## Editing rules

- Preserve owners, sources, limitations, and review dates.
- Do not invent project facts, model behavior, dataset characteristics, or validation results.
- Never add secrets, credentials, restricted data, or production endpoints without explicit authorization.
- Use lowercase, hyphen-separated directory names.
- Keep skills small, task-oriented, and self-contained.
- Validate scripts and links in proportion to their risk.
- Remove `.gitkeep` when a directory gains real content.

## Agent skills

### Issue tracker

Issues and specs live in GitHub Issues for `nasa-nccs-hpda/ilab-agentic-ai`. See `docs/agents/issue-tracker.md`.

### Domain docs

Repository-wide domain docs use a single-context layout. See `docs/agents/domain.md`.

### Blocker tracking

- Read `docs/blocker-register.md` for blockers relevant to the work.
- When blocker state, ownership, current resolution step, required evidence, or issue links materially change, update both its summary row and detailed record in the same change. Record the last-updated date and link supporting evidence.
- Keep stable blocker IDs. Use only `open`, `resolution-proposed`, and `resolved`; mark a blocker resolved only after its authorized owner accepts the evidence or withdraws the blocked claim, and record that acceptance.
- Do not treat issue completion or passing tests alone as owner acceptance. Leave unassigned scientific decisions with the project until an authorized owner is identified.
- Keep workstreams and sequencing in `docs/repository-improvement-plan.md`; keep blocker details and lifecycle in the register and execution discussion in the configured issue tracker.
