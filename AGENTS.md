# Repository instructions for agents

## Purpose

Treat this repository as a shared agent platform and institutional knowledge base. Preserve the distinction between project-local material and reusable components.

## Before editing

- Read and enforce [CONTRIBUTING.md](CONTRIBUTING.md) for contribution placement, lifecycle, documentation, information handling, skill standards, and review checks. Use its policies rather than maintaining copies in agent instructions.
- Read the project instructions relevant to the files you will edit.
- Inspect `git status`, recent history, and the existing diff. Preserve work already present in the checkout.

## Editing rules

- Preserve owners, sources, limitations, and review dates.
- Do not invent project facts, model behavior, dataset characteristics, or validation results.
- Validate scripts and links in proportion to their risk.
- Report what changed, how it was verified, and any remaining limitations. Do not claim validation that was not performed.

## Agent skills

### Issue tracker

Issues and specs live in GitHub Issues for `nasa-nccs-hpda/ilab-agentic-ai`. See `docs/agents/issue-tracker.md`.

### Domain docs

Repository-wide domain docs use a single-context layout. See `docs/agents/domain.md`.

### Blocker tracking

- Read `docs/blocker-register.md` for blockers relevant to the work.
- For the initial repository refactor, leave project blockers open and follow the scope in `docs/repository-improvement-plan.md`. Continue structural cleanup that preserves scientific content; defer edits requiring scientific adjudication or evidence deletion to the authorized project owner.
- When blocker state, ownership, current resolution step, required evidence, or issue links materially change, update both its summary row and detailed record in the same change. Record the last-updated date and link supporting evidence.
- Keep stable blocker IDs. Use only `open`, `resolution-proposed`, and `resolved`; mark a blocker resolved only after its authorized owner accepts the evidence or withdraws the blocked claim, and record that acceptance.
- Do not treat issue completion or passing tests alone as owner acceptance. Leave unassigned scientific decisions with the project until an authorized owner is identified.
- Keep workstreams and sequencing in `docs/repository-improvement-plan.md`; keep blocker details and lifecycle in the register and execution discussion in the configured issue tracker.
