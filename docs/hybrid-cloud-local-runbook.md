# Hybrid Cloud Local Runbook

## Operating Model

Codex-3men uses a hybrid model:

- GitHub cloud runner performs unattended daily learning while the local computer is off.
- The local Windows workstation performs real TIA Portal, WinCC, and Openness validation only when manually requested.

Cloud learning can search, digest, update local knowledge files, update code assets, update Graphify relationships, and prepare or publish Notion reports. It must not pretend to operate local licensed software.

Local validation is triggered by the user saying:

```text
请同步验证
```

## Cloud Responsibilities

GitHub Actions workflow:

```text
.github/workflows/daily-learning.yml
```

It runs daily at 01:30 China time because the cron value is `30 17 * * *` UTC.

## Learning Depth Per Run

Each unattended cloud run is a deep learning pass.

Default depth:

- Target duration: 180 minutes.
- Workflow timeout: 210 minutes, leaving margin for setup, Notion publish, and Git commit.
- Focus on 2 to 3 primary topics per run, selected from `config/keywords.json`.
- Check 5 to 8 official or vendor sources first.
- Review 3 to 6 community, YouTube, Bilibili, academic, or forum leads.
- Produce or update 2 to 3 code assets where useful: `.scl`, `.vbs`, `.js`, `.ps1`, or `.cs`.
- Add 10 to 20 Graphify relationships.
- Update relevant LLM Wiki pages with finer sub-sections, source URLs, application boundaries, and unresolved questions.
- Generate 1 detailed Notion-ready report.

The machine-readable depth profile is:

```text
config/learning-depth.json
```

Escalation rule:

- If a finding affects real TIA Portal, WinCC Classic, WinCC Unified, Openness import/export, compile behavior, runtime tag behavior, or production safety, the cloud run must mark it as `needs-local-validation`.
- It is not considered verified until the user says `请同步验证` and the local workstation produces a validation report under `reports/local-validation/`.

Cloud outputs:

- `knowledge/llmwiki/`
- `knowledge/gitnexus/`
- `knowledge/graphify/graph.jsonl`
- `reports/notion/`

If GitHub repository secrets are configured, the workflow also publishes the report to Notion:

- `NOTION_TOKEN`
- `NOTION_PARENT_PAGE_ID`

Use the `news` page ID when reports should land under the existing Notion `news` page:

```text
349c8717-dee0-80b7-862b-c8d662f9a37a
```

## Local Responsibilities

Local validation must run only on the Windows machine that has access to the real software stack:

- TIA Portal / Openness.
- Classic WinCC / WinCC Runtime Professional.
- WinCC Unified where available.

Entry point:

```powershell
. .\scripts\enter-project-context.ps1
.\scripts\sync-verify-local.ps1
```

The local run must pull cloud knowledge first, inspect what changed, and then perform only the requested real-software verification.

## Safety Boundary

- Cloud can learn and prepare candidate code.
- Local can validate against licensed software.
- Cloud must not write facts such as "verified in TIA Portal" unless a local validation report exists.
- Local validation reports belong under `reports/local-validation/`.
