#!/usr/bin/env bash
cd "$(dirname "${BASH_SOURCE}")";

#git pull origin master;

function install() {
	print_only="$1";
	dir=`pwd`;
	echo $dir;
	mkdir ~/.backup;
	for f in .*; do
		if [ $f != "." ] && [ $f != ".." ] && [ $f != ".git" ] && [ $f != ".gitignore" ] && [[ $f != *.swp ]]; then
			# backup existing files
			if [ $HOME/$f -f ]; then
				cp $HOME/$f ~/.backup/$f;
			fi

			if [ $print_only ]; then
				echo "ln -sf $dir/$f $HOME/$f";
			else
				ln -sf $dir/$f $HOME/$f;
			fi
		fi 
	done

	mkdir -p ~/bin

	for f in bin/*; do
		if [ $print_only ]; then
			echo "ln -sf $dir/$f $HOME/$f"
		else
			ln -sf $dir/$f $HOME/$f
		fi
	done
	unset f;

	mkdir ~/.tmp
	touch ~/.extra
	touch ~/.vimrc.local
	touch ~/.tmux.conf.local

	if [ "$(uname)" == "Darwin" ]; then
		ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
		brew bundle
	else
		apt-get install silversearcher-ag
	fi
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	install;
elif [ "$1" == "--sandbox" -o "$1" == "-s" ]; then
	install false;
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		install;
	fi;
fi;

