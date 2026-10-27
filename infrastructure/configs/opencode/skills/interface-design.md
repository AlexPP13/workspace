---
name: interface-design
description: Evaluate user flows, interaction states and accessible layouts.
---

## When to use
Load on demand for interface specifications, UI implementation or evaluation of user-facing acceptance criteria. This is a shared method, not a designer role or permission grant; retain the consuming agent's assignment and restrictions.

## Inputs/prerequisites
Identify the user, primary task, success criterion and constraints. Inspect current screens, routes, component library and design tokens; distinguish product requirements from visual preferences. Use only available, permitted context sources.

## Decision rules/procedure
1. Map the shortest usable flow, including entry/exit points, navigation, cancellation and recovery.
2. Specify hierarchy, content, spacing/tokens and narrow/wide viewport behavior. Reuse existing components; explain necessary deviations.
3. Build an interaction-state matrix: loading, empty, error, success, disabled and partial data. For each relevant state, define the trigger, visible feedback, available actions, validation timing and preservation of user input.
4. Define semantic controls, accessible names, keyboard order, focus management and announcements. Specify contrast and reduced-motion criteria; do not rely on color or hover alone.

## Pitfalls
Do not treat a happy-path mockup as a complete interaction contract, invent product decisions to fill gaps, or assume a design source grants access to mutate it.

## Verification
Map each flow/state to observable acceptance criteria for narrow/wide layouts and keyboard use. Review existing evidence in read-only mode; browser interactions or tests that mutate state or produce artifacts require a permitted implementation assignment and safe target. Report untested accessibility/visual assumptions.

## Output
Provide the flow, token/component decisions, state matrix, testable accessibility/frontend acceptance criteria and unresolved product questions in the format needed by the current task. For a planning/design assignment, return a text-based screen/interaction specification and handoff prerequisites for developer, not design/source writes, form submissions, created records or state-changing browser scripts. Separate unresolved product choices from recommendations and report accessibility checks still needed. A permitted developer may implement the specification within its assignment; this method does not impose a designer role or replace independent review.
