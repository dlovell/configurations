#!/usr/bin/env bash
set -eu


BUNDLE_DIR=~/.vim/bundle


function install_vim_slime_for_pathogen {
	VIM_SLIME_URL="https://github.com/jpalardy/vim-slime.git"

	mkdir -p $BUNDLE_DIR && cd $BUNDLE_DIR
	git clone $VIM_SLIME_URL

	# use tmux for slime
	cat >> ~/.vimrc <<EOF
let g:slime_target = "tmux"
let g:slime_python_ipython = 1
EOF
}

function fixup_slime_dot_vim {
	# correct the python slime.vim
	PYTHON_SLIME_VIM=~/.vim/bundle/vim-slime/ftplugin/python/slime.vim
	perl -i.orig -pe 's/substitute\(a:text.*/a:text/' $PYTHON_SLIME_VIM
}


install_vim_slime_for_pathogen
fixup_slime_dot_vim
