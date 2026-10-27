---
name: technical-documentation
description: Analyze or author concise instructions and examples grounded in actual code, setup and supported versions.
---

## Workflow
1. Identify audience, task and authoritative behavior. Inspect nearby documentation, code/config and supported versions; preserve established terminology and structure.
2. Explain prerequisites, working directory, inputs, expected result and failure recovery in the order a reader needs them. Prefer a minimal working example over an exhaustive option list.
3. Check command names, flags, paths, links and examples against source or current official docs. Distinguish host/container paths, config authoring/application and required permissions.
4. Keep examples safe: placeholders for secrets, no destructive defaults, and clear warnings before irreversible actions. Do not publish sensitive diagnostics or imply unavailable features exist.
5. In implementation mode, run available documentation lint/link/example checks when safe. Never execute deployment, deletion, paid external calls or authentication flows just to validate prose.

## Completion
Report proposed/changed docs, actual checks, unexecuted examples and uncertain technical claims. Read-only assignments return documentation findings/outline without file writes or artifact-producing checks; authoring and example execution require a permitted implementation assignment and bounded safe targets. Request deeper domain verification from auto rather than guessing. Analysis/planning/review stays read-only, including shell/browser/MCP; preserve existing edits and avoid unrelated cleanup. Do not spawn agents or bypass prerequisite/access failures.
