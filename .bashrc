#
# .bashrc is run everytime a new shell window is opened
#
alias sudo='sudo '
alias g='git'
alias gs='git status'
alias gc='git checkout'
alias gd='git diff'
# navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
# mac
alias lock='chflags uchg'
alias unlock='chflags nouchg'
export login='/Users/Nick/Library/Preferences/loginwindow.plist'
alias lsync='. ~/bin/lsync.sh'
# command aliases
alias tma='tmux attach -d -t'
alias tmn='tmux new -s'
alias la='ls -al'
alias lsa='ls -a'
alias ll='ls -l'
alias l='ls'
alias e='exit'
alias v='vi'
alias h="history"
alias db='~/bin/Dropbox-Uploader/dropbox_uploader.sh'
alias my='sudo mysqld_safe'
alias mroe='more'
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
		tmux attach -d || tmux new -s dev
	fi
}
# enable full color on tmux
TERM=xterm-256color

# quick google search
function s() {
	q="$@"
	open /Applications/Google\ Chrome.app/ "http://www.google.com/search?q=$q";
}

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

stty -ixon

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

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
