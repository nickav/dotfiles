#
# .bashrc is run everytime a new shell window is opened
#
alias sudo='sudo '
alias sshre='ssh -R 52698:localhost:52698'
alias umd='ssh nja23@grace4.umd.edu'
alias corn='ssh u74859473@s495483029.onlinehome.us'
alias cornsync='cd ~/www/kickstart/sites/all/themes/stevencorn/ && lsync $stevencorn'
alias g='git'
alias gs='git status'
alias gc='git checkout'
alias gd='git diff'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias lock='chflags uchg'
alias unlock='chflags nouchg'
alias tma='tmux attach -d -t'
alias tmn='tmux new -s'
alias ls='ls -G'
alias la='ls -al'
alias lsa='ls -a'
alias ll='ls -l'
alias l='ls'
alias e='exit'
alias v='vi'
export login='/Users/Nick/Library/Preferences/loginwindow.plist'
alias oc='exec rlwrap /usr/local/bin/ocaml "$@"'
alias db='/Users/Nick/bin/Dropbox-Uploader/dropbox_uploader.sh'
alias my='sudo mysqld_safe'
alias lsync='. ~/bin/lsync.sh'

# vars
stevencorn='u74859473@s495483029.onlinehome.us:/kunden/homepages/33/d495483010/htdocs/sites/all/themes/stevencorn'
ball='/Users/Nick/Apps/Ball/Ball'

# functions
function tm () {
	if [ "$1" ]; then	
		tmux attach -d -t "$1" || tmux new -s "$1"
	else
		tmux attach -d || tmux new -s play
	fi
}

# Source a git completion script
if [ -f ~/bin/git-completion.sh ]; then
       . ~/bin/git-completion.sh
else
  echo "Could not find git completion script"
fi

# Git branch
function parse_git_branch () {
       git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ \1/'
}

# Cocos2D-X environment vars
export COCOS2DX_ROOT=/Users/Nick/cocos2d-x/cocos2d-x-2.2.2/
export ANDROID_SDK_ROOT=/Android/android-sdk-mac
export NDK_ROOT=/Android/android-ndk-r9c/
export NDK_TOOLCHAIN_VERSION=4.8
export ANDROID_HOME=$ANDROID_SDK_ROOT
PATH=$PATH:$ANDROID_SDK_ROOT/tools:$ANDROID_SDK_ROOT/platform-tools

# Prompt styling
RED="\[\033[0;31m\]"
YELLOW="\[\033[0;33m\]"
GREEN="\[\033[0;32m\]"
NO_COLOR="\[\033[0m\]"

PS1="$GREEN\u$NO_COLOR:\w$YELLOW\$(parse_git_branch)$NO_COLOR\$ "
#PS1="\u$NO_COLOR:\w$YELLOW\$(parse_git_branch) $NO_COLOR\$ "

# unbind C-s & C-q
bind -r '\C-s'
stty -ixon
# map C-k to Up
#bind "'\C-k':'\e[A'"

# vi-style navigation
set -o vi
bind "Control-J":vi-movement-mode

# remove files from tab auto-completion
export FIGNORE=DS_Store
# default editor for tmuxinator
export EDITOR='vim'

# auto start tmux
#[[ $TERM != "screen" ]] && { tmux attach || tmux new -s play && exit 0; }

#if [ $TERM != "screen-256color" ] && [  $TERM != "screen" ]; then
#	tmux attach || tmux new -s play && exit 0;
#fi

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
