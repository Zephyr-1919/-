// skill-api.mjs — 通过 api.github.com 下载技能（github.com 被墙/不可达时的兜底方案）
// 用法:
//   node skill-api.mjs list                     列出仓库内所有技能目录
//   node skill-api.mjs install <技能目录> [目标目录]
//   node skill-api.mjs pull <技能目录> <目标目录>
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const here = path.dirname(fileURLToPath(import.meta.url));
const REPO = 'anbeime/skill';
const BRANCH = 'main';
const CACHE = path.join(here, 'tree-cache.json');

function token() {
  if (process.env.GITHUB_TOKEN) return process.env.GITHUB_TOKEN.trim();
  const home = process.env.DSH_HOME || path.join(process.env.USERPROFILE || '', '.dsh');
  const f = path.join(home, 'github-token.txt');
  return fs.existsSync(f) ? fs.readFileSync(f, 'utf8').split(/\r?\n/)[0].trim() : null;
}
const T = token();
const H = { 'User-Agent': 'dsh-agent', Accept: 'application/vnd.github+json', ...(T ? { Authorization: `Bearer ${T}` } : {}) };

async function api(p) {
  const r = await fetch(`https://api.github.com${p}`, { headers: H, signal: AbortSignal.timeout(30000) });
  if (!r.ok) throw new Error(`${p} -> ${r.status} ${(await r.text()).slice(0, 200)}`);
  return r.json();
}

async function getTree(force = false) {
  if (!force && fs.existsSync(CACHE)) {
    const t = JSON.parse(fs.readFileSync(CACHE, 'utf8'));
    if (t.repo === REPO && Date.now() - t.at < 6 * 3600 * 1000) return t.tree;
  }
  const j = await api(`/repos/${REPO}/git/trees/${BRANCH}?recursive=1`);
  const tree = j.tree.map((e) => ({ path: e.path, type: e.type, sha: e.sha, size: e.size }));
  fs.writeFileSync(CACHE, JSON.stringify({ repo: REPO, at: Date.now(), tree }), 'utf8');
  return tree;
}

const [cmd, arg1, arg2] = process.argv.slice(2);

if (cmd === 'list') {
  const tree = await getTree();
  const dirs = new Set();
  for (const e of tree) if (/SKILL\.md$/i.test(e.path)) dirs.add(e.path.replace(/\/?SKILL\.md$/i, ''));
  const names = [...dirs].sort();
  console.log(`技能目录 ${names.length} 个：`);
  names.forEach((n) => console.log('  ' + n));
} else if (cmd === 'install' || cmd === 'pull') {
  if (!arg1) { console.error('用法: node skill-api.mjs install <技能目录> [目标目录]'); process.exit(2); }
  const skillDir = arg1.replace(/^\/+|\/+$/g, '');
  const dest = arg2 || path.join(process.env.DSH_HOME || '.', 'skills', path.basename(skillDir));
  const tree = await getTree();
  const prefix = skillDir + '/';
  const files = tree.filter((e) => e.type === 'blob' && e.path.startsWith(prefix));
  if (!files.length) { console.error(`仓库内没有 ${skillDir} 的文件`); process.exit(1); }
  console.log(`下载 ${skillDir}: ${files.length} 个文件 -> ${dest}`);
  fs.mkdirSync(dest, { recursive: true });

  let done = 0, bytes = 0;
  const queue = [...files];
  const worker = async () => {
    while (queue.length) {
      const f = queue.shift();
      const j = await api(`/repos/${REPO}/git/blobs/${f.sha}`);
      const buf = Buffer.from(j.content, j.encoding === 'base64' ? 'base64' : 'utf8');
      const out = path.join(dest, f.path.slice(prefix.length));
      fs.mkdirSync(path.dirname(out), { recursive: true });
      fs.writeFileSync(out, buf);
      done++; bytes += buf.length;
      if (done % 25 === 0 || done === files.length) console.log(`  ${done}/${files.length}  (${(bytes / 1024).toFixed(0)} KB)`);
    }
  };
  await Promise.all(Array.from({ length: 8 }, worker));
  console.log(`完成: ${dest}`);
} else {
  console.log('命令: list | install <技能目录> [目标目录]');
}