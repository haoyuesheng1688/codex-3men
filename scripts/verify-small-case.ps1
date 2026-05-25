$ErrorActionPreference = "Stop"

. (Join-Path $PSScriptRoot "enter-project-context.ps1")

$resultJson = & (Join-Path $PSScriptRoot "run-learning-cycle.ps1") -Stage "stage-0001-small-case"
$result = $resultJson | ConvertFrom-Json

$required = @(
  "knowledge\llmwiki\tia-openness\v21-baseline.md",
  "knowledge\llmwiki\scl\industrial-rules-baseline.md",
  "knowledge\llmwiki\wincc-classic-vbs\hmiruntime-baseline.md",
  "knowledge\llmwiki\wincc-unified-js\tagset-baseline.md",
  "knowledge\gitnexus\scl\fb_motor_control_case_of.scl",
  "knowledge\gitnexus\wincc-classic-vbs\read_write_tag_safe.vbs",
  "knowledge\gitnexus\wincc-unified-js\tagset_read_write.js",
  "knowledge\graphify\graph.jsonl",
  "reports\notion\stage-0001-small-case.md"
)

$missing = @()
foreach ($relative in $required) {
  $path = Join-Path $env:CODEX_3MEN_ROOT $relative
  if (-not (Test-Path -LiteralPath $path)) {
    $missing += $relative
  }
}

if ($missing.Count -gt 0) {
  throw "Small case verification failed. Missing: $($missing -join ', ')"
}

$graphPath = Join-Path $env:CODEX_3MEN_ROOT "knowledge\graphify\graph.jsonl"
$graphLines = (Get-Content -LiteralPath $graphPath).Count
if ($graphLines -lt 5) {
  throw "Graphify verification failed. Expected at least 5 JSONL lines, got $graphLines."
}

Write-Host "Small case verification passed."
Write-Host "Report: $($result.report)"
Write-Host "Wiki files: $($result.wikiFiles)"
Write-Host "GitNexus assets: $($result.gitnexusAssets)"
Write-Host "Graphify triples added: $($result.graphTriplesAdded)"
