#!/usr/bin/env bash


# test for root
if [[ "$USER" != "root" ]]; then
    echo "$0 must be executed as root"
    exit;
fi


# system monitoring tools
apt-get install -y htop nmon sysstat

# support tools
apt-get install -y screen sshfs xclip

# build tools
# apt-get install -y g++ make

# emacs setup
apt-get install -y emacs23
# USER: bash configure_emacs.sh

# git setup
apt-get install -y git
# USER: bash configure_git.sh

# pip, virtualenv, virtualenvwrapper
wget -O - https://raw.github.com/pypa/pip/master/contrib/get-pip.py | sudo python
source ~/.bashrc
pip install virtualenv==1.10
pip install virtualenvwrapper==3.6

# USER: bash configure_pip_and_virtualenv.sh

# install vim, tmux
apt-get install -y --force-yes vim-nox tmux
# USER: bash configure_tmux_vim_slime_for_repl.sh

# quant tools
sudo apt-get build-dep -y python-numpy python-matplotlib
# python-scipy?
