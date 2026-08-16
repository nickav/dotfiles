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

	# Symlink custom bin scripts referenced by hypr bindings.lua (e.g.
	# SUPER+D's app-copy launcher) into ~/.local/bin, which is already on
	# PATH, so hyprctl can exec them by name.
	mkdir -p "$HOME/.local/bin";
	cmd ln -sf "$dir/bin/omarchy-launch-focused-app-copy" "$HOME/.local/bin/omarchy-launch-focused-app-copy";
	cmd ln -sf "$dir/bin/omarchy-prewarm-browser" "$HOME/.local/bin/omarchy-prewarm-browser";
	cmd ln -sf "$dir/bin/omarchy-power-profile-watch" "$HOME/.local/bin/omarchy-power-profile-watch";
	cmd ln -sf "$dir/bin/omarchy-ghostty-config-watch" "$HOME/.local/bin/omarchy-ghostty-config-watch";

	# Auto-switch power-profiles-daemon profile on AC plug/unplug and low battery,
	# and auto-reload Ghostty's config on save (needs inotify-tools).
	mkdir -p "$HOME/.config/systemd/user";
	cmd ln -sf "$dir/systemd/omarchy-power-profile-watch.service" "$HOME/.config/systemd/user/omarchy-power-profile-watch.service";
	cmd ln -sf "$dir/systemd/omarchy-ghostty-config-watch.service" "$HOME/.config/systemd/user/omarchy-ghostty-config-watch.service";
	cmd systemctl --user daemon-reload;
	cmd systemctl --user enable --now omarchy-power-profile-watch.service;
	cmd systemctl --user enable --now omarchy-ghostty-config-watch.service;

	# Wire up sublime's own installer alongside the config/ symlinks.
	cmd ./sublime/install_linux.sh

	# NOTE: ~/.local/share/applications/sublime_text.desktop is a manual,
	# untracked override (Exec uses `subl --new-window %F`) so launching
	# Sublime from the app menu always opens a new window instead of just
	# focusing the single running instance. Not symlinked from this repo -
	# recreate it by hand on a fresh machine if that behavior is wanted.

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
