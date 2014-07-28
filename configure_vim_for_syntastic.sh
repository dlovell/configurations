#!/usr/bin/env bash
set -eu


BUNDLE_DIR=~/.vim/bundle


function install_syntastic_for_pathogen {
	# requires: conda install flake8
	SYNTASTIC_URL=https://github.com/scrooloose/syntastic.git

	mkdir -p $BUNDLE_DIR && cd $BUNDLE_DIR
	git clone $SYNTASTIC_URL
}


install_syntastic_for_pathogen
