#!/usr/bin/env bash
set -eu


BUNDLE_DIR=~/.vim/bundle
VIMRC=~/.vimrc


function install_tagbar_for_pathogen {
	TAGBAR_URL=https://github.com/majutsushi/tagbar


	mkdir -p $BUNDLE_DIR && cd $BUNDLE_DIR
	git clone $TAGBAR_URL
	sudo yum install --assumeyes ctags

\" use exuberant ctags
let g:tagbar_ctags_bin='/usr/bin/ctags'
" >> $VIMRC
	fi

}


install_tagbar_for_pathogen
