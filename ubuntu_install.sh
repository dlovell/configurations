#!/usr/bin/env bash


# test for root
if [[ "$USER" != "root" ]]; then
    echo "$0 must be executed as root"
    exit;
fi


function apt_get_install {
	# system monitoring tools
	apt-get install -y htop nmon sysstat

	# support tools
	apt-get install -y screen sshfs ack-grep # xclip
	apt-get install -y --force-yes vim-nox tmux

	# ssh server
	apt-get install -y openssh-server

	# code/package helpers
	apt-get install -y git
}

function configure_sshd {
	if [[ -z $(grep ^Password /etc/ssh/ssh_config) ]]; then
		sudo perl -i.bak -pe 's/^#\s+(Password.*)/$1/' /etc/ssh/ssh_config
	fi
	/etc/init.d/ssh restart
}


apt-get update
apt_get_install
configure_sshd
