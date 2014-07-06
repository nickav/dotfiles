#
# .bash_profile only runs on each login
#

export PATH=~/bin:$PATH
export PATH=$PATH:/usr/local/mysql/bin
export PATH=/usr/local/opt/ruby/bin:$PATH
export PATH=/usr/local/bin:$PATH

# load bashrc
if [ -f ~/.bashrc ]; then
	source ~/.bashrc
fi

# load shell dotfiles
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{exports,extra,aliases,bash_aliases,functions}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Add tab completion for many Bash commands
if which brew > /dev/null && [ -f "$(brew --prefix)/etc/bash_completion" ]; then
	source "$(brew --prefix)/etc/bash_completion";
elif [ -f /etc/bash_completion ]; then
	source /etc/bash_completion;
fi;

# Enable tab completion for `g` by marking it as an alias for `git`
if type _git &> /dev/null && [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
	complete -o default -o nospace -F _gitg;
fi;

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2 | tr ' ' '\n')" scp sftp ssh;


[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# install j2, awesome replacement for cd
export JPY=~/bin/j2/j.py
if [ -f ~/bin/j2/j.sh ]; then
	. ~/bin/j2/j.sh 
fi
