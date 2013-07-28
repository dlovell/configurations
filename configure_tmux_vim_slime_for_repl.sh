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

# configure tmux
cat >> ~/.tmux.conf <<EOF
# ##############################################################
# Global settings.
#

# Switch the prefix to Ctrl-a since Ctrl-b interferes with Vim.
set -g prefix C-a
unbind C-b

# Change the default input delay in order to improve Vim
# performance.
set -sg escape-time 1

# Number windows and panes starting at 1 so that we can jump to
# them easier.
set -g base-index 1
set -g pane-base-index 1

# vi mode.
set -g mode-keys vi
set -g status-keys vi

# 256-color mode.
set -g default-terminal "screen-256color"


# ##############################################################
# Key bindings.
#

# Reload .tmux.conf with "r".
bind r source-file ~/.tmux.conf \; display "Reloaded!"

# Split windows with a more visual set of characters.
bind | split-window -h
bind - split-window -v

# Select panes with vi-style movement commands.
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R

# Resize panes with vi-style movement commands.
bind -r H resize-pane -L 5
bind -r J resize-pane -D 5
bind -r K resize-pane -U 5
bind -r L resize-pane -R 5
EOF
