# Codex-3men Project Instructions

## Boundary

This repository is an isolated Codex learning system workspace. Treat `D:\skills\codex\Codex-3men` as the only authoritative project root for this task.

Do not silently mix files, runtime state, knowledge bases, memory stores, scripts, credentials, or conclusions from other workspaces. Outside references may be used only as clearly identified source material.

## Mission

Build and operate an unattended industrial automation learning loop focused on:

- Siemens TIA Portal Openness and CLI automation.
- SCL for S7-1200/S7-1500, especially safe state-machine and optimized-access patterns.
- WinCC Classic VBS for V7/V8 runtime scripting, `HMIRuntime`, tag access, ADO, files, and OLE automation.
- WinCC Unified JavaScript / WebUX scripting, especially `HMIRuntime.Tags`, `Tags.CreateTagSet`, dynamic screen objects, and async-safe patterns.

## Workflow

Use a strict PDCA loop:

1. Search: gather official documentation first, then vetted forum, video, and community leads.
2. Extract and Digest: remove noise, isolate source facts, and attach source URLs.
3. Consolidate Memory: write to LLM Wiki, GitNexus code assets, and Graphify triples.
4. Report: generate a Notion-ready stage report with findings, code snapshots, graph updates, and prompt revisions.

## Keyword Model

Automation is keyword-driven. Before adding new logic, check `config/keywords.json`. If a required keyword is missing, add it there first and state which keyword was added.

## Safety

- Keep secrets in `.env.local` only.
- Keep generated state under `.project-codex-home`, `.project-llmwiki-home`, `.project-gitnexus-home`, and `.project-graphify-home`.
- Prefer small validation cases before long unattended runs.
- Do not perform destructive rewrites of existing code or generated knowledge.
