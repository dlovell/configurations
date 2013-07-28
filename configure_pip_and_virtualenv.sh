#!/usr/bin/env bash


# modify .bashrc to know about workon (virtualenvwrapper)
cat -- >> ~/.bashrc <<EOF
export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh
EOF
