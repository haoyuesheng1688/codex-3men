$ErrorActionPreference = "Stop"

$ProjectRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path

$env:CODEX_3MEN_ROOT = $ProjectRoot
$env:CODEX_HOME = Join-Path $ProjectRoot ".project-codex-home"
$env:LLMWIKI_HOME = Join-Path $ProjectRoot ".project-llmwiki-home"
$env:GITNEXUS_HOME = Join-Path $ProjectRoot ".project-gitnexus-home"
$env:GRAPHIFY_HOME = Join-Path $ProjectRoot ".project-graphify-home"

$localHomes = @(
  $env:CODEX_HOME,
  $env:LLMWIKI_HOME,
  $env:GITNEXUS_HOME,
  $env:GRAPHIFY_HOME,
  (Join-Path $ProjectRoot "logs"),
  (Join-Path $ProjectRoot "tmp")
)

foreach ($path in $localHomes) {
  if (-not (Test-Path -LiteralPath $path)) {
    New-Item -ItemType Directory -Path $path | Out-Null
  }
}

Write-Host "Codex-3men project context loaded:"
Write-Host "  CODEX_3MEN_ROOT=$env:CODEX_3MEN_ROOT"
Write-Host "  CODEX_HOME=$env:CODEX_HOME"
Write-Host "  LLMWIKI_HOME=$env:LLMWIKI_HOME"
Write-Host "  GITNEXUS_HOME=$env:GITNEXUS_HOME"
Write-Host "  GRAPHIFY_HOME=$env:GRAPHIFY_HOME"
