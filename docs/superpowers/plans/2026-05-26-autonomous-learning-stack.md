# Autonomous Learning Stack Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build a project-local, unattended learning loop for TIA Portal SCL, WinCC Classic VBS, WinCC Unified JavaScript, and CLI automation knowledge.

**Architecture:** The project uses a local PDCA loop: search source manifests, digest findings, consolidate them into LLM Wiki, GitNexus, and Graphify stores, then generate a Notion-ready report. All state stays under `D:\skills\codex\Codex-3men` through local home directories and local scripts.

**Tech Stack:** PowerShell 5.1+, Python 3.11 virtual environment, Git, local Markdown/JSONL stores, optional Notion connector/API integration.

---

### Task 1: Project Boundary

**Files:**
- Create: `AGENTS.md`
- Create: `README.md`
- Create: `PORTABLE_MANIFEST.json`
- Create: `.gitignore`

- [x] **Step 1: Declare isolation rules**

Create `AGENTS.md` that makes this workspace authoritative and forbids silent reuse of other project homes, knowledge bases, or credentials.

- [x] **Step 2: Document the operating model**

Create `README.md` with the PDCA loop, memory stores, keyword model, and first-stage commands.

- [x] **Step 3: Record portable paths**

Create `PORTABLE_MANIFEST.json` with the local homes and runtime entrypoints.

- [x] **Step 4: Ignore runtime artifacts**

Create `.gitignore` for `.venv`, local homes, logs, temporary files, and secrets.

### Task 2: Knowledge Store Skeleton

**Files:**
- Create: `config/learning-sources.json`
- Create: `config/keywords.json`
- Create: `knowledge/llmwiki/index.md`
- Create: `knowledge/gitnexus/README.md`
- Create: `knowledge/graphify/graph.jsonl`
- Create: `reports/notion/README.md`

- [x] **Step 1: Define source registry**

Use a JSON source registry with official Siemens documentation first, then forum and video sources as secondary leads.

- [x] **Step 2: Define keyword registry**

Use stable keyword IDs such as `TIA_OPN_V21`, `SCL_CASE_OF`, `WINCC_CLASSIC_VBS_HMIRUNTIME`, and `WINCC_UNIFIED_JS_TAGSET`.

- [x] **Step 3: Seed each memory store**

Create an initial LLM Wiki index, GitNexus source-code index, and Graphify JSONL graph file.

### Task 3: Runtime Scripts

**Files:**
- Create: `scripts/enter-project-context.ps1`
- Create: `scripts/setup-venv.ps1`
- Create: `scripts/run-learning-cycle.ps1`
- Create: `scripts/verify-small-case.ps1`

- [x] **Step 1: Enter local context**

Set `CODEX_HOME`, `LLMWIKI_HOME`, `GITNEXUS_HOME`, and `GRAPHIFY_HOME` to project-local directories.

- [x] **Step 2: Create virtual environment**

Create `.venv` with Python 3.11 and install only local tooling requirements when present.

- [x] **Step 3: Run a deterministic small case**

Write one wiki digest, one code asset, one graph triple, and one Notion-ready report from the seed source registry.

### Task 4: Verification

**Files:**
- Generate: `reports/notion/stage-0001-small-case.md`
- Generate: `knowledge/gitnexus/scl/fb_motor_control_case_of.scl`
- Generate: `knowledge/gitnexus/wincc-classic-vbs/read_write_tag_safe.vbs`
- Generate: `knowledge/gitnexus/wincc-unified-js/tagset_read_write.js`

- [x] **Step 1: Run `scripts/setup-venv.ps1`**

Expected result: `.venv` exists and Python reports version 3.11 or newer.

- [x] **Step 2: Run `scripts/verify-small-case.ps1`**

Expected result: the generated report confirms `llmwiki`, `gitnexus`, and `graphify` outputs.

- [x] **Step 3: Inspect generated files**

Expected result: all generated artifacts stay under `D:\skills\codex\Codex-3men`.
