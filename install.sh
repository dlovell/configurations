#!/usr/bin/env bash


# test for root
if [[ "$USER" != "root" ]]; then
    echo "$0 must be executed as root"
    exit;
fi


# update
apt-get update

# system monitoring tools
apt-get install -y htop nmon sysstat

# support tools
apt-get install -y screen sshfs ack-grep # xclip
apt-get install -y --force-yes vim-nox tmux
# USER: bash configure_tmux_vim_slime_for_repl.sh
# USER: bash configure_vim_for_python.sh

# ssh server
apt-get install -y openssh-server
if [[ -z $(grep ^Password /etc/ssh/ssh_config) ]]; then
	sudo perl -i.bak -pe 's/^#\s+(Password.*)/$1/' /etc/ssh/ssh_config
fi
/etc/init.d/ssh restart

# code/package helpers
apt-get install -y git python-pip
# USER: bash configure_git.sh
