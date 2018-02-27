#!/usr/bin/env bash
set -eu


BUNDLE_DIR=~/.vim/bundle
VIMRC=~/.vimrc


function install_tagbar_for_pathogen {
	TAGBAR_URL=https://github.com/majutsushi/tagbar


	mkdir -p $BUNDLE_DIR && cd $BUNDLE_DIR
	git clone $TAGBAR_URL

	if [[ ! -z $(uname | grep CYGWIN) ]]; then
		echo "Detected CYGWIN: Assuming ctags installed"
	elif [[ ! -z $(uname | grep Darwin) ]]; then
		echo "Detected Darwin: installing ctags via brew"
		brew install ctags
		echo "
\" use brew's ctags
let g:tagbar_ctags_bin='/usr/local/bin/ctags'
" >> $VIMRC
	elif [[ ! -z $(uname | grep Linux) ]]; then
		echo "Detected Linux: installing ctags via apt-get"
		sudo apt-get install exuberant-ctags
		echo "
\" use exuberant ctags
let g:tagbar_ctags_bin='/usr/bin/ctags-exuberant'
" >> $VIMRC
	fi

}


install_tagbar_for_pathogen
