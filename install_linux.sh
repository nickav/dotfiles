#!/usr/bin/env bash
cd "$(dirname "${BASH_SOURCE}")";

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

		if [ -e "$target" -o -L "$target" ]; then
			if [ ! -L "$target" ]; then
				if [ $print_only ]; then
					echo "cp -r $target ~/.backup/config/$name";
				else
					cp -r "$target" ~/.backup/config/$name;
				fi
			fi
		fi

		if [ $print_only ]; then
			echo "ln -sf $dir/$f $target";
		else
			rm -rf "$target";
			ln -sf "$dir/$f" "$target";
		fi
	done
	unset f;

	# Wire up sublime's own installer alongside the config/ symlinks.
	if [ $print_only ]; then
		echo "./sublime/install_linux.sh"
	else
		./sublime/install_linux.sh
	fi

	# Omarchy's nvim theme hook (lua/plugins/theme.lua) is a symlink to the
	# live theme file. It must be absolute (not relative) since config/nvim
	# is reached through the ~/.config/nvim symlink, so a relative target
	# would resolve against the repo path instead of $HOME. Recreate it
	# fresh here rather than trusting whatever got committed to git.
	if [ -d "config/nvim" ]; then
		if [ $print_only ]; then
			echo "ln -sf $HOME/.local/state/omarchy/current/theme/neovim.lua $dir/config/nvim/lua/plugins/theme.lua";
		else
			ln -sf "$HOME/.local/state/omarchy/current/theme/neovim.lua" "$dir/config/nvim/lua/plugins/theme.lua";
		fi
	fi
}

if [ "$1" == "--print" -o "$1" == "-p" ]; then
	install true;
else
	install;
fi;
