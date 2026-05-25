param(
  [string]$Remote = "origin",
  [string]$Branch = "main"
)

$ErrorActionPreference = "Stop"

. (Join-Path $PSScriptRoot "enter-project-context.ps1")

$validationRoot = Join-Path $env:CODEX_3MEN_ROOT "reports\local-validation"
if (-not (Test-Path -LiteralPath $validationRoot)) {
  New-Item -ItemType Directory -Path $validationRoot | Out-Null
}

$before = git rev-parse HEAD
git fetch $Remote
git pull --ff-only $Remote $Branch
$after = git rev-parse HEAD

$changed = @()
if ($before -ne $after) {
  $changed = git diff --name-only $before $after
}

$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss K"
$reportPath = Join-Path $validationRoot ("sync-verify-{0}.md" -f (Get-Date -Format "yyyyMMdd-HHmmss"))

$body = @"
# Local Sync Verification

Time: $timestamp
Workspace: $env:CODEX_3MEN_ROOT
Before commit: $before
After commit: $after

## Cloud Changes Pulled

$(
if ($changed.Count -eq 0) {
  "- No new cloud changes."
} else {
  ($changed | ForEach-Object { "- $_" }) -join "`n"
}
)

## Real Software Validation Boundary

This file records synchronization only. TIA Portal, WinCC Classic, WinCC Unified, and Openness validation must be added below after the user specifies the target case and the corresponding software is open or accessible.

## Next Local Validation Targets

- TIA Openness export/import and compile log proof.
- SCL generated block import and compile proof.
- WinCC Classic VBS tag read/write runtime proof.
- WinCC Unified JavaScript TagSet runtime proof.
"@

Set-Content -LiteralPath $reportPath -Value $body -Encoding UTF8
Write-Host "Local sync verification report: $reportPath"
