#!/usr/bin/env bash
set -eu


BUNDLE_DIR=~/.vim/bundle
VIMRC=~/.vimrc
ENV_NAME=_vim
export PATH="$(dirname $(bash -ic 'which conda')):$PATH"


function install_flake8_for_pathogen {
	# requires: conda install flake8
	FLAKE8_URL=https://github.com/nvie/vim-flake8

	mkdir -p $BUNDLE_DIR && cd $BUNDLE_DIR
	git clone $FLAKE8_URL

	conda create --yes --name $ENV_NAME flake8
	set +u
	WHICH_FLAKE8=$(source activate $ENV_NAME && which flake8)
	set -u
	cat >> $VIMRC <<EOF

" configure_vim_for_flake8.sh
let g:flake8_cmd="$WHICH_FLAKE8"
autocmd BufWritePost *.py call Flake8()
EOF
}


install_flake8_for_pathogen
