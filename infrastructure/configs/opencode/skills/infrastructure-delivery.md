---
name: infrastructure-delivery
description: Trace infrastructure/config through packaging, runtime discovery, local validation and reversible release plans.
---

## Workflow
1. Inspect supported runtime/tool versions, configuration sources, manifests, build context, ignores and installation/linking conventions. Preserve staged/unstaged edits and secrets; read authoritative version-specific docs before introducing fields.
2. Trace each changed asset from source to image/package/config map, mount destination and runtime discovery. Ensure added files actually ship; distinguish source templates from generated/ignored output.
3. Check ownership/permissions, writable versus read-only paths, environment substitutions, service endpoints and secret references. Avoid embedding credentials or granting broader privileges to fix a missing prerequisite.
4. In implementation mode, use available parse/lint/render/build checks without applying to live infrastructure. Inspect rendered resources for matching keys, paths, selectors and startup prerequisites. Never imply a text check proves runtime behavior.
5. Describe rollout order, compatibility, health/readiness signals, persistent-data implications and a reversible recovery path. Separate config reload behavior from image/service restarts; do not restart services unnecessarily.

## Completion and safety
Use this method for infrastructure/config implementation or delivery analysis according to the assignment. Authoring is not authorization to deploy, delete resources, apply migrations or rotate credentials; these and live/persistent-data mutations require separate explicit authorization. Analysis/planning/review stays read-only, including shell/browser/MCP: inspect existing render/build evidence rather than running artifact-producing checks. Report proposed/changed files, exact checks, unapplied resources and missing tools/access. For OpenCode changes, load the available OpenCode guidance and use only V2 docs; do not infer new fields from legacy schemas. Return blockers with evidence and next action to auto; never spawn workers.
