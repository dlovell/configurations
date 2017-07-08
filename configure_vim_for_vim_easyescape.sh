#!/usr/bin/env bash
set -eu


BUNDLE_DIR=~/.vim/bundle
VIMRC=~/.vimrc


function install_vim_easyescape {
	VIM_ESCAPEEASY=https://github.com/zhou13/vim-easyescape/

	mkdir -p $BUNDLE_DIR && cd $BUNDLE_DIR
	git clone $VIM_ESCAPEEASY
	echo "
let g:easyescape_chars = {'j': 1, 'k': 1}
let g:easyescape_timeout = 100
cnoremap kj <esc>
" >> $VIMRC
}


install_vim_easyescape
