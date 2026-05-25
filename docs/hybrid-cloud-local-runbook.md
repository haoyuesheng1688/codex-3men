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

It runs daily at 08:30 China time because the cron value is `30 0 * * *` UTC.

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
