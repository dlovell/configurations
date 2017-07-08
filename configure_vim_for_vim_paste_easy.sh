#!/usr/bin/env bash
set -eu


BUNDLE_DIR=~/.vim/bundle
VIMRC=~/.vimrc


function install_vim_paste_easy {
	VIM_PASTE_EASY=https://github.com/roxma/vim-paste-easy

	mkdir -p $BUNDLE_DIR && cd $BUNDLE_DIR
	git clone $VIM_PASTE_EASY
}


install_vim_paste_easy
