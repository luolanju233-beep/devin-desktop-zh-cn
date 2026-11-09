# Devin Desktop Chinese Language Pack Installer (Windows)
# Installs the official Chinese (Simplified) language pack and sets locale to zh-cn.
#Requires -Version 5.1
$ErrorActionPreference = 'Stop'

$ExtId  = 'MS-CEINTL.vscode-language-pack-zh-hans'
$Locale = 'zh-cn'
$Argv   = Join-Path $env:USERPROFILE '.devin\argv.json'

Write-Host '==> Locating Devin Desktop CLI...'

$Cli = Join-Path $env:LOCALAPPDATA 'Programs\Devin\bin\devin-desktop.cmd'
if (-not (Test-Path $Cli)) {
  $cmd = Get-Command devin-desktop -ErrorAction SilentlyContinue
  if ($cmd) { $Cli = $cmd.Source }
}
if (-not (Test-Path $Cli)) {
  Write-Host 'ERROR: Devin Desktop not found. Please install it from https://devin.ai/download first.'
  exit 1
}
Write-Host "    Using CLI: $Cli"

Write-Host '==> Installing Chinese (Simplified) language pack extension...'
& $Cli --install-extension $ExtId --force
if ($LASTEXITCODE -ne 0) {
  Write-Host "ERROR: extension installation failed (exit $LASTEXITCODE)."
  exit $LASTEXITCODE
}

Write-Host "==> Setting display language to $Locale..."
$argvDir = Split-Path $Argv -Parent
if (-not (Test-Path $argvDir)) { New-Item -ItemType Directory -Path $argvDir -Force | Out-Null }

$localeLine = '"locale": "' + $Locale + '"'

if (-not (Test-Path $Argv)) {
  $content = '{' + "`r`n" + "`t" + $localeLine + "`r`n" + '}' + "`r`n"
  [System.IO.File]::WriteAllText($Argv, $content)
} else {
  $raw = [System.IO.File]::ReadAllText($Argv)
  if ($raw -match '"locale"\s*:') {
    $raw = [regex]::Replace($raw, '"locale"\s*:\s*"[^"]*"', $localeLine)
  } else {
    $insert = '{' + "`r`n" + "`t" + $localeLine + ','
    $raw = ([regex]'\{').Replace($raw, $insert, 1)
  }
  [System.IO.File]::WriteAllText($Argv, $raw)
}

Write-Host ''
Write-Host '==> Done.'
Write-Host '    Please fully quit and reopen Devin Desktop to apply the Chinese UI.'
Write-Host '    Note: use File -> New IDE Window for the fully localized editor surface;'
Write-Host '    the Agents command-center window stays in English (upstream limitation).'
