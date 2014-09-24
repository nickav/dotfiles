#!/usr/bin/env bash
cd "$(dirname "${BASH_SOURCE}")";

#git pull origin master;

function install() {
	print_only="$1";
	dir=`pwd`;
	echo $dir;
	for f in .*; do
		if [ $f != "." ] && [ $f != ".." ] && [ $f != ".git" ] && [ $f != ".gitignore" ] && [[ $f != *.swp ]]; then
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

	# install some stuff from git
	if [ ! -d ~/bin/j2/ ]; then
		git clone https://github.com/rupa/j2 ~/bin/j2
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

