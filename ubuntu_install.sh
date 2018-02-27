#!/usr/bin/env bash


# test for root
if [[ "$USER" != "root" ]]; then
    echo "$0 must be executed as root"
    exit;
fi


SERVICES=(openssh-server)
SYSTEM_MONITORING=(htop nmon ncdu powertop cpufrequtils nmap)
SUPPORT=(sshfs xclip)
DEVELOPMENT=(git vim-nox tmux ccache)
GENERAL=(lynx pidgin libgnome2-bin tree gnome-tweak-tool)


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


function nopasswd_sudoers {
    # http://askubuntu.com/a/235264
    # `pkexec visudo -f /etc/sudoers.d/01_ubuntu_install`: graphical validation of password, somehow gets around malformed /etc/sudoers.d issues
    echo "$SUDO_USER ALL=NOPASSWD: /sbin/shutdown, /usr/sbin/powertop, /usr/sbin/pm-hibernate" | \
        sudo tee /etc/sudoers.d/01_ubuntu_install >/dev/null
}


apt-get update
apt-get dist-upgrade --yes
apt_get_install
customize_dconf
nopasswd_sudoers
