const fs = require('fs');
const path = require('path');
const os = require('os');
const child_process = require('child_process');

const glob = require('glob');
const minimist = require('minimist');

/* */
// argument parsing
function parseArgs(args, defaults = {}, aliases = {}) {
  const argv = { ...defaults, ...minimist(args.slice(2)) };

  Object.entries(aliases).forEach(([k, v]) => {
    argv[v] = argv[v] || argv[k];
  });

  return argv;
}

/* */
// logging
const Color = {
  black: '\x1b[30m',
  red: '\x1b[31m',
  green: '\x1b[32m',
  yellow: '\x1b[33m',
  blue: '\x1b[34m',
  magenta: '\x1b[35m',
  cyan: '\x1b[36m',
  white: '\x1b[37m'
};

function paint(color = Color.white) {
  const reset = '\x1b[0m';
  return (...rest) => console.log(color, ...rest, reset);
}

/* */
// main
function main(platform) {
  const argv = parseArgs(
    process.argv,
    { verbose: true, preview: false },
    { v: 'verbose', p: 'preview' }
  );
  const dirs = ['.'].concat(platform);

  const log = argv.verbose ? paint(Color.yellow) : () => {};

  const home = os.homedir();

  paint(Color.green)('Home dir:', home);

  dirs.forEach(dir => {
    paint(Color.red)('dotfiles', dir);

    // get all dotfiles to install
    const rootPath = path.resolve(__dirname, dir);
    const globPath = path.join(rootPath, `dotfiles/**`);
    const dotfiles = glob.sync(globPath, { nodir: true });

    dotfiles.forEach(src => {
      const dotfileName = path.basename(src);
      const dest = path.join(
        home,
        dotfileName.startsWith('.') ? dotfileName : `.${dotfileName}`
      );

      log(src, '->', dest);

      if (argv.preview) {
        return;
      }

      fs.unlinkSync(dest);
      fs.symlinkSync(src, dest);
    });

    // run any install scripts
    const installScript = path.resolve(rootPath, 'install.sh');
    if (fs.existsSync(installScript)) {
      log(`Running install script...`);
      child_process.execSync(`chmod +x ${installScript}`);
      child_process.execSync(installScript, { stdio: 'inherit' });
    }

    const indexJs = path.resolve(rootPath, 'index.js');
    if (fs.existsSync(indexJs) && indexJs !== __filename) {
      log(`Executing index.js`);

      try {
        require(indexJs)(argv, { dotfiles, path: rootPath });
      } catch (err) {
        console.error(err);
      }
    }
  });
}

main(process.platform);
