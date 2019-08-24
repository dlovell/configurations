#!/usr/bin/env bash


# test for root
if [[ "$USER" != "root" ]]; then
    echo "$0 must be executed as root"
    exit;
fi


SERVICES=(openssh-server)
SYSTEM_MONITORING=(htop nmon ncdu powertop cpufrequtils nmap)
SUPPORT=(sshfs xclip)
SYSTEMS=(gparted wget curl)
DEVELOPMENT=(git vim-nox tmux ccache stow)
GENERAL=(lynx pidgin libgnome2-bin tree gnome-tweak-tool pass gpg transmission)
# https://askubuntu.com/a/152369
SETTINGS=(compizconfig-settings-manager compiz-plugins)


function apt_get_install {

    apt-get install --yes \
        ${SERVICES[*]} \
        ${SYSTEM_MONITORING[*]} \
        ${SUPPORT[*]} \
        ${SYSTEMS[*]} \
        ${DEVELOPMENT[*]} \
        ${GENERAL[*]} \

}


function nopasswd_sudoers {
    # http://askubuntu.com/a/235264
    # `pkexec visudo -f /etc/sudoers.d/01_ubuntu_install`: graphical validation of password, somehow gets around malformed /etc/sudoers.d issues
    echo "$SUDO_USER ALL=NOPASSWD: /sbin/shutdown, /usr/sbin/pm-suspend, /usr/sbin/powertop, /usr/sbin/pm-hibernate" | \
        sudo tee /etc/sudoers.d/01_ubuntu_install >/dev/null
}


apt-get update
apt-get dist-upgrade --yes
apt_get_install
nopasswd_sudoers
update-alternatives --set editor /usr/bin/vim.nox
