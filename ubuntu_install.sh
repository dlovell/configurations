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
GENERAL=(lynx, pidgin)


function apt_get_install {

    apt-get install --yes \
        ${SERVICES[*]} \
        ${SYSTEM_MONITORING[*]} \
        ${SUPPORT[*]} \
        ${DEVELOPMENT[*]} \
        ${GENERAL[*]} \

}


function customize_dconf {
    # http://askubuntu.com/a/337210
    # set to Disabled
    dconf write /org/compiz/integrated/show-hud '[""]'
}


apt-get update
apt-get dist-upgrade
apt_get_install
customize_dconf
