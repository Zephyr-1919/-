# 技能目录

仓库内置 **14 个通用技能**（`skills/`，可直接复制到 `~/.dsh/skills` 离线使用），
并索引上游 [anbeime/skill](https://github.com/anbeime/skill) 共 94 个技能包（按需下载）。

## 一、已收录（离线可用）

| 技能 | 文件 | 体积 | 说明 |
|---|---|---|---|
| `agent-team` | 7 | 99 KB | 产品经理与项目管理专家在应对复杂项目时，使用此技能可动态组建包含“执行、指挥、评审”的专属AI团队。实时查看多智能体辩论与决策全过程，共享统一上下文记忆，一键完成从会议决策到系统构建的全流程高效协同！ |
| `archify` | 1 | 16 KB | Create polished, validated architecture, workflow, sequence, data-flow, and lifecycle/state diagrams… |
| `convert-documents-to-markdown` | 1 | 2 KB | Convert Word (.doc, .docx), PowerPoint (.ppt, .pptx), Excel (.xls, .xlsx), OpenDocument (.odt, .ods,… |
| `data-storytelling` | 1 | 12 KB | 数据科学家与产品经理在向高管汇报或制作投资者演示时，当面临数据枯燥难懂的痛点，使用此技能可套用“Setup-Conflict-Resolution”叙事框架，自动生成结合可视化与业务上下文的洞察报告，… |
| `diagram-design` | 287 | 5200 KB | Create branded architecture, architecture delta, IT current-state, flowchart, sequence, state machin… |
| `expert-prompt-migrator` | 10 | 17 KB | 将任意专家/角色提示词规范化为可移植格式并迁移到任意 AI（DeepSeek、豆包、Kimi、Claude、Ollama 等）的实用工具。内置「清理平台语法 / 单专家单任务 / 补背景信息」三大原则… |
| `frontend-design` | 1 | 4 KB | 网页与数字界面设计师在构建Web页面或应用组件时，若受够了千篇一律的AI味设计，请用此技能。一键生成极具视觉冲击力、排版独特、动效惊艳的生产级前端代码，告别平庸，打造令人难忘的高品质数字界面。 |
| `multi-agent-meeting` | 8 | 35 KB | 项目管理专家与产品经理在做项目决策、技术评审或商业策略制定时，当需要多视角碰撞以打破思维局限，请用此技能模拟多智能体真实会议辩论，一键生成包含决策结论、核心论据与风险提示的完整会议记录，让复杂决策高效… |
| `paper-analysis-assistant` | 10 | 34 KB | 其他高等院校教师与数据科学家在追踪前沿学术时，当需要深度解析arXiv论文，用此技能可一键下载PDF并自动生成词频分析、双人播客、交互式网页、PPT演示与总结图，将数小时的文献阅读转化为多媒体内容，效… |
| `pdf-processing-pro` | 5 | 46 KB | 综合办公文员与软件开发工程师当需要批量处理PDF表单、提取表格或进行OCR识别时，使用内置脚本一键完成自动化提取与数据校验，彻底告别繁琐的手动录入，让复杂文档工作流高效、稳健落地。 |
| `ppt-generator` | 5 | 51 KB | 产品经理、运营专员及综合办公文员在准备商业演示、学术汇报或培训课件时，通过七角色协作工作流，自动分析主题、推荐模板、填充内容并智能配图，一键输出高质量 PPTX 文件，将数小时的排版制作缩短至几分钟！ |
| `pptx-generator` | 11 | 51 KB | 产品经理与运营专员在准备汇报展示时，将 JSON 数据一键转换为标准 .pptx 文件。自动应用多种布局、图表与表格样式，快速生成专业 PPT，彻底告别繁琐手工排版，让内容产出与展示更高效！ |
| `product-manager-toolkit` | 4 | 50 KB | 产品经理必备利器！当面临海量需求排期、用户调研分析和PRD撰写等场景时，使用此工具可一键计算RICE得分、自动提炼访谈洞察并快速生成标准PRD文档，大幅提升需求决策与产品交付效率，让规划更科学。 |
| `web-design-analyzer` | 5 | 32 KB | 网页与数字界面设计师和网页开发工程师在需要逆向分析网页截图时，使用本技能一键提取配色、排版及组件特征，自动生成结构化 Design System 数据与 AI Coding Prompt，让设计还原与… |

一键全部安装：

```powershell
.\tools\install-all.ps1
```

## 二、上游候选（按需下载）

安装任意一个：

```powershell
.\tools\skill.ps1 install <技能名>          # github.com 可达时
node .\tools\skill-api.mjs install <路径>   # 走 API
```

| 技能 | 文件数 | 上游路径 |
|---|---|---|
| `_template` | 1 | `skills/_template` |
| `agentkit-multimedia-shopping` | 16 | `skills/agentkit-multimedia-shopping/agentkit-multimedia-shopping` |
| `antinet-doc-parse` | 3 | `skills/antinet-doc-parse` |
| `antinet-four-color-cards` | 3 | `skills/antinet-four-color-cards` |
| `antinet-provenance` | 3 | `skills/antinet-provenance` |
| `antinet-security-scan` | 3 | `skills/antinet-security-scan` |
| `article-illustrator` | 3 | `skills/article-illustrator/article-illustrator` |
| `article-illustrator` | 3 | `skills/content-creation-publisher/article-illustrator` |
| `atutun-xhs-cover` | 2 | `skills/atutun-xhs-cover/atutun-xhs-cover` |
| `baoyu-format-markdown` | 7 | `skills/content-creation-publisher/baoyu-format-markdown` |
| `baoyu-post-to-wechat` | 29 | `skills/content-creation-publisher/baoyu-post-to-wechat` |
| `baoyu-post-to-x` | 11 | `skills/content-creation-publisher/baoyu-post-to-x` |
| `baoyu-url-to-markdown` | 6 | `skills/content-creation-publisher/baoyu-url-to-markdown` |
| `bedtime-story` | 3 | `skills/bedtime-story/bedtime-story` |
| `chrome-automation` | 13 | `skills/chrome-automation/chrome-automation` |
| `companion-simple` | 41 | `projects/companion-simple` |
| `companion-skill` | 16 | `projects/companion-skill` |
| `content-creation-publisher` | 57 | `skills/content-creation-publisher` |
| `content-research-writer` | 1 | `skills/content-research-writer` |
| `contract-review` | 27 | `skills/legal-assistant-skills-main/contract-review` |
| `digital-avatar-shopping-video` | 6 | `skills/digital-avatar-shopping-video/digital-avatar-shopping-video` |
| `doc-parse` | 2 | `antinet-agentteams/skills/doc-parse` |
| `dream-video-prompt-generator` | 8 | `skills/dream-video-prompt-generator/dream-video-prompt-generator` |
| `ecommerce-copywriter` | 4 | `skills/ecommerce-copywriter/ecommerce-copywriter` |
| `ecommerce-full-pipeline` | 1 | `skills/ecommerce-full-pipeline/ecommerce-full-pipeline` |
| `ecommerce-video-marketing` | 5 | `skills/ecommerce-video-marketing/ecommerce-video-marketing` |
| `email-concierge` | 16 | `skills/email-concierge` |
| `four-color-cards` | 2 | `antinet-agentteams/skills/four-color-cards` |
| `generic-extract-` | 0 | `skills/img2threejs/img2threejs/skills/generic-extract-` |
| `gpt-image-2-prompt-engine` | 3 | `skills/gpt-image-2-prompt-engine` |
| `historical-interview-scripts` | 27 | `skills/historical-interview-scripts/historical-interview-scripts` |
| `historical-science-video-prod` | 9 | `skills/historical-science-video-prod/historical-science-video-prod` |
| `icon-generator` | 1 | `skills/icon-generator` |
| `img2threejs` | 358 | `skills/img2threejs/img2threejs` |
| `infinitetalk` | 5 | `skills/infinitetalk/infinitetalk` |
| `infinitetalk` | 10 | `skills/infinitetalk` |
| `infinitetalk-shopping-avatar` | 7 | `skills/infinitetalk-shopping-avatar/infinitetalk-shopping-avatar` |
| `intelligent-content-system` | 4 | `skills/intelligent-content-system` |
| `ip-as-logo` | 5 | `skills/ip-as-logo/ip-as-logo` |
| `json-canvas` | 1 | `skills/obsidian-skills-integrated/json-canvas` |
| `kb-to-mpt` | 5 | `skills/kb-to-mpt` |
| `law-to-markdown` | 8 | `skills/legal-assistant-skills-main/law-to-markdown` |
| `media-processor` | 9 | `skills/media-processor/media-processor` |
| `moltbook` | 1 | `skills/moltbook` |
| `nanobanana-ppt-visualizer` | 9 | `skills/nanobanana-ppt-visualizer/nanobanana-ppt-visualizer` |
| `obsidian-bases` | 1 | `skills/obsidian-skills-integrated/obsidian-bases` |
| `obsidian-markdown` | 1 | `skills/obsidian-skills-integrated/obsidian-markdown` |
| `obsidian-skills-integrated` | 6 | `skills/obsidian-skills-integrated` |
| `ontoly-software-graph` | 3 | `skills/ontoly-software-graph` |
| `pet-commerce-creator` | 8 | `skills/pet-commerce-creator/pet-commerce-creator` |
| `photo-abstract-editorial` | 18 | `skills/photo-abstract-editorial/photo-abstract-editorial` |
| `poetry-music-visual` | 4 | `skills/poetry-music-visual/poetry-music-visual` |
| `pop-up-book-illustration` | 1 | `skills/pop-up-book-illustration/pop-up-book-illustration` |
| `ppt-roadshow-generator` | 11 | `skills/ppt-roadshow-generator/ppt-roadshow-generator` |
| `product-marketing-copywriter` | 5 | `skills/product-marketing-copywriter/product-marketing-copywriter` |
| `product-video-creator` | 5 | `skills/product-video-creator/product-video-creator` |
| `provenance` | 2 | `antinet-agentteams/skills/provenance` |
| `qiaomu-x-article-publisher` | 34 | `skills/qiaomu-x-article-publisher` |
| `qiaomu-x-article-publisher-github` | 18 | `skills/qiaomu-x-article-publisher/qiaomu-x-article-publisher-github` |
| `qwen3-asr-assistant` | 4 | `skills/qwen3-asr-assistant/qwen3-asr-assistant` |
| `qwen3-tts-local` | 4 | `skills/qwen3-tts-local/qwen3-tts-local` |
| `remotion-video-enhancer` | 11 | `skills/remotion-video-enhancer/remotion-video-enhancer` |
| `security-scan` | 2 | `antinet-agentteams/skills/security-scan` |
| `srt-whiteboard-animation` | 19 | `skills/srt-whiteboard-animation` |
| `stock-analysis` | 4 | `skills/stock-analysis/stock-analysis` |
| `tailored-resume-generator` | 1 | `skills/tailored-resume-generator/tailored-resume-generator` |
| `three-body-video-creator` | 13 | `skills/three-body-video-creator/three-body-video-creator` |
| `tts-voice-synthesis` | 6 | `skills/tts-voice-synthesis` |
| `video-creation-collaborator` | 12 | `skills/video-creation-collaborator/video-creation-collaborator` |
| `video-creation-pro` | 13 | `skills/video-creation-pro/video-creation-pro` |
| `video-creation-suite` | 29 | `skills/video-creation-suite/video-creation-suite` |
| `video-frame-extractor` | 5 | `skills/video-frame-extractor/video-frame-extractor` |
| `video-recreation` | 14 | `skills/video-recreation/video-recreation` |
| `video-transcript-downloader` | 5 | `skills/video-transcript-downloader/video-transcript-downloader` |
| `viral-video-copywriting` | 5 | `skills/viral-video-copywriting/viral-video-copywriting` |
| `voltagent-awesome-design-md` | 154 | `skills/voltagent-awesome-design-md/voltagent-awesome-design-md` |
| `web-to-app` | 4 | `skills/web-to-app/web-to-app` |
| `wechat-hotspot-publisher` | 16 | `skills/wechat-hotspot-publisher/wechat-hotspot-publisher` |
| `wechatsync-publisher` | 10 | `skills/wechatsync-publisher/wechatsync-publisher` |
| `xiaohongshu-makeup` | 5 | `skills/xiaohongshu-makeup/xiaohongshu-makeup` |