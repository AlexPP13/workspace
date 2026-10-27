---
name: security-analysis
description: Evaluate trust boundaries and attack paths with evidenced exploitability and safe remediation guidance.
---

## Workflow
For domain-specific trust boundaries and invariants, load only relevant shared methods on demand: `interface-design`, `frontend-systems`, `backend-systems` or `data-systems`. This evidence-analysis method grants no tools or remediation authority; developer self-checks do not replace independent review in a separate reviewer session.

1. Establish scope, assets, attacker capabilities, entry points and trust boundaries. Inspect actual authentication, authorization, tenant isolation and secret-handling paths.
2. Trace untrusted inputs to sensitive sinks: queries, shell/process execution, templates, file paths, outbound requests and deserialization. Evaluate validation/encoding in the context where data is used.
3. Review privilege defaults, session/token lifecycle, dependency/config exposure and sensitive logging. Check resource authorization and abuse limits, not just presence of middleware.
4. For each suspected issue, trace an achievable scenario with prerequisites and existing mitigations. Distinguish confirmed findings from hypotheses and defense-in-depth suggestions.
5. Recommend the narrowest fix plus a non-destructive regression check. Explain residual risk and what evidence would confirm or dismiss an uncertain issue.

## Report and safety
Order findings by impact and exploitability. Include severity, confidence, file/line, attack prerequisites, affected asset and remediation. Never reproduce secrets in output. Security analysis uses read-only evidence across tools: no active exploitation, credential guessing, external probes, package installation, test artifacts or state changes. Follow the consuming role/mode; remediation is separate work requiring a permitted implementation assignment, not authority granted by this method. Return fixes/blocked evidence gathering to auto; no worker chaining. State scope limitations rather than claiming a clean bill of health.
