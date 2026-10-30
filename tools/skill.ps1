<#
  skill.ps1 — anbeime/skill 技能仓库本地客户端（按需下载，不整库克隆）

  用法:
    .\skill.ps1 list                      列出全部技能
    .\skill.ps1 search <关键字>           搜索技能
    .\skill.ps1 info <名称>               查看该技能的 SKILL.md 开头
    .\skill.ps1 install <名称>            安装技能到 %DSH_HOME%\skills
    .\skill.ps1 install <名称> -To D:\x   安装到指定目录
    .\skill.ps1 update                    更新技能索引
#>
param(
  [Parameter(Position = 0)][string]$Command = 'list',
  [Parameter(Position = 1)][string]$Name,
  [string]$To = (Join-Path $env:DSH_HOME 'skills'),
  [string]$Root,
  [switch]$Force
)

$ErrorActionPreference = 'Stop'
$OutputEncoding = [Text.Encoding]::UTF8
[Console]::OutputEncoding = [Text.Encoding]::UTF8

$here  = if ($Root) { $Root } elseif ($PSScriptRoot) { $PSScriptRoot } else { (Get-Location).Path }
$repo  = Join-Path $here 'anbeime-skill'
$index = Join-Path $here 'skills-index.json'

function Invoke-Git([string[]]$a) {
  $prev = $ErrorActionPreference
  $ErrorActionPreference = 'Continue'   # git 会把进度写到 stderr，不能当成异常
  try {
    $out = & git -C $repo @a 2>&1
    $code = $LASTEXITCODE
  }
  finally { $ErrorActionPreference = $prev }
  if ($code -ne 0) { throw ("git " + ($a -join ' ') + " 失败:`n" + ($out -join "`n")) }
  return $out
}

function Initialize-Mirror {
  if (Test-Path (Join-Path $repo '.git')) { return }
  Write-Output "首次运行：建立上游元数据镜像（约 0.2 MB，不下载技能内容）..."
  $prev = $ErrorActionPreference
  $ErrorActionPreference = 'Continue'
  try {
    $out = & git -c http.sslBackend=openssl clone --filter=blob:none --depth 1 --no-checkout `
      https://github.com/anbeime/skill.git $repo 2>&1
    $code = $LASTEXITCODE
  }
  finally { $ErrorActionPreference = $prev }
  if ($code -ne 0) {
    throw ("无法克隆 anbeime/skill（github.com 可能不可达）：`n" + ($out -join "`n") +
      "`n改用 API 通道：node .\skill-api.mjs list")
  }
  Write-Output "镜像就绪。"
}

function Get-Skills {
  if (-not (Test-Path $index)) { throw "索引不存在，先执行: .\skill.ps1 update" }
  (Get-Content -Raw -Encoding UTF8 $index | ConvertFrom-Json).skills |
    Where-Object { $_.name -notlike '._*' }
}

function Resolve-Skill([string]$n) {
  $all = Get-Skills
  $hit = @($all | Where-Object { $_.name -eq $n })
  if (-not $hit) { $hit = @($all | Where-Object { $_.name -like "*$n*" }) }
  if (-not $hit) { throw "找不到技能: $n（用 .\skill.ps1 search $n 查一下）" }
  if ($hit.Count -gt 1) {
    throw ("名称不唯一，请用更完整的名称：" + (($hit | ForEach-Object { $_.name }) -join ', '))
  }
  $hit[0]
}

if (@('install', 'info', 'update') -contains $Command.ToLower()) { Initialize-Mirror }

switch ($Command.ToLower()) {
  'list' {
    $s = @(Get-Skills | Sort-Object name)
    Write-Output ("共 {0} 个技能包：" -f $s.Count)
    $s | ForEach-Object { "  {0,-38} {1,3} files  {2}" -f $_.name, $_.files, $_.path }
  }
  'search' {
    if (-not $Name) { throw "用法: .\skill.ps1 search <关键字>" }
    $s = @(Get-Skills | Where-Object { $_.name -like "*$Name*" -or $_.path -like "*$Name*" })
    if (-not $s) { Write-Output "没有匹配 '$Name' 的技能"; break }
    $s | ForEach-Object { "  {0,-38} {1}" -f $_.name, $_.path }
  }
  'info' {
    if (-not $Name) { throw "用法: .\skill.ps1 info <名称>" }
    $s = Resolve-Skill $Name
    Write-Output "技能: $($s.name)   目录: $($s.path)   文件: $($s.files)"
    Write-Output ('-' * 60)
    & git -C $repo show "HEAD:$($s.path)/SKILL.md" 2>&1 | Select-Object -First 50
  }
  'update' {
    Invoke-Git @('fetch', '-q', '--depth', '1', '--filter=blob:none', 'origin', 'main') | Out-Null
    Invoke-Git @('reset', '--soft', 'FETCH_HEAD') | Out-Null
    # 用 scriptblock 调用，避免「未签名脚本」的执行策略拦截
    $gen = [scriptblock]::Create((Get-Content -Raw -Encoding UTF8 (Join-Path $here 'gen-index.ps1')))
    & $gen -Repo $repo -OutFile $index
  }
  'install' {
    if (-not $Name) { throw "用法: .\skill.ps1 install <名称> [-To 目录]" }
    $s = Resolve-Skill $Name
    $dest = Join-Path $To $s.name
    if ((Test-Path $dest) -and -not $Force) { throw "$dest 已存在（加 -Force 覆盖）" }

    Write-Output "下载 $($s.name) [$($s.files) 文件] ..."
    $tar = Join-Path $here (".fetch-" + [guid]::NewGuid().ToString('N') + ".tar")
    try {
      Invoke-Git @('archive', '-o', $tar, "HEAD:$($s.path)")
      if (Test-Path $dest) { Remove-Item $dest -Recurse -Force }
      New-Item -ItemType Directory -Force -Path $dest | Out-Null
      & tar.exe -xf $tar -C $dest
      if ($LASTEXITCODE -ne 0) { throw "解包失败" }
    }
    finally {
      Remove-Item $tar -Force -ErrorAction SilentlyContinue
    }

    $n = (Get-ChildItem $dest -Recurse -File | Measure-Object).Count
    Write-Output "完成: $dest  ($n 个文件)"
    if (Test-Path (Join-Path $dest 'SKILL.md')) {
      $line = (Get-Content (Join-Path $dest 'SKILL.md') -Encoding UTF8 -TotalCount 10 |
        Where-Object { $_ -like 'description:*' } | Select-Object -First 1)
      if ($line) {
        $d = ($line -replace '^description:\s*', '')
        Write-Output ("说明: " + $d.Substring(0, [Math]::Min(160, $d.Length)))
      }
    }
  }
  default { throw "未知命令: $Command（list / search / info / install / update）" }
}