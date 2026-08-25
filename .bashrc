#
# .bashrc is run everytime a new shell window is opened
#

# per-device overrides not checked into source control
[ -f ~/.extra ] && source ~/.extra

alias sudo='sudo '
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# enable full color on tmux
TERM=xterm-256color

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

# remove files from tab auto-completion
export FIGNORE=DS_Store;
# default editor for tmuxinator
export EDITOR='vim';
export GREP_OPTIONS="--color=auto";

# linux-only overrides (see .linux)
[ "$(uname)" = "Linux" ] && [ -f ~/.linux ] && source ~/.linux

# larger bash history (default 500)
export HISTSIZE=2048;
export HISTFILESIZE=$HISTSIZE;
export HISTCONTROL=ignoredups;

PATH=$PATH:$HOME/.rvm/bin
PATH=$PATH:"$(yarn global bin)/node_modules/.bin"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

PROMPT_COMMAND='echo -ne "\033]0;\007" && [ ! -z $TMUX ] && tmux set -g set-titles-string ""'

# dont exclude hidden files
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'

PATH=$PATH:$HOME/bin

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

export PATH="$HOME/dev/_lib/Odin:$PATH"

