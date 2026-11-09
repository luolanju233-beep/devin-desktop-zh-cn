# Devin Desktop Chinese Language Pack Uninstaller (Windows)
# Removes the language pack extension and restores the display language to English.
#Requires -Version 5.1
$ErrorActionPreference = 'Continue'

$ExtId = 'MS-CEINTL.vscode-language-pack-zh-hans'
$Argv  = Join-Path $env:USERPROFILE '.devin\argv.json'

$Cli = Join-Path $env:LOCALAPPDATA 'Programs\Devin\bin\devin-desktop.cmd'
if (-not (Test-Path $Cli)) {
  $cmd = Get-Command devin-desktop -ErrorAction SilentlyContinue
  if ($cmd) { $Cli = $cmd.Source }
}

if (Test-Path $Cli) {
  Write-Host '==> Uninstalling Chinese language pack extension...'
  & $Cli --uninstall-extension $ExtId
} else {
  Write-Host 'WARNING: Devin Desktop CLI not found; skipping extension removal.'
}

if (Test-Path $Argv) {
  Write-Host '==> Restoring display language to English...'
  $raw = [System.IO.File]::ReadAllText($Argv)
  $raw = [regex]::Replace($raw, '"locale"\s*:\s*"[^"]*"', '"locale": "en"')
  [System.IO.File]::WriteAllText($Argv, $raw)
}

Write-Host '==> Done. Please fully quit and reopen Devin Desktop.'
