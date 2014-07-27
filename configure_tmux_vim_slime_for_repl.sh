#!/usr/bin/env bash


function configure_vim_for_pathogen {
	PATHOGEN_URL="https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim"
	AUTOLOAD_DIR=~/vim/autload
	# set up pathogem.vim
	mkdir -p $AUTOLOAD_DIR
	wget -O ${AUTOLOAD_DIR}/pathogen.vim "${PATHOGEN_URL}"
	cat >> ~/.vimrc <<EOF
execute pathogen#infect()
EOF

}

function install_vim_slime {
	VIM_SLIME_URL="git://github.com/jpalardy/vim-slime.git"
	BUNDLE_DIR=~/.vim/bundle
	PYTHON_SLIME_VIM=~/.vim/bundle/vim-slime/ftplugin/python/slime.vim

	# install vim-slime via pathogen
	mkdir -p $BUNDLE_DIR
	cd $BUNDLE_DIR
	git clone $VIM_SLIME_URL
	# correct the python slime.vim
	perl -i.orig -pe 's/substitute\(a:text.*/a:text/' $PYTHON_SLIME_VIM

	# use tmux for slime
	cat >> ~/.vimrc <<EOF
let g:slime_target = "tmux"
EOF

}


configure_vim_for_pathogen
install_vim_slime
