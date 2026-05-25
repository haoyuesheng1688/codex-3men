$ErrorActionPreference = "Stop"

. (Join-Path $PSScriptRoot "enter-project-context.ps1")

$venvPath = Join-Path $env:CODEX_3MEN_ROOT ".venv"
$python = Get-Command python -ErrorAction Stop

if (-not (Test-Path -LiteralPath $venvPath)) {
  & $python.Source -m venv $venvPath
}

$venvPython = Join-Path $venvPath "Scripts\python.exe"
& $venvPython -m pip install --upgrade pip | Out-Host

$requirements = Join-Path $env:CODEX_3MEN_ROOT "requirements.txt"
if (Test-Path -LiteralPath $requirements) {
  & $venvPython -m pip install -r $requirements | Out-Host
}

& $venvPython --version
Write-Host "Virtual environment ready: $venvPath"
