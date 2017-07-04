#!/usr/bin/env bash
set -eu


BUNDLE_DIR=~/.vim/bundle


function install_vim_slime_for_pathogen {
	VIM_SLIME_URL="https://github.com/dlovell/vim-slime"

	mkdir -p $BUNDLE_DIR && cd $BUNDLE_DIR
	git clone $VIM_SLIME_URL && cd $(basename $VIM_SLIME_URL) && git checkout develop

	# use tmux for slime
	cat >> ~/.vimrc <<EOF
let g:slime_target = "tmux"
let g:slime_python_ipython = 1
" backslash-e sends text to tmux
xmap <leader>e <Plug>SlimeRegionSend
nmap <leader>e <Plug>SlimeParagraphSend
"
function! SlimeRegionSendNoCpaste() range
    " https://stackoverflow.com/a/18547013
    if exists('g:slime_python_ipython')
        unlet g:slime_python_ipython
        execute "normal \<Plug>SlimeRegionSend"
        let g:slime_python_ipython=1
    else
        execute "normal \<Plug>SlimeRegionSend"
    end
endfunction
"
xmap <leader>r :call SlimeRegionSendNoCpaste()<esc>
EOF
}


install_vim_slime_for_pathogen
