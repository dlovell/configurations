#!/usr/bin/env bash
set -eu


BUNDLE_DIR=~/.vim/bundle
VIMRC=~/.vimrc


function install_ale_for_pathogen {
	ALE_URL=https://github.com/w0rp/ale.git

	mkdir -p $BUNDLE_DIR && cd $BUNDLE_DIR
	git clone $ALE_URL
}


install_ale_for_pathogen
