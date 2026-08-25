#!/usr/bin/env node

//
// Usage:
// > node dlpod.js <rss-url> [output-dir] [options]
//
// Examples:
//
// Download all episodes to ./downloads:
// > node dlpod.js https://example.com/feed.rss
//
// Download to a specific folder with 5 parallel downloads:
// > node dlpod.js https://example.com/feed.rss ./my-podcast -n 5
//
// Use sequential filenames (e.g. 001_Episode Title.mp3):
// > node dlpod.js https://example.com/feed.rss ./my-podcast -N sequential
//

const https = require('https');
const http = require('http');
const fs = require('fs');
const path = require('path');
const { parseString } = require('./third_party/xml2js_0.6.2.min.js');

function parseArgs(argv) {
  const args = { url: null, dir: './downloads', parallel: 3, force: false, naming: 'original' };
  const raw = argv.slice(2);
  for (let i = 0; i < raw.length; i++) {
    switch (raw[i]) {
      case '--parallel':  case '-n': args.parallel = parseInt(raw[++i], 10); break;
      case '--force':     case '-f': args.force = true; break;
      case '--naming':    case '-N': args.naming = raw[++i]; break;
      default:
        if (!args.url) args.url = raw[i];
        else args.dir = raw[i];
    }
  }
  if (!['original', 'sequential'].includes(args.naming)) {
    console.error('--naming must be "original" or "sequential"');
    process.exit(1);
  }
  return args;
}

const args = parseArgs(process.argv);

if (!args.url) {
  console.error('Usage: node podcast.js <rss-url> [output-dir] [-n|--parallel N] [-f|--force] [-N|--naming original|sequential]');
  process.exit(1);
}

function fetch(url) {
  return new Promise((resolve, reject) => {
    const client = url.startsWith('https') ? https : http;
    client.get(url, { headers: { 'User-Agent': 'Mozilla/5.0' } }, res => {
      if (res.statusCode >= 300 && res.statusCode < 400 && res.headers.location)
        return fetch(res.headers.location).then(resolve).catch(reject);
      let data = '';
      res.on('data', chunk => data += chunk);
      res.on('end', () => resolve(data));
      res.on('error', reject);
    }).on('error', reject);
  });
}

function download(url, dest, label) {
  return new Promise((resolve, reject) => {
    const client = url.startsWith('https') ? https : http;
    const tmp = dest + '.part';
    const file = fs.createWriteStream(tmp);
    client.get(url, { headers: { 'User-Agent': 'Mozilla/5.0' } }, res => {
      if (res.statusCode >= 300 && res.statusCode < 400 && res.headers.location) {
        file.close();
        fs.unlinkSync(tmp);
        return download(res.headers.location, dest, label).then(resolve).catch(reject);
      }
      const total = parseInt(res.headers['content-length'] || '0', 10);
      let received = 0;
      res.on('data', chunk => {
        received += chunk.length;
        if (total) process.stdout.write(`\r  ${label}: ${((received / total) * 100).toFixed(1)}%   `);
      });
      res.pipe(file);
      file.on('finish', () => {
        file.close();
        fs.renameSync(tmp, dest);
        console.log(`\r  ${label}: done        `);
        resolve();
      });
    }).on('error', err => {
      fs.existsSync(tmp) && fs.unlinkSync(tmp);
      reject(err);
    });
  });
}

function sanitize(name) {
  return name.replace(/[<>:"/\\|?*\x00-\x1f]/g, '_').trim();
}

function resolveFilename(ep, index, total, naming) {
  const pad = String(total - index).padStart(String(total).length, '0');
  if (naming === 'sequential')
    return `${pad}_${sanitize(ep.title)}.mp3`;
  return ep.filename || `${pad}_${sanitize(ep.title)}.mp3`;
}

async function pool(tasks, concurrency) {
  const queue = [...tasks];
  const workers = Array.from({ length: concurrency }, async () => {
    while (queue.length) await queue.shift()();
  });
  await Promise.all(workers);
}

async function main() {
  console.log(`Fetching feed: ${args.url}`);
  const xml = await fetch(args.url);

  const feed = await new Promise((res, rej) =>
    parseString(xml, (err, result) => err ? rej(err) : res(result))
  );

  const items = feed?.rss?.channel?.[0]?.item || [];
  const mp3s = items
    .map(item => {
      const enc = item.enclosure?.[0]?.['$'];
      const title = item.title?.[0] || 'untitled';
      if (!enc?.url || !enc.url.match(/\.mp3|audio\/mpeg/i)) return null;
      const clean = enc.url.split('?')[0];
      const filename = path.basename(new URL(clean).pathname);
      return { title, url: clean, filename };
    })
    .filter(Boolean);

  if (!mp3s.length) {
    console.error('No MP3 enclosures found in feed.');
    process.exit(1);
  }

  console.log(`\nFound ${mp3s.length} episodes:\n`);
  mp3s.forEach((ep, i) => console.log(`  [${i + 1}] ${ep.title}  →  ${resolveFilename(ep, i, mp3s.length, args.naming)}`));

  fs.mkdirSync(args.dir, { recursive: true });

  console.log(`\nDownloading to: ${args.dir} (parallel: ${args.parallel}, force: ${args.force}, naming: ${args.naming})\n`);

  const tasks = mp3s.map((ep, i) => async () => {
    const filename = resolveFilename(ep, i, mp3s.length, args.naming);
    const dest = path.join(args.dir, filename);
    const label = `[${i + 1}/${mp3s.length}]`;

    if (!args.force && fs.existsSync(dest)) {
      console.log(`${label} Skipping (exists): ${filename}`);
      return;
    }

    console.log(`${label} Starting: ${ep.title}`);
    await download(ep.url, dest, label);
  });

  await pool(tasks, args.parallel);

  console.log('\nDone.');
}

main().catch(err => { console.error(err); process.exit(1); });
