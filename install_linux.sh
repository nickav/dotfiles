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
	# config/omarchy is skipped here since ~/.config/omarchy is a real,
	# Omarchy-managed directory with content beyond dotfiles; only specific
	# pieces of it (e.g. custom themes) are symlinked individually below.
	for f in config/*/; do
		name=`basename "$f"`;
		if [ "$name" == "omarchy" ]; then continue; fi;
		target="$HOME/.config/$name";

		if [ -e "$target" -o -L "$target" ] && [ ! -L "$target" ]; then
			cmd cp -r "$target" ~/.backup/config/$name;
		fi

		cmd rm -rf "$target";
		cmd ln -sf "$dir/$f" "$target";
	done
	unset f;

	# Symlink custom Omarchy themes tracked in dotfiles into the live
	# themes directory, without touching the rest of ~/.config/omarchy.
	mkdir -p ~/.config/omarchy/themes;
	for f in config/omarchy/themes/*/; do
		name=`basename "$f"`;
		target="$HOME/.config/omarchy/themes/$name";

		if [ -e "$target" -o -L "$target" ] && [ ! -L "$target" ]; then
			mkdir -p ~/.backup/config/omarchy/themes;
			cmd cp -r "$target" ~/.backup/config/omarchy/themes/$name;
		fi

		cmd rm -rf "$target";
		cmd ln -sf "$dir/$f" "$target";
	done
	unset f;

	# Symlink shared dotfiles used by Omarchy's default ~/.bashrc.
	cmd ln -sf "$dir/.aliases" "$HOME/.aliases";
	cmd ln -sf "$dir/.linux" "$HOME/.linux";

	# Symlink global git config.
	cmd ln -sf "$dir/.gitconfig" "$HOME/.gitconfig";
	cmd ln -sf "$dir/.gitignore_global" "$HOME/.gitignore_global";

	# Wire ~/.linux into ~/.bashrc (Omarchy's default rc already sources
	# ~/.aliases the same way; this just extends that convention).
	if ! grep -q '~/.linux' "$HOME/.bashrc" 2>/dev/null; then
		if [ $print_only ]; then
			echo "append linux sourcing to $HOME/.bashrc";
		else
			printf '\n# Linux-only shell config from ~/dev/dotfiles\n[ -f ~/.linux ] && source ~/.linux\n' >> "$HOME/.bashrc";
		fi
	fi

	# Wire up sublime's own installer alongside the config/ symlinks.
	cmd ./sublime/install_linux.sh

	# Omarchy's nvim theme hook (lua/plugins/theme.lua) is a symlink to the
	# live theme file. It must be absolute (not relative) since config/nvim
	# is reached through the ~/.config/nvim symlink, so a relative target
	# would resolve against the repo path instead of $HOME. Recreate it
	# fresh here rather than trusting whatever got committed to git.
	if [ -d "config/nvim" ]; then
		cmd ln -sf "$HOME/.local/state/omarchy/current/theme/neovim.lua" "$dir/config/nvim/lua/plugins/theme.lua";
	fi

	# bindings.lua dofiles the altswitch plugin unconditionally, so it must
	# be installed for hyprctl reload to succeed on a fresh machine.
	cmd omarchy plugin add https://github.com/Pablo-Merino/omarchy-altswitch.git --enable --yes
}

if [ "$1" == "--print" -o "$1" == "-p" ]; then
	install true;
else
	install;
fi;
