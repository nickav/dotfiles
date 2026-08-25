#!/usr/bin/env node
'use strict';

const fs = require('fs');
const path = require('path');
const { URL } = require('url');

function parseArgs(argv) {
  const args = { _: [] };
  for (let i = 0; i < argv.length; i++) {
    const a = argv[i];
    if (a.startsWith('--')) {
      const [key, inlineVal] = a.slice(2).split('=');
      args[key] = inlineVal !== undefined ? inlineVal : argv[++i];
    } else {
      args._.push(a);
    }
  }
  return args;
}

const args = parseArgs(process.argv.slice(2));
const startUrl = args._[0];
const outDir = args._[1] || './site';
const delayMs = Number(args.delay) || 500;
const batchSize = Number(args.batch) || 1;

if (!startUrl) {
  console.error('usage: node crawl.js <url> [outDir] [--delay ms] [--batch n]');
  process.exit(1);
}

const origin = new URL(startUrl);
const visited = new Set();
const queue = [origin.href];

function sleep(ms) {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

function urlToLocalPath(u) {
  const parsed = new URL(u);
  let p = decodeURIComponent(parsed.pathname);
  if (p.endsWith('/')) p += 'index.html';
  else if (!path.extname(p)) p += '.html';
  return path.join(outDir, p);
}

function extractLinks(html, baseUrl) {
  const links = new Set();

  function add(raw) {
    if (!raw || raw.startsWith('data:') || raw.startsWith('mailto:') || raw.startsWith('javascript:')) return;
    try {
      const abs = new URL(raw, baseUrl);
      if (abs.host === origin.host) links.add(abs.href.split('#')[0]);
    } catch (e) {}
  }

  const attrRe = /(?:href|src)\s*=\s*["']([^"'#]+)["']/gi;
  const srcsetRe = /srcset\s*=\s*["']([^"']+)["']/gi;
  const cssUrlRe = /url\(\s*["']?([^"')]+)["']?\s*\)/gi;
  let m;

  while ((m = attrRe.exec(html)) !== null) add(m[1]);
  while ((m = srcsetRe.exec(html)) !== null) {
    for (const part of m[1].split(',')) add(part.trim().split(/\s+/)[0]);
  }
  while ((m = cssUrlRe.exec(html)) !== null) add(m[1]);

  return links;
}

async function fetchAndSave(u) {
  const localPath = urlToLocalPath(u);
  if (fs.existsSync(localPath)) {
    const isHtml = path.extname(localPath) === '.html';
    return { content: isHtml ? fs.readFileSync(localPath, 'utf8') : null, isHtml };
  }
  const res = await fetch(u);
  const ctype = res.headers.get('content-type') || '';
  const isHtml = /html/.test(ctype);
  const isText = isHtml || /text|json|javascript|xml|svg/.test(ctype);
  const data = isText ? await res.text() : Buffer.from(await res.arrayBuffer());
  fs.mkdirSync(path.dirname(localPath), { recursive: true });
  fs.writeFileSync(localPath, data);
  return { content: isHtml ? data : null, isHtml };
}

async function visit(u) {
  if (visited.has(u)) return;
  visited.add(u);

  console.log(u);

  let result;
  try {
    result = await fetchAndSave(u);
  } catch (e) {
    console.error('failed', u, e.message);
    return;
  }

  if (result.isHtml && result.content) {
    for (const link of extractLinks(result.content, u)) {
      if (!visited.has(link)) queue.push(link);
    }
  }
}

async function crawl() {
  while (queue.length) {
    const batch = queue.splice(0, batchSize);
    await Promise.all(batch.map(visit));
    if (queue.length) await sleep(delayMs);
  }
}

const startTime = Date.now();
crawl().then(() => {
  const elapsedSec = ((Date.now() - startTime) / 1000).toFixed(1);
  console.log(`Done! Saved to ${outDir} (took ${elapsedSec}s)`);
});