# 生成 anbeime/skill 仓库的技能索引（只读 git 树，不下载文件内容）
param(
  [Parameter(Mandatory)][string]$Repo,
  [Parameter(Mandatory)][string]$OutFile
)
$ErrorActionPreference = 'Stop'

# 该仓库统一使用 openssl TLS 后端（本机 schannel 有问题）
& git -C $Repo config http.sslBackend openssl

$lines = & git -C $Repo ls-tree -r --name-only HEAD
if ($LASTEXITCODE -ne 0) { throw "git ls-tree 失败" }

$files = @($lines | Where-Object { $_ })
$roots = @('skills/', 'projects/', 'antinet-agentteams/skills/')
$skills = @{}

foreach ($p in $files) {
  if ($p -notmatch '(?i)SKILL\.md$') { continue }
  $dir = $p -replace '(?i)/?SKILL\.md$', ''
  $root = $roots | Where-Object { $dir.StartsWith($_) } | Select-Object -First 1
  if (-not $root) { continue }
  $rest = $dir.Substring($root.Length)
  $skills[$dir] = [pscustomobject]@{
    name  = ($rest -split '/')[-1]
    path  = $dir
    root  = $root.TrimEnd('/')
    files = 0
  }
}

foreach ($p in $files) {
  foreach ($k in @($skills.Keys)) {
    if ($p.StartsWith("$k/")) { $skills[$k].files++ }
  }
}

$list = $skills.Values | Sort-Object name
$payload = [ordered]@{
  repo         = 'anbeime/skill'
  branch       = 'main'
  generated_at = (Get-Date).ToString('o')
  count        = $list.Count
  skills       = @($list)
}
$payload | ConvertTo-Json -Depth 6 | Set-Content -Path $OutFile -Encoding UTF8

Write-Output "索引完成: $($list.Count) 个技能包 / 共 $($files.Count) 个文件"
$list | Select-Object -First 8 | ForEach-Object { "  {0}  ({1} files)" -f $_.name, $_.files }