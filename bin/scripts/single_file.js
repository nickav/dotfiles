#!/usr/bin/env node

//
// single_file.js
// > Bundle any npm package or GitHub repo into a single .js file using esbuild.
//
//
// Usage:
// > node single_file.js <package|github-url> [--minify] [--runtime=node|browser]
// 
// Examples:
// > node single_file.js xml2js
// > node single_file.js xml2js@0.6.2 --minify
// > node single_file.js https://github.com/Leonidas-from-XIV/node-xml2js --runtime=browser
//
// Output is written to the current directory as <package>_<version>[.min].js.
// esbuild is installed automatically if not found globally.
//

const { execSync, spawnSync } = require('child_process');
const fs = require('fs');
const path = require('path');
const os = require('os');

// --- arg parsing ---

const args = process.argv.slice(2);
if (!args.length) {
  console.error('Usage: node single_file.js <package|github-url> [--minify] [--runtime=node|browser]');
  process.exit(1);
}

const input     = args[0];
const minify    = args.includes('--minify');
const runtimeArg = args.find(a => a.startsWith('--runtime='));
const platform  = runtimeArg ? runtimeArg.split('=')[1] : 'node';

if (!['node', 'browser'].includes(platform)) {
  console.error(`Unknown runtime: ${platform}`);
  process.exit(1);
}

// --- resolve package name and install source ---

function isGithubUrl(s) {
  return /^https?:\/\/github\.com\//i.test(s) || /^github:/.test(s);
}

function packageNameFromGithub(url) {
  // e.g. https://github.com/scalajs-io/xml2js -> xml2js
  return url.replace(/\/$/, '').split('/').pop().replace(/\.git$/, '');
}

const isGithub = isGithubUrl(input);
const pkgName  = isGithub ? packageNameFromGithub(input) : input.split('@')[0];

// --- work in a temp dir ---

const workDir = fs.mkdtempSync(path.join(os.tmpdir(), 'singlefile-'));
console.log(`Working in ${workDir}`);

try {
  // init bare package.json
  fs.writeFileSync(path.join(workDir, 'package.json'), JSON.stringify({ name: 'singlefile-build', version: '1.0.0' }));

  // install esbuild locally if not available
  const esbuildBin = resolveEsbuild(workDir);

  // install target package
  const installTarget = isGithub ? input : input;
  console.log(`Installing ${installTarget} ...`);
  execSync(`npm install ${installTarget}`, { cwd: workDir, stdio: 'inherit' });

  // resolve installed package.json to get name + version
  const installedPkgJson = resolveInstalledPkgJson(workDir, pkgName);
  const version  = installedPkgJson.version  || '0.0.0';
  const mainFile = installedPkgJson.main || 'index.js';
  const realName = installedPkgJson.name || pkgName;

  // entry point — resolve like Node does (try as-is, then .js, then /index.js)
  const entryBase = path.join(workDir, 'node_modules', realName, mainFile);
  const entryAbs  = resolveEntry(entryBase);
  if (!entryAbs) {
    throw new Error(`Entry point not found: ${entryBase} (tried .js, /index.js)`);
  }

  // build output filename
  const minSuffix = minify ? '.min' : '';
  const outFile   = path.join(process.cwd(), `${realName}_${version}${minSuffix}.js`);

  // run esbuild
  const esbuildArgs = [
    entryAbs,
    `--bundle`,
    `--platform=${platform}`,
    `--outfile=${outFile}`,
    minify ? '--minify' : '',
    platform === 'node' ? '--target=node14' : '--target=es2017',
  ].filter(Boolean);

  console.log(`Bundling with esbuild (platform=${platform}, minify=${minify}) ...`);
  const result = spawnSync(esbuildBin, esbuildArgs, { stdio: 'inherit' });
  if (result.status !== 0) throw new Error('esbuild failed');

  console.log(`\nOutput: ${outFile}`);

} finally {
  fs.rmSync(workDir, { recursive: true, force: true });
}

// --- helpers ---

function resolveEsbuild(workDir) {
  // try global first
  try {
    const p = spawnSync('esbuild', ['--version'], { encoding: 'utf8' });
    if (p.status === 0) return 'esbuild';
  } catch (_) {}

  // install locally into workDir
  console.log('esbuild not found globally, installing locally ...');
  execSync('npm install esbuild', { cwd: workDir, stdio: 'inherit' });
  return path.join(workDir, 'node_modules', '.bin', 'esbuild');
}

function resolveEntry(base) {
  const candidates = [base, `${base}.js`, `${base}.cjs`, path.join(base, 'index.js')];
  for (const c of candidates) {
    if (fs.existsSync(c) && fs.statSync(c).isFile()) return c;
  }
  return null;
}

function resolveInstalledPkgJson(workDir, hint) {
  // try direct name
  const direct = path.join(workDir, 'node_modules', hint, 'package.json');
  if (fs.existsSync(direct)) return JSON.parse(fs.readFileSync(direct, 'utf8'));

  // scan node_modules for a matching folder
  const nm = path.join(workDir, 'node_modules');
  for (const dir of fs.readdirSync(nm)) {
    if (dir.startsWith('.') || dir.startsWith('@')) continue;
    if (dir.toLowerCase() === hint.toLowerCase()) {
      const p = path.join(nm, dir, 'package.json');
      if (fs.existsSync(p)) return JSON.parse(fs.readFileSync(p, 'utf8'));
    }
  }

  // scoped packages (@scope/name) - not needed here but just in case
  throw new Error(`Could not locate installed package.json for "${hint}" in ${nm}`);
}