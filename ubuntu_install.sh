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

}


apt-get update
apt-get dist-upgrade
apt_get_install
