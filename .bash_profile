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
for file in ~/.{exports,extra,aliases,bash_aliases,functions,system}; do
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

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2 | tr ' ' '\n')" scp sftp ssh;

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

export PATH=/usr/local/Cellar:$PATH
