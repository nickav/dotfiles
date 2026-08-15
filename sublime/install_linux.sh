#!/usr/bin/env bash
cwd="$(cd "$(dirname "$0")" && pwd -P)"
target="$HOME/.config/sublime-text/Packages/User"

echo $cwd

# Symlink the entire directory as Sublime's User package (mirrors install.sh's mac strategy).
rm -rf "$target"
ln -s "$cwd" "$target"
