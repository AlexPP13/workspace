---
name: data-systems
description: Evaluate data integrity, access paths and safe schema evolution.
---

## When to use
Load on demand for persistence design, query/index decisions, schema compatibility or migration/recovery analysis. This method grants no authority to execute queries, migrations or data changes.

## Inputs/prerequisites
Confirm database engine/version, ORM/migration tooling, schema ownership and rollout order. Inspect actual constraints, query/access patterns and available cardinality evidence; never assume production volume.

## Decision rules/procedure
1. Define integrity and access-pattern requirements. Prefer database-enforced constraints where appropriate; assess tenant isolation, nullability, time representation and retention.
2. Inspect parameterization, joins, selectivity, ordering and indexes. Compare available plans on representative data, balancing read benefits against index write and storage costs.
3. Plan expand/backfill/contract stages for mixed application versions. Address compatibility, lock duration, bounded batches, resumability, duplicate work and partial completion.
4. Define stage ordering, data validation and failure recovery. A down migration is not a safe rollback if it loses data; specify forward recovery and backup prerequisites instead.

## Pitfalls
`EXPLAIN ANALYZE` executes statements: it is not harmless read-only inspection. Migration authoring is not authorization to apply it. Do not infer safe locks or runtime from small fixtures, contract a schema before old consumers retire, or call a data-losing reversal a recovery plan.

## Verification
Use existing schemas, plans and migration evidence in read-only assignments: no migrations, temporary tables, write-producing commands or artifact-producing tests. Distinguish analysis, schema/query implementation and migration authoring from applying changes. Execution requires a permitted implementation assignment and approved disposable fixtures; migration application or modifying real/persistent data needs separate explicit authorization. Check constraints, compatibility, stage restart/recovery behavior and data validation; report scripts, actual checks/plans, untested scale and locking assumptions and precise execution prerequisites. Preserve existing edits; loading this method does not authorize worker delegation or production mutations.

## Output
Return integrity/access-path decisions, compatibility stages, recovery prerequisites and actual evidence or proposed checks for the current task. This does not assume a database-worker role or replace independent review.
