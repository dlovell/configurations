#!/usr/bin/env bash
set -eu


BUNDLE_DIR=~/.vim/bundle
VIMRC=~/.vimrc
ENV_NAME=_vim


function install_syntastic_for_pathogen {
	# FIXME: needs a check for conda and appropriate action if not installed
	# requires: conda install flake8
	SYNTASTIC_URL=https://github.com/scrooloose/syntastic.git

	mkdir -p $BUNDLE_DIR && cd $BUNDLE_DIR
	git clone $SYNTASTIC_URL

	if [[ -z $(conda list --name $ENV_NAME 2>/dev/null) ]]; then
		conda create --name $ENV_NAME flake8 --yes --quiet
	fi
	WHICH_FLAKE8=$(source activate $ENV_NAME && which flake8)
	echo "
\" speed up after write by only using flake8 by default
let syntastic_python_checkers = ['flake8']
let syntastic_python_flake8_exec = '$WHICH_FLAKE8'
" >> $VIMRC
}


install_syntastic_for_pathogen
