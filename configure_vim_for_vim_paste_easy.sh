#!/usr/bin/env bash
set -eu


BUNDLE_DIR=~/.vim/bundle
VIMRC=~/.vimrc


function install_vim_paste_easy {
	# FIXME: needs a check for conda and appropriate action if not installed
	# requires: conda install flake8
	VIM_PASTE_EASY=https://github.com/roxma/vim-paste-easy

	mkdir -p $BUNDLE_DIR && cd $BUNDLE_DIR
	git clone $VIM_PASTE_EASY
}


install_vim_paste_easy
