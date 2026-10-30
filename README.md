# 技能收藏库 · Skills Vault

个人 AI Agent 技能库，收录 [anbeime/skill](https://github.com/anbeime/skill) 筛选后的技能包与配套工具。
技能安装后由 DeepSeek Harness 自动加载（用户级目录 `~/.dsh/skills`）。

## 快速开始

```powershell
git clone https://github.com/Zephyr-1919/-.git
cd -

# 列出 / 搜索 / 查看
.\tools\skill.ps1 list
.\tools\skill.ps1 search diagram
.\tools\skill.ps1 info archify

# 安装（默认装到 ~/.dsh/skills，加载后立即生效）
.\tools\skill.ps1 install archify
```

完整技能清单见 [SKILLS.md](SKILLS.md)。

## 工具

| 文件 | 说明 |
|---|---|
| `tools/skill.ps1` | 技能命令行：list / search / info / install / update（git 通道，最快） |
| `tools/skill-api.mjs` | 同上，走 api.github.com（github.com 被墙时的兜底） |
| `tools/gh-api.mjs` | 通用 GitHub REST / GraphQL 客户端：issue、PR、项目看板 |
| `tools/gen-index.ps1` | 重建 `skills-index.json` 索引 |
| `tools/skills-index.json` | 93 个技能包索引（名称 / 路径 / 文件数） |

## 命令速查

```powershell
# 调用 GitHub API
node .\tools\gh-api.mjs GET /user
node .\tools\gh-api.mjs GET "/repos/OWNER/REPO/issues?state=open"
node .\tools\gh-api.mjs POST /repos/OWNER/REPO/issues '{"title":"任务"}'

# 技能按需下载
node .\tools\skill-api.mjs list
node .\tools\skill-api.mjs install skills\diagram-design\skills\diagram-design
```

## 说明

- 技能来源仓库体积约 285 MB，本工具只拉取目录元数据（约 0.14 MB），安装时按需下载单个技能。
- 令牌等敏感信息不入库，见 `.gitignore`。