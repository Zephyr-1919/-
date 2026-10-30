# install-all.ps1 — 把仓库内 skills/ 全部安装到 DSH 用户技能目录
# 用法:
#   .\tools\install-all.ps1                    安装到 %DSH_HOME%\skills
#   .\tools\install-all.ps1 -To D:\my-skills   安装到指定目录
param(
  [string]$To = (Join-Path $env:DSH_HOME 'skills'),
  [string]$Root
)
$ErrorActionPreference = 'Stop'

$here = if ($Root) { $Root } elseif ($PSScriptRoot) { $PSScriptRoot } else { (Get-Location).Path }
$src  = Join-Path (Split-Path -Parent $here) 'skills'
if (-not (Test-Path $src)) { throw "找不到技能目录: $src" }

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