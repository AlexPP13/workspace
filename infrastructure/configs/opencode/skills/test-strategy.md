---
name: test-strategy
description: Plan or implement risk-based coverage with deterministic fixtures and focused unit, integration and end-to-end checks.
---

## Workflow
For domain-specific acceptance criteria, load only relevant shared methods on demand: `interface-design`, `frontend-systems`, `backend-systems` or `data-systems`. Keep the consuming assignment's mode and permissions; shared methods and developer self-checks do not replace independent review.

1. Map requirements and changed contracts to observable behavior and failure impact. Inspect test framework/version, fixtures, CI commands and current coverage before adding a new testing layer.
2. Select the lowest layer that proves each behavior. Use focused unit tests for logic, integration tests for boundaries and a small number of end-to-end tests for critical user journeys.
3. Cover normal, invalid, unauthorized, boundary and recovery paths according to risk. Add concurrency/idempotency cases only where the behavior requires them.
4. Keep tests deterministic: control time/randomness, isolate data and external calls, wait for observable conditions rather than sleeps, and clean up only owned disposable resources.
5. In implementation mode, run targeted tests, then relevant wider checks. Separate assertion failures from environment/setup failures and existing failures; do not claim baseline failures without comparison evidence.

## Acceptance report
Return requirement-to-test coverage, proposed/changed files, exact commands actually run, pass/fail counts if available, skips and remaining gaps. Never weaken assertions to make a suite green or silently update snapshots without inspecting behavior. Review/planning is read-only: test execution that writes caches/artifacts or changes services is not allowed in that mode. Implementation checks require a bounded permitted target and disposable fixtures, not live mutations. Preserve user edits; return fixes outside the assignment and access prerequisites to auto; no worker chaining.
