#!/usr/bin/env pwsh
# Single-line installer for sp-ecc (Superpowers + Everything Claude Code) on OpenCode.
# Windows:  irm https://raw.githubusercontent.com/jamaicanyutie/sp-ecc/master/scripts/install.ps1 | iex
$ErrorActionPreference = 'Stop'

$RepoUrl = 'https://github.com/jamaicanyutie/sp-ecc.git'
$ConfigDir = if ($env:OPENCODE_CONFIG_DIR) { $env:OPENCODE_CONFIG_DIR } else { Join-Path $HOME '.config/opencode' }
$SpEccDir = Join-Path $ConfigDir 'sp-ecc'
$PluginsDir = Join-Path $ConfigDir 'plugins'
$SkillsDir = Join-Path $ConfigDir 'skills'
$PluginSrc = Join-Path $SpEccDir '.opencode/plugins/sp-ecc.js'
$PluginDest = Join-Path $PluginsDir 'sp-ecc.js'
$SkillsSrc = Join-Path $SpEccDir 'skills'
$SkillsDest = Join-Path $SkillsDir 'sp-ecc'

Write-Host "[sp-ecc] config dir: $ConfigDir"

New-Item -ItemType Directory -Force -Path $SpEccDir, $PluginsDir, $SkillsDir | Out-Null

if (Test-Path (Join-Path $SpEccDir '.git')) {
  Write-Host '[sp-ecc] updating existing clone...'
  git -C $SpEccDir pull --ff-only
} else {
  Write-Host '[sp-ecc] cloning repository...'
  git clone $RepoUrl $SpEccDir
}

Write-Host '[sp-ecc] linking plugin and skills...'

Remove-Item $PluginDest -Force -ErrorAction SilentlyContinue
$pluginMethod = 'copied'
try {
  New-Item -ItemType SymbolicLink -Path $PluginDest -Target $PluginSrc -ErrorAction Stop | Out-Null
  $pluginMethod = 'symlink'
} catch {
  Copy-Item -LiteralPath $PluginSrc -Destination $PluginDest -Force
}
Write-Host "[sp-ecc] plugin linked ($pluginMethod): $PluginDest"

Remove-Item $SkillsDest -Recurse -Force -ErrorAction SilentlyContinue
$osIsWindows = if ($PSVersionTable.PSEdition -eq 'Core') { $IsWindows } else { $env:OS -eq 'Windows_NT' }
if ($osIsWindows) {
  New-Item -ItemType Junction -Path $SkillsDest -Target $SkillsSrc -ErrorAction Stop | Out-Null
} else {
  New-Item -ItemType SymbolicLink -Path $SkillsDest -Target $SkillsSrc -ErrorAction Stop | Out-Null
}
Write-Host "[sp-ecc] skills linked: $SkillsDest"

Write-Host '[sp-ecc] done. Restart opencode.'
Write-Host '[sp-ecc] verify: opencode debug skill && opencode run "say hi"'