---
name: performance-analysis
description: Evaluate representative baselines, isolate bottlenecks and assess targeted changes without semantic regressions.
---

## Workflow
For domain-specific contracts and tradeoffs, load only relevant shared methods on demand: `interface-design`, `frontend-systems`, `backend-systems` or `data-systems`. Preserve the assignment's mode and measurement safety; loading a method does not authorize tests or profiling side effects.

1. Define the user-visible metric and budget: latency distribution, throughput, memory, startup, query cost or render responsiveness. Record workload, environment, data size and measurement method.
2. Inspect existing profiles/metrics before optimizing. In authorized implementation mode, collect a representative baseline on an approved local/disposable target; distinguish warm/cold cache and steady state.
3. Locate the dominant cost using appropriate evidence: CPU/allocation profiles, query plans, network waterfalls, render traces or contention metrics. Avoid broad rewrites based on intuition alone.
4. Propose a change to one coherent bottleneck while preserving contracts; implement only within a permitted implementation assignment. For caching/batching/concurrency, assess invalidation, memory bounds, ordering, backpressure and failure behavior.
5. Compare existing before/after evidence with the same workload and multiple samples where feasible. In permitted implementation mode on a bounded safe target, collect the comparison and run correctness checks. Report variance, warm/cold differences and tradeoffs rather than treating noise as an improvement.

## Safety and completion
Do not stress shared/live services or collect sensitive profiles without explicit approval. Execution-based profiling/benchmarking requires implementation authorization and a bounded safe target. Analysis/planning/review stays read-only across shell/browser/MCP: use existing profiles rather than starting load tests, recordings or artifact-producing benchmarks. Return baseline, methodology, measurements, proposed/changed files, actual checks and unverified scale assumptions. Preserve user edits and send capability/prerequisite blockers to auto with the next useful experiment; no worker delegation.
