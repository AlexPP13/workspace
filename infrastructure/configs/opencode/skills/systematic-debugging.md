---
name: systematic-debugging
description: Discriminate root-cause hypotheses and plan or verify minimal fixes with regression evidence.
---

## Workflow
For domain-specific hypotheses and invariants, load only relevant shared methods on demand: `interface-design`, `frontend-systems`, `backend-systems` or `data-systems`. Read-only diagnosis uses existing evidence; loading a method does not authorize reproduction side effects or implementation.

1. Capture expected versus actual behavior, exact input, environment/version and smallest known reproduction. Record intermittent frequency and what changed without assuming correlation proves cause.
2. Trace the failing path and inspect relevant errors, logs, diff/history and invariants. Redact secrets. Maintain a short list of hypotheses with evidence for/against each.
3. Choose discriminating observations before speculative edits. Narrow the boundary with read-only inspection in analysis mode; instrumentation, execution-based reproductions or artifact-producing tests require implementation authorization and a bounded safe target. Investigation does not authorize the fix.
4. Once the cause is evidenced, make the smallest coherent fix in implementation mode. Do not hide the symptom with swallowed errors, longer timeouts or weakened tests unless the contract justifies it.
5. In permitted implementation mode, add a regression case that demonstrates the original failure, then verify the fix and adjacent paths. In read-only work, propose the regression/check without running it. Report if a failing-before/passing-after comparison was not actually possible.

## Handoff
Return reproduction evidence, root-cause confidence, rejected hypotheses, proposed/changed files and exact checks/results. Preserve unrelated edits; never reset a working tree to investigate. Do not mutate live data, clear persistent state or restart services without separate explicit authorization. If blocked, give auto retained evidence and the next discriminating check, not a wholesale forwarded task; no worker chaining. Shared diagnosis/fix methods do not replace independent review.
