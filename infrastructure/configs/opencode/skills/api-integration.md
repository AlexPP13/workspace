---
name: api-integration
description: Analyze or implement external API/event contracts with bounded retries, idempotency and safe verification.
---

## Workflow
When an adapter changes API/domain contracts, authorization or transactional behavior, load `backend-systems` on demand; keep the integration-specific procedure below for external protocol concerns.

1. Identify producer/consumer ownership and the supported protocol/version. Read authoritative API/event docs and existing adapters; record authentication, pagination, quotas and compatibility requirements.
2. Map external payloads to internal types at one boundary. Validate unknown/missing fields and error shapes without coupling domain logic to vendor transport details.
3. Set explicit connection/request deadlines. Retry only transient, safe/idempotent operations with bounded backoff/jitter and a total budget; handle rate limits and cancellation.
4. For webhooks/events, verify signatures against raw payloads, timestamps and replay rules. Define delivery semantics, deduplication scope, ordering and dead-letter/recovery behavior.
5. Test representative contracts with fixtures/mocks: pagination, malformed payloads, timeout, rate limiting, duplicate delivery and partial failure. Use a sandbox only when authorized; live calls may create side effects or costs.

## Completion
Report proposed/changed contracts, credential/config prerequisites, actual tests and what remains unverified against the provider. Never put secrets in code, fixtures or logs. Analysis/planning/review remains read-only, including shell/browser/MCP and external APIs: inspect existing contracts/results rather than executing side-effecting calls or artifact-producing tests. Implementation/testing requires a permitted assignment and bounded safe target; credential changes and live mutations need separate explicit authorization. Preserve user changes; return provider/access blockers and bounded followup proposals to auto, never chain workers.
