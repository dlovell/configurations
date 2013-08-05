#!/usr/bin/env bash


# test for root
if [[ "$USER" != "root" ]]; then
    echo "$0 must be executed as root"
    exit;
fi


# update
apt-get update
apt-get update

# system monitoring tools
apt-get install -y htop nmon sysstat

# support tools
apt-get install -y screen sshfs xclip

# build tools
apt-get install -y g++ make

# ssh server
apt-get install -y openssh-server
if [[ -z $(grep ^Password /etc/ssh/ssh_config) ]]; then
	sudo perl -i.bak -pe 's/^#\s+(Password.*)/$1/' /etc/ssh/ssh_config
fi
/etc/init.d/ssh restart

# emacs setup
apt-get install -y emacs23
# USER: bash configure_emacs.sh

# git setup
apt-get install -y git
# USER: bash configure_git.sh

# pip, virtualenv, virtualenvwrapper
wget -O - https://raw.github.com/pypa/pip/master/contrib/get-pip.py | python
source ~/.bashrc
pip install virtualenv==1.10
pip install virtualenvwrapper==3.6
# USER: bash configure_pip_and_virtualenv.sh

# install vim, tmux
apt-get install -y --force-yes vim-nox tmux
# USER: bash configure_tmux_vim_slime_for_repl.sh

# quant tools
sudo apt-get build-dep -y python-numpy python-matplotlib python-scipy
