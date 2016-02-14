# Installs extensions 
#
help:
	@echo "install - install + compile native things."
	@echo "update  - Download update for all plugins."

install: symlink submodules

submodules:
	git submodule init
	git submodule update

update:
	git submodule foreach git pull origin master

symlink:
	ln -sf ~+/vimrc ~/.vimrc
