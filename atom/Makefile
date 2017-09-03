all: link install

install:
	apm install --packages-file package-list.txt

update:
	apm list --installed --bare > package-list.txt

link:
	ln -sf `pwd`/keymap.cson ~/.atom/keymap.cson
