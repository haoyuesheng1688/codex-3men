# Codex-3men Autonomous Learning System

This project is a portable, isolated learning stack for long-running Codex study of Siemens industrial automation topics.

## Scope

Primary topics:

- Latest TIA Portal CPUs, firmware-dependent behavior, SCL syntax, and official programming recommendations.
- No-screenshot TIA automation through Openness, VCI, SIMATIC SD, command-line tools, and structured file import/export.
- S7-200 SMART V3 versus V2 differences, especially FB block usage and syntax/instruction migration.
- TIA Portal Openness V21 and CLI automation.
- SCL industrial code patterns for S7-1200/S7-1500.
- WinCC Classic VBS for V7/V8 runtime scripting.
- WinCC Unified JavaScript and WebUX scripting.
- CLI-driven engineering workflows and prompt engineering.

## Memory Stores

- `knowledge/llmwiki/`: Markdown knowledge base for concepts and field notes.
- `knowledge/gitnexus/`: versioned source-code assets: `.scl`, `.vbs`, `.js`, `.ps1`, `.cs`.
- `knowledge/graphify/graph.jsonl`: entity-relation triples for knowledge graph reasoning.
- `reports/notion/`: Notion-ready stage reports.

## Project-Local Runtime

Run this first in a PowerShell terminal:

```powershell
. .\scripts\enter-project-context.ps1
.\scripts\setup-venv.ps1
.\scripts\verify-small-case.ps1
```

For a normal learning pass:

```powershell
. .\scripts\enter-project-context.ps1
.\scripts\run-learning-cycle.ps1
```

## Hybrid Cloud Local Mode

The GitHub repository can continue unattended learning while this computer is off. See [docs/hybrid-cloud-local-runbook.md](docs/hybrid-cloud-local-runbook.md).

Cloud mode runs through `.github/workflows/daily-learning.yml`. It runs daily at 01:30 China time.

Each cloud run is a deep pass: target duration 180 minutes, 2 to 3 primary keyword topics, 5 to 8 official/vendor sources, 3 to 6 community or video leads, 2 to 3 code assets when useful, 10 to 20 graph relationships, and 1 detailed Notion-ready report. Findings that require real TIA Portal, WinCC, or Openness proof are marked for local validation.

Local real-software validation is manual. When the user says `请同步验证`, run:

```powershell
. .\scripts\enter-project-context.ps1
.\scripts\sync-verify-local.ps1
```

## Isolation Contract

The project owns its own runtime homes:

- `.project-codex-home`
- `.project-llmwiki-home`
- `.project-gitnexus-home`
- `.project-graphify-home`
- `.venv`

Do not rely on global Codex, LLM Wiki, GitNexus, Graphify, or Notion state unless the source and purpose are explicit.
