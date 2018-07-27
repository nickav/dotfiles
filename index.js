const fs = require('fs');
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

  dirs.forEach(dir => {
    // get all dotfiles to install
    const dotfiles = glob.sync(`${dir}/dotfiles/**`, { nodir: true });
    log(dotfiles);

    if (!argv.preview) {
      //dotfiles.forEach(dot => fs.symlinkSync(dot, ))
    }
  });
}

main(process.platform);
