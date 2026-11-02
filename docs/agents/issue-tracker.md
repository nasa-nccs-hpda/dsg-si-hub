# Issue tracker: GitHub

Issues and specs live in GitHub Issues for
`nasa-nccs-hpda/ilab-agentic-ai`. Use the `gh` CLI from this clone.

## Conventions

Before the first issue creation in a session, verify the target with
`gh repo view --json nameWithOwner`. It must resolve to
`nasa-nccs-hpda/ilab-agentic-ai`.

- Create: `gh issue create --title "..." --body-file <file>`.
  Use a file containing actual newlines for multiline bodies.
- Read: `gh issue view <number> --json number,title,body,labels,comments`.
- List: `gh issue list --state open --json number,title,body,labels`.
  Add label and state filters as needed.
- Update: `gh issue edit <number> --body-file <file>`.
- Comment: `gh issue comment <number> --body-file <file>`.
- Labels: `gh issue edit <number> --add-label "..."` or
  `--remove-label "..."`.
- Sub-issues: `gh issue create --parent <parent> ...` or
  `gh issue edit <parent> --add-sub-issue <child>`.
  If unavailable, add `Part of #<parent>` to the child and link it
  from a task list in the parent.
- Dependencies: `gh issue edit <child> --add-blocked-by <blocker>`.
  If unavailable, put `Blocked by: #<number>` at the top of the body.
  An issue is unblocked when every blocker is closed.
- Close: post an explanatory comment, then `gh issue close <number>`.
  Post comments separately even if the issue is already closed.

## Improvement issue progress

Use exactly one of these progress labels on each repository-improvement
issue, including the parent issue:

| Label | Meaning |
| --- | --- |
| `status: not started` | Implementation has not begun. |
| `status: in progress` | Implementation or validation is underway. |
| `status: locally complete` | Implementation and applicable checks are complete locally; the changes have not all been pushed. |
| `status: pushed awaiting pr` | Implementation is committed and pushed; PR creation, review, or merge remains pending. |
| `status: merged` | The implementation has merged into the PR's target branch, with linked merge evidence. |

Replace the previous `status:` label when progress changes; preserve other
labels. Update the issue's implementation notes with verification and
commit or PR links when applicable. Keep issues open until merged, then
post the completion evidence and close them. Mark the parent `in progress`
while child issues remain unfinished, and `merged` only after all children
are merged and its completion criteria are met.

For the ordered refactor, implement issues in the plan's sequence. Under
the user's workflow of opening one PR after all implementation tickets
are done, the next issue may start when its predecessor reaches
`status: pushed awaiting pr`; waiting for that predecessor to close is not
required. Create the PR after all implementation tickets reach that stage.

These labels track issue execution. Blockers retain the separate lifecycle
defined in the [blocker register](../blocker-register.md#lifecycle-and-maintenance).

## Pull requests as a triage surface

**PRs as a request surface: no.**

## Skill terminology

“Publish to the issue tracker” means create a GitHub issue.
“Fetch the relevant ticket” means read the GitHub issue.

Never publish this repository's work into the skills' upstream repository.
