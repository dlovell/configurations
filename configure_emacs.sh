#!/usr/bin/env bash


# configure
cat >> ~/.emacs <<EOF
(global-set-key (kbd "C-c C-r") 'python-send-region)
(global-set-key (kbd "C-c C-g") 'python-send-region-and-go)
(global-set-key (kbd "C-c C-z") 'python-swithc-to-python)
(global-set-key (kbd "C-c C-c") 'python-send-buffer)
EOF
