#!/usr/bin/env bash
set -eu


BUNDLE_DIR=~/.vim/bundle


function install_typescript_vim_for_pathogen {
	TYPESCRIPT_VIM_URL=https://github.com/leafgarland/typescript-vim

	mkdir -p $BUNDLE_DIR && cd $BUNDLE_DIR
	git clone $TYPESCRIPT_VIM_URL
}


install_typescript_vim_for_pathogen
