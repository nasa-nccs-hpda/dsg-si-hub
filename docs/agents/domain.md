# Domain docs

## Layout and reading rules

Repository-wide domain documentation uses a single-context layout:
`GLOSSARY.md` and `docs/adr/` at the repository root.

Before exploring, read the glossary and ADRs relevant to the work.
If a root `GLOSSARY-MAP.md` exists later, follow its pointers instead.

Keep project-specific terms and decisions under `projects/<project>/`,
following that project's instructions. Read its relevant domain docs
when working there.

If domain docs do not exist, proceed silently. Do not create placeholders.
The domain-modeling skill creates them when terms or decisions are resolved.

## Vocabulary and decisions

Use the glossary's defined terms in issues, proposals, and code.
If a needed concept is missing, reconsider the wording or note the gap
for domain modeling.

Explicitly identify any conflict with an existing ADR and explain why
the decision may need reopening.

Preserve owners, sources, limitations, and review dates.
