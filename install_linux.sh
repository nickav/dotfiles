#!/usr/bin/env bash
cd "$(dirname "${BASH_SOURCE}")";

# Run a command, or just print it if print_only is set.
function cmd() {
	if [ $print_only ]; then
		echo "$@";
	else
		"$@";
	fi
}

function install() {
	print_only="$1";
	dir=`pwd`;
	echo $dir;
	mkdir -p ~/.backup/config;
	mkdir -p ~/.config;

	# Symlink each app folder under config/ to ~/.config/<name>, mirroring
	# XDG layout. Back up any existing real directory first.
	for f in config/*/; do
		name=`basename "$f"`;
		target="$HOME/.config/$name";

		if [ -e "$target" -o -L "$target" ] && [ ! -L "$target" ]; then
			cmd cp -r "$target" ~/.backup/config/$name;
		fi

		cmd rm -rf "$target";
		cmd ln -sf "$dir/$f" "$target";
	done
	unset f;

	# Wire up sublime's own installer alongside the config/ symlinks.
	cmd ./sublime/install_linux.sh

	# bindings.lua dofiles the altswitch plugin unconditionally, so it must
	# be installed for hyprctl reload to succeed on a fresh machine.
	cmd omarchy plugin add https://github.com/Pablo-Merino/omarchy-altswitch.git --enable --yes

	# Omarchy's nvim theme hook (lua/plugins/theme.lua) is a symlink to the
	# live theme file. It must be absolute (not relative) since config/nvim
	# is reached through the ~/.config/nvim symlink, so a relative target
	# would resolve against the repo path instead of $HOME. Recreate it
	# fresh here rather than trusting whatever got committed to git.
	if [ -d "config/nvim" ]; then
		cmd ln -sf "$HOME/.local/state/omarchy/current/theme/neovim.lua" "$dir/config/nvim/lua/plugins/theme.lua";
	fi
}

if [ "$1" == "--print" -o "$1" == "-p" ]; then
	install true;
else
	install;
fi;
