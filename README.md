# Codex-3men Autonomous Learning System

This project is a portable, isolated learning stack for long-running Codex study of Siemens industrial automation topics.

## Scope

Primary topics:

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

## Isolation Contract

The project owns its own runtime homes:

- `.project-codex-home`
- `.project-llmwiki-home`
- `.project-gitnexus-home`
- `.project-graphify-home`
- `.venv`

Do not rely on global Codex, LLM Wiki, GitNexus, Graphify, or Notion state unless the source and purpose are explicit.
