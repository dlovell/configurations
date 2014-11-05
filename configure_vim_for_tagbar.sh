#!/usr/bin/env bash
set -eu


BUNDLE_DIR=~/.vim/bundle
VIMRC=~/.vimrc


function install_syntastic_for_tagbar {
	TAGBAR_URL=https://github.com/majutsushi/tagbar

	# try a different ctags
	brew install ctags

	mkdir -p $BUNDLE_DIR && cd $BUNDLE_DIR
	git clone $TAGBAR_URL

	echo "
\" use brew's ctags
let g:tagbar_ctags_bin='/usr/local/bin/ctags'
" >> $VIMRC

}


install_syntastic_for_pathogen
