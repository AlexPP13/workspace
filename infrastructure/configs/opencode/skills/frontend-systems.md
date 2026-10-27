---
name: frontend-systems
description: Reason about UI boundaries, state ownership and async behavior.
---

## When to use
Load on demand when UI changes or architectural decisions depend on routing, rendering, component contracts or asynchronous client state. This method does not assign an implementation role or expand permissions.

## Inputs/prerequisites
Inspect framework/version, routes, rendering model, existing components, API adapters and test conventions. Identify what runs on the server versus client and which layer owns each input/output contract.

## Decision rules/procedure
1. Trace navigation, data loading and rendering through route and component boundaries. Keep server-only data and authorization decisions out of client-owned state.
2. Separate presentation state, server data and local interaction state. Derive values where possible instead of duplicating state or introducing unnecessary global stores.
3. Define component inputs, events and rendering expectations, including controlled/uncontrolled ownership and effect lifecycle. Reuse existing primitives and adapters.
4. Account for stale responses, cancellation, effect cleanup, unmounts and repeated actions. Make pending, retry and failure transitions explicit so old work cannot overwrite newer intent.

## Pitfalls
Client validation is not a security boundary. Avoid leaked server-only information, duplicated derived state, unbounded effects and races between navigation and in-flight work. For interaction/accessibility decisions, load `interface-design` only when relevant rather than duplicating its method here.

## Verification
Trace navigation/rendering contracts and async failure paths against existing evidence. In permitted implementation mode, use focused type/unit/interaction checks for state transitions, stale responses and cleanup. Read-only assignments must not run artifact-producing tests or mutate an app through shell/browser/MCP.

## Output
Return the boundary/state map, component contracts, async failure handling and checks or remaining risks appropriate to the assignment. This method neither changes role boundaries nor replaces independent review.
