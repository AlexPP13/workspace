---
name: correctness-review
description: Inspect changes for actionable correctness defects, regressions and missing acceptance coverage.
---

## Workflow
For domain-specific acceptance criteria and invariants, load only relevant shared methods on demand: `interface-design`, `frontend-systems`, `backend-systems` or `data-systems`. This is a critique method, not a role assignment or remediation permission. Developer self-checks are not independent review; independence requires a separate reviewer session.

1. Confirm intended behavior, scope and acceptance criteria. Inspect staged and unstaged diffs plus surrounding code; distinguish the requested patch from existing user changes.
2. Trace changed entry points, callers, data flow and contracts. Check error paths, authorization, edge cases, concurrency, resource lifecycle and backward compatibility as applicable.
3. Compare supplied test evidence with risk. Inspect assertions for what they actually prove; identify missing regression cases without pretending to have run them.
4. Validate suspected bugs against reachable inputs and existing guards. Prefer a concrete failing scenario to speculative style advice; cite the narrowest useful file/line range.
5. Prioritize material findings, state severity and confidence, and recommend a focused fix/check. Keep optional maintainability suggestions separate from acceptance blockers.

## Review report and safety
Return findings first, then open questions, scope and unverified checks. If none are found, say so with coverage limits, not a guarantee of correctness. Review uses read-only evidence across shell/browser/MCP: no edits, formatters, installs or tests that create caches/artifacts or alter services. Follow the consuming worker's permissions; request inaccessible diffs/results through auto rather than bypassing denial. Remediation is separate work requiring a permitted implementation assignment; using this method during developer self-checks does not turn them into independent review. Preserve user work; no worker chaining or repeated retries of blocked evidence gathering.
