# Keywords: TIA_CLI_NO_SCREENSHOT, TIA_IO_AUTOMATION
# Purpose: no-screenshot automation skeleton. Local paths must be verified on the engineering workstation.

param(
  [Parameter(Mandatory = $true)]
  [string]$TiaInstallBin,

  [Parameter(Mandatory = $true)]
  [string]$ProjectPath,

  [Parameter(Mandatory = $true)]
  [string]$OutputDir
)

$ErrorActionPreference = "Stop"

$publicationTool = Join-Path $TiaInstallBin "Siemens.Automation.Cax.PublicationTool.Mdd.Console.exe"
if (-not (Test-Path -LiteralPath $publicationTool)) {
  throw "Hardware Publication Tool console executable not found: $publicationTool"
}

if (-not (Test-Path -LiteralPath $OutputDir)) {
  New-Item -ItemType Directory -Path $OutputDir | Out-Null
}

# Exact parameters are version- and installation-dependent.
# Keep this as a local-validation target before production use.
& $publicationTool /help | Tee-Object -FilePath (Join-Path $OutputDir "hardware-publication-tool-help.log")
