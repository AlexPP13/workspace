---
name: backend-systems
description: Reason about API contracts, authorization and transactional safety.
---

## When to use
Load on demand for API/domain implementation, integration boundary decisions or architectural analysis of server behavior. This is shared knowledge, not authorization to implement, execute or change data.

## Inputs/prerequisites
Trace request/job entry points through domain logic, persistence and outbound calls. Inspect existing contracts, validation, error handling, logging and test conventions; identify compatibility requirements and domain invariants.

## Decision rules/procedure
1. Define input/output contracts and validate at trust boundaries. Enforce authorization for the actual resource/tenant, not just authentication.
2. Keep responsibilities in existing API/domain/adapter layers. Make transaction scope, concurrency assumptions and side effects explicit; use existing idempotency mechanisms for repeated operations.
3. Bound payloads, timeouts and work. Return stable failures without secrets and retain actionable structured logs without leaking sensitive data.
4. Identify rollback, duplicate/concurrent execution and dependency-failure cases where invariants depend on them. For persistence-specific integrity or schema evolution, load `data-systems` only when needed.

## Pitfalls
Do not equate authentication with resource authorization, hide dependency failures, move external side effects inside transactions without considering recovery, or retry non-idempotent work blindly.

## Verification
Check success, invalid-input, unauthorized, missing-resource and dependency-failure behavior; examine transaction rollback and duplicates/concurrency as relevant. In read-only work, inspect existing tests/evidence only. Running tests that create artifacts or mutate fixtures requires permitted implementation mode and approved disposable data, never production mutations.

## Output
Provide contracts, authorization/invariant decisions, failure behavior and evidence or acceptance checks appropriate to the task. These methods do not replace independent security or correctness review.
