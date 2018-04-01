#!/usr/bin/env bash


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

# make sure you can still send Ctrl-a with 'Ctrl-a a'
bind a send-prefix


# ##############################################################
# Key bindings.
#

# Reload .tmux.conf with "r".
bind r source-file ~/.tmux.conf \; display "Reloaded!"

# Split windows with a more visual set of characters.
bind | split-window -h -c "#{pane_current_path}"
bind - split-window -v -c "#{pane_current_path}"
bind \ split-window -h -c "#{pane_current_path}"
bind _ split-window -v -c "#{pane_current_path}"

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

# enable clipboard interaction
# https://unix.stackexchange.com/a/70798
bind -t vi-copy y copy-pipe "xclip -sel clip -f | xclip -sel prim"
bind C-p run "xclip -o -sel clip | tmux load-buffer -; tmux paste-buffer"
bind C-P run "xclip -o -sel prim | tmux load-buffer -; tmux paste-buffer"
EOF

# make sure ~/.bashrc is loaded for tmux
cat >> ~/.bash_profile <<EOF
. ~/.bashrc
EOF
touch ~/.bashrc
