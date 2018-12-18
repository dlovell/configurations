#!/usr/bin/env bash
set -eu


BUNDLE_DIR=~/.vim/bundle
VIMRC=~/.vimrc


function install_rustvim {
	RUSTVIM_URL=https://github.com/rust-lang/rust.vim

	mkdir -p $BUNDLE_DIR && cd $BUNDLE_DIR
	git clone $RUSTVIM_URL

	cat >> $VIMRC <<EOF

" configure_vim_for_rust.sh
let g:syntastic_rust_checkers = ['rustc']
EOF
}


install_rustvim
