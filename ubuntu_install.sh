#!/usr/bin/env bash


# test for root
if [[ "$USER" != "root" ]]; then
    echo "$0 must be executed as root"
    exit;
fi


SERVICES=(openssh-server)
SYSTEM_MONITORING=(htop nmon ncdu powertop)
SUPPORT=(sshfs xclip)
DEVELOPMENT=(git vim-nox tmux ccache)


function apt_get_install {

    apt-get install --yes \
        ${SERVICES[*]} \
        ${SYSTEM_MONITORING[*]} \
        ${SUPPORT[*]} \
        ${DEVELOPMENT[*]}

}

# FIXME; does this really matter?  Its ssh_config, not sshd_config
function configure_sshd {
	if [[ -z $(grep ^Password /etc/ssh/ssh_config) ]]; then
		sudo perl -i.bak -pe 's/^#\s+(Password.*)/$1/' /etc/ssh/ssh_config
	fi
	/etc/init.d/ssh restart
}


apt-get update
apt-get dist-upgrade
apt_get_install
configure_sshd
