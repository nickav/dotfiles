all: link install

install:
	more extensions.list | xargs -L 1 code --install-extension

update:
	code --list-extensions > extensions.list

link:
	ln -sf `pwd`/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json
	ln -sf `pwd`/settings.json ~/Library/Application\ Support/Code/User/settings.json
