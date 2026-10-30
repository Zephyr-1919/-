// gh-api.mjs — 极简 GitHub API 客户端（走 Node 自带 OpenSSL，绕开本机 schannel 故障）
// 用法:
//   node gh-api.mjs GET /user
//   node gh-api.mjs GET "/repos/OWNER/REPO/issues?state=open&per_page=10"
//   node gh-api.mjs POST /repos/OWNER/REPO/issues '{"title":"标题","body":"内容"}'
//   node gh-api.mjs PATCH /repos/OWNER/REPO/issues/1 '{"state":"closed"}'
//   node gh-api.mjs GRAPHQL '{"query":"query { viewer { login } }"}'
// 令牌来源（按优先级）: 环境变量 GITHUB_TOKEN / GH_TOKEN，或文件 %DSH_HOME%\github-token.txt
import { readFileSync, existsSync } from 'node:fs';
import { join } from 'node:path';

const [methodArg, pathArg, bodyArg] = process.argv.slice(2);
if (!methodArg || !pathArg) {
  console.error('用法: node gh-api.mjs <GET|POST|PATCH|PUT|DELETE|GRAPHQL> <路径或查询> [JSON体]');
  process.exit(2);
}

function readToken() {
  if (process.env.GITHUB_TOKEN) return process.env.GITHUB_TOKEN.trim();
  if (process.env.GH_TOKEN) return process.env.GH_TOKEN.trim();
  const home = process.env.DSH_HOME || join(process.env.USERPROFILE || '', '.dsh');
  const f = join(home, 'github-token.txt');
  if (existsSync(f)) {
    const t = readFileSync(f, 'utf8').split(/\r?\n/)[0].trim();
    if (t) return t;
  }
  return null;
}

const token = readToken();
const headers = { 'User-Agent': 'dsh-agent', Accept: 'application/vnd.github+json' };
if (token) headers.Authorization = `Bearer ${token}`;

const method = methodArg.toUpperCase();
let url, options = { method: 'GET', headers };

if (method === 'GRAPHQL') {
  url = 'https://api.github.com/graphql';
  options.method = 'POST';
  options.body = bodyArg || '{"query":"query { viewer { login name } }"}';
  headers['Content-Type'] = 'application/json';
} else {
  url = pathArg.startsWith('http') ? pathArg : 'https://api.github.com' + (pathArg.startsWith('/') ? pathArg : '/' + pathArg);
  options.method = method;
  if (bodyArg) {
    options.body = bodyArg;
    headers['Content-Type'] = 'application/json';
  }
}

try {
  const res = await fetch(url, options);
  const text = await res.text();
  let out = text;
  try { out = JSON.stringify(JSON.parse(text), null, 2); } catch { /* 非 JSON 原样输出 */ }
  console.log(`# ${res.status} ${res.statusText}  ${token ? '(已认证)' : '(匿名，60 次/小时)'}`);
  if (res.status >= 400) { console.error(out); process.exit(1); }
  console.log(out);
} catch (e) {
  console.error('请求失败:', e.message);
  process.exit(1);
}