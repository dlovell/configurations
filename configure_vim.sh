#!/usr/bin/env bash
set -eu


VIMRC=~/.vimrc


function use_ftplugin {
	# Modifications to vim: using ftplugin per http://henry.precheur.org/vim/python
	FTPLUGIN_DIR=~/.vim/ftplugin
	mkdir -p $FTPLUGIN_DIR

	cat -- >> $VIMRC <<EOF
filetype plugin indent on
EOF
}

function use_pathogen {
	PATHOGEN_URL="https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim"
	AUTOLOAD_DIR=~/.vim/autoload
	# set up pathogem.vim
	mkdir -p $AUTOLOAD_DIR
	wget -O ${AUTOLOAD_DIR}/pathogen.vim "${PATHOGEN_URL}"
	cat >> $VIMRC <<EOF
execute pathogen#infect()
EOF

}

function mouse_controls_vim {
	# http://stackoverflow.com/a/12080433
	echo "
\" mouse controls vim
:set mouse=a" >> $VIMRC
}

function set_color_scheme {
	# https://unix.stackexchange.com/a/88880
	echo "
\" comments aren't dark blue
:color desert" >> $VIMRC
}

# # sometimes need to do this on windows box at JPMC?
# set backspace=2

use_ftplugin
use_pathogen
mouse_controls_vim
set_color_scheme
