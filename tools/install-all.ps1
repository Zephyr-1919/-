# install-all.ps1 — 把仓库内 skills/ 全部安装到 DSH 用户技能目录
param([string]$To = (Join-Path $env:DSH_HOME 'skills'))
$ErrorActionPreference = 'Stop'
$src = Join-Path (Split-Path -Parent $PSScriptRoot) 'skills'
if (-not (Test-Path $src)) { throw "找不到 $src" }
New-Item -ItemType Directory -Force -Path $To | Out-Null
$n = 0
foreach ($d in Get-ChildItem $src -Directory) {
  $dest = Join-Path $To $d.Name
  if (Test-Path $dest) { Remove-Item $dest -Recurse -Force }
  Copy-Item $d.FullName $dest -Recurse -Force
  $n++
  Write-Output "  + $($d.Name)"
}
Write-Output "完成：已安装 $n 个技能到 $To"