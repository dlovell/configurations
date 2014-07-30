#!/usr/bin/env bash


# test for root
if [[ "$USER" != "root" ]]; then
    echo "$0 must be executed as root"
    exit;
fi


ANACONDA_URL=http://repo.continuum.io/archive/Anaconda-2.0.1-Linux-x86_64.sh
MINICONDA_URL=http://repo.continuum.io/miniconda/Miniconda3-3.5.5-Linux-x86_64.sh
CONDA_URL=$MINICONDA_URL
WHICH_CONDA=$(basename $CONDA_URL)


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

function install_conda {
	CONDA_DEST=~/$WHICH_CONDA
	if [[ ! -f $CONDA_DEST ]]; then
		wget $CONDA_URL -O $CONDA_DEST
	fi
	bash $CONDA_DEST -b
	# get prefix
	source <(grep -m 1 ^PREFIX= $CONDA_DEST --binary-files=text)
	echo "
# added by Miniconda3 3.5.5 installer
export PATH=\"$PREFIX/bin:\$PATH\"" >>$HOME/.bashrc
}

funciton conda_install_things {
	conda install pip patchelf
}


apt-get update
apt_get_install
configure_sshd
install_conda
conda_install_things
