#!/bin/sh
env='unknown'
uname=$(uname)
case $uname in 
	Darwin)
		env='mac' ;;
	Linux)
		env='linux' ;;
	*) echo 'Unknown environment $env!'
esac
set ENV=$env
echo Setting up $env environment...

if [ "$env" == 'mac' ]; then
	which brew || ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)";
elif [ "$env" == 'linux' ]; then
	echo LINUX
	if [ ! $(which apt-get) -z ]; then
		echo 'hello!'
	fi
fi


#sudo $(PKG_MGR) install chromium-browser -y
#sudo apt-get install vim -y
#sudo apt-get install tmux -y
#sudo apt-get install git-core bash-completion -y

#git clone SIMPLE_BASH -- scripts

#vi 

chmod +x git-publish git-completion.sh

for f in .*; do
	if [ "$f" != "." ] && [ "$f" != ".." ] && [ "$f" != ".git" ]; then
		echo $f;
		#ln -s $f ../$f
	fi
done
