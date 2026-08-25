#!/usr/bin/env node
'use strict';

const fs = require('fs');
const path = require('path');
const http = require('http');

const rootDir = path.resolve(process.argv[2] || './site');
const port = Number(process.argv[3]) || 8080;

const mimeTypes = {
  '.html': 'text/html',
  '.css': 'text/css',
  '.js': 'text/javascript',
  '.json': 'application/json',
  '.svg': 'image/svg+xml',
  '.png': 'image/png',
  '.jpg': 'image/jpeg',
  '.jpeg': 'image/jpeg',
  '.gif': 'image/gif',
  '.webp': 'image/webp',
  '.ico': 'image/x-icon',
  '.woff': 'font/woff',
  '.woff2': 'font/woff2',
};

function resolvePath(urlPath) {
  let p = path.join(rootDir, decodeURIComponent(urlPath.split('?')[0]));

  if (p.endsWith('/')) {
    p += 'index.html';
  } else if (!path.extname(p) && fs.existsSync(p + '.html')) {
    p += '.html';
  } else if (fs.existsSync(p) && fs.statSync(p).isDirectory()) {
    p = path.join(p, 'index.html');
  }

  if (!p.startsWith(rootDir)) return null;
  return p;
}

const server = http.createServer((req, res) => {
  const filePath = resolvePath(req.url);

  if (!filePath || !fs.existsSync(filePath)) {
    res.writeHead(404, { 'Content-Type': 'text/plain' });
    res.end('404 not found');
    return;
  }

  const ext = path.extname(filePath);
  console.log(`[serve]`, filePath);
  res.writeHead(200, { 'Content-Type': mimeTypes[ext] || 'application/octet-stream' });
  fs.createReadStream(filePath).pipe(res);
});

server.listen(port, () => console.log(`serving ${rootDir} at http://localhost:${port}`));