#!/usr/bin/env bash


PATHOGEN_URL="https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim"
VIM_SLIME_URL="git://github.com/jpalardy/vim-slime.git"

# set up pathogem.vim
mkdir -p ~/.vim/autoload
wget -O ~/.vim/autoload/pathogen.vim "${PATHOGEN_URL}"
cat >> ~/.vimrc <<EOF
execute pathogen#infect()
EOF

# install vim-slime via pathogen
mkdir -p ~/.vim/bundle
cd ~/.vim/bundle
git clone $VIM_SLIME_URL
# use tmux for slime
cat >> ~/.vimrc <<EOF
let g:slime_target = "tmux"
EOF

# correct the python slime.vim
perl -i.orig -pe 's/substitute\(a:text.*/a:text/' ~/.vim/bundle/vim-slime/ftplugin/python/slime.vim
