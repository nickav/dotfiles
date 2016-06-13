#
# .bashrc is run everytime a new shell window is opened
#
alias sudo='sudo '
alias wh='echo 60DcD9c1ka'
alias g='git'
alias gs='git status'
alias gc='git checkout'
alias gd='git diff'
# navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias -- -="cd -"
# mac
alias lock='chflags uchg'
alias unlock='chflags nouchg'
export login='/Users/Nick/Library/Preferences/loginwindow.plist'
alias lsync='. ~/bin/lsync.sh'
# command aliases
alias tma='tmux attach -d -t'
alias tmn='tmux new -s'
# Detect which `ls` flavor is in use
if ls --color > /dev/null 2>&1; then # GNU `ls`
	colorflag="--color"
else # OS X `ls`
	colorflag="-G"
fi
alias ls='ls ${colorflag}'
alias la='ls -al'
alias lsa='ls -a'
alias ll='ls -l'
alias l='ls'
alias e='exit'
alias v='vi'
alias h="history"
alias oc='exec rlwrap /usr/local/bin/ocaml "$@"'
alias db='~/bin/Dropbox-Uploader/dropbox_uploader.sh'
alias my='sudo mysqld_safe'
alias mroe='more'
alias artisan='php artisan'
alias rocketeer='php vendor/bin/rocketeer'
alias crontab="VIM_CRONTAB=true crontab"
# stopwatch
alias timer='echo "Timer started. Stop with Ctrl-D." && date && time cat && date'
# Get OS X Software Updates, and update installed Ruby gems, Homebrew, npm, and their installed packages
alias update='sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup; npm update npm -g; npm update -g; sudo gem update --system; sudo gem update'
# folder shortcuts
alias d="cd ~/Documents"
alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"
alias dev="cd ~/dev"
# OS X has no md5sum, use md5 as fallback
command -v md5sum > /dev/null || alias md5sum="md5"
command -v sha1sum > /dev/null || alias sha1sum="shasum"
# recursively delete .DS_Store
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"
# Empty the Trash on all mounted volumes and the main HDD
# Also, clear Apple’s System Logs to improve shell startup speed
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl"

# One of @janmoesen’s ProTips
for method in GET HEAD POST PUT DELETE TRACE OPTIONS; do
	alias "$method"="lwp-request -m '$method'"
done

alias rtun='reattach-to-user-namespace' 
alias rtn='reattach-to-user-namespace' 

# functions
function tm () {
	if [ "$1" ]; then	
		tmux attach -d -t "$1" || tmux new -s "$1"
	else
		#if [ ~/.tmux-session -e ]; then 
			#tmux-session restore
			#rm ~/.tmux-session
		#else
			tmux attach -d || tmux new -s dev
		#fi
	fi
}
# enable full color on tmux
TERM=xterm-256color

function s() { 
	q="$@"
	open /Applications/Google\ Chrome.app/ "http://www.google.com/search?q=$q";
}

if [ -f $(brew --prefix)/etc/bash_completion ]; then
	. $(brew --prefix)/etc/bash_completion
fi

# Source a git completion script
if [ -f ~/bin/git-completion.sh ]; then
	. ~/bin/git-completion.sh
fi

# only need to tab once
bind 'set show-all-if-ambiguous on'

# Git branch
function parse_git_branch () {
       git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ \1/'
}

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
export FIGNORE=DS_Store;
# default editor for tmuxinator
export EDITOR='vim';
export GREP_OPTIONS="--color=auto";

# larger bash history (default 500)
export HISTSIZE=2048;
export HISTFILESIZE=$HISTSIZE;
export HISTCONTROL=ignoredups;

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
PATH=$PATH:$(npm config get prefix)/bin
