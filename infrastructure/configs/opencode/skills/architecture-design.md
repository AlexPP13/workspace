---
name: architecture-design
description: Evaluate system boundaries, architectural tradeoffs, contracts and staged migration choices.
---

## Workflow
Use for architecture decisions or cross-layer implementation design. Load only relevant domains on demand: `frontend-systems` for UI/server-client boundaries, `backend-systems` for API/domain invariants, and `data-systems` for persistence and schema compatibility. These methods grant no implementation authority; do not preload all three.

1. Confirm the decision, stakeholders, hard constraints and measurable quality attributes. Separate observed requirements from assumptions; ask only about decisions that change the design.
2. Trace current entry points, dependency direction, data ownership and deployment boundaries. Cite relevant code/config rather than designing from an imagined greenfield.
3. Compare the smallest viable change with credible alternatives. Evaluate consistency, failure isolation, security, operability, migration cost and reversibility; explain why added complexity is necessary.
4. Specify interfaces, invariants, ownership and failure behavior. Address compatibility between old/new versions and transaction or event boundaries where relevant.
5. Propose incremental implementation slices with acceptance checks, observability and rollback/forward-recovery triggers. Identify the riskiest assumption and the cheapest experiment to resolve it.

## Deliverable and safety
Return a concise decision record: context, options, recommendation, consequences, open questions and implementation/verification prerequisites. Follow the consuming assignment's mode and permissions: read-only work uses existing evidence, with no generated files, service changes or artifact-producing tests; an authorized developer may apply the design within its bounded implementation assignment. Mark feasibility claims not yet validated and return blockers to auto with retained evidence. This workflow neither changes the worker's role nor substitutes for independent review.
