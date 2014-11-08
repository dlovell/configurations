#!/usr/bin/env bash
set -eu


BUNDLE_DIR=~/.vim/bundle
VIMRC=~/.vimrc


function install_syntastic_for_tagbar {
	TAGBAR_URL=https://github.com/majutsushi/tagbar


	mkdir -p $BUNDLE_DIR && cd $BUNDLE_DIR
	git clone $TAGBAR_URL

#	brew install ctags
#	echo "
#\" use brew's ctags
#let g:tagbar_ctags_bin='/usr/local/bin/ctags'
#" >> $VIMRC

	sudo apt-get install exuberant-ctags
	echo "
\" use exuberant ctags
let g:tagbar_ctags_bin='/usr/bin/ctags-exuberant'
" >> $VIMRC

}


install_syntastic_for_pathogen
