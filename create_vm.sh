#!/bin/bash


# set the default values
VMwarePlayer=VMware-Player-3.1.4-385536.i386.bundle
VMwareVIX=VMware-VIX-1.12.2-1031769.i386.txt
ZIPPED_VM=debian_6_cdh4_baseline-20130506.zip
VM="Debian 6 64-bit (baseline)/Debian 6 64-bit.vmx"
user=bigdata
user_password=bigdata
root_password=bigdata

# print script usage
usage() {
    cat <<EOF
usage: $0 options
    
    VMware automation functions
    
    OPTIONS:
    -h      Show this message
    -p      VMwarePlayer=$VMwarePlayer
    -v      VMwareVIX=$VMwareVIX
    -z      ZIPPED_VM=$ZIPPED_VM
    -i      VM=$VM
    -u      user=$user
    -w      user_password=$user_password
    -r      root_password=$root_password
    -n      only install the vmware components
    -s      only start the VM and print its ip address
    -t      only terminate the VM
    -l      only set up password login
    -k      only set up ssh keys
    -a      only print vm ip address
EOF
exit
}

#Process the arguments
while getopts hp:v:z:i:nstlka opt
do
    case "$opt" in
        h) usage;;
        p) VMwarePlayer=$OPTARG;;
        v) VMwareVIX=$OPTARG;;
        z) ZIPPED_VM=$OPTARG;;
        i) VM=$OPTARG;;
        u) user=$user;;
        w) user_password=$user_password;;
        r) root_password=$root_password;;
	n) install_only="True";;
        s) start_only="True";;
        t) terminate_only="True";;
        l) password_login_only="True";;
        k) ssh_keys_only="True";;
        a) address_only="True";;
    esac
done


install_vmware_components() {
    vmware_player="$1"
    vmware_vix="$2"
    #
    sudo apt-get install build-essential linux-headers-$(uname -r)
    sudo bash "$vmware_player"
    sudo bash "$vmware_vix"
}

start_vm() {
    vmx="$1"
    vmrun -T player start "$vmx" nogui
}

terminate_vm() {
    vmx="$1"
    vmrun -T player stop "$vmx"
}

set_up_password_login() {
    vmx="$1"
    root_password="$2"
    echo $root_password
    vmrun -T player -gu root -gp $root_password runProgramInGuest "$vmx" \
	/usr/bin/perl -i.bak -pe 's/^#\s+(Password.*)/\$1/' /etc/ssh/ssh_config
    vmrun -T player -gu root -gp $root_password runProgramInGuest "$vmx" \
	/usr/sbin/invoke-rc.d ssh restart
}

set_up_ssh_keys() {
    # enable passwordless login
    vmx="$1"
    user="$2"
    root_password="$3"
    command_base='echo \$@ >>'
    #
    key_loc="/home/$user/.ssh/authorized_keys"
    command="$command_base $key_loc"
    vmrun -T player -gu root -gp $root_password runProgramInGuest "$vmx" /bin/mkdir /root/.ssh
    vmrun -T player -gu root -gp $root_password runProgramInGuest "$vmx" \
	/bin/bash -c "$command" -- $(cat ~/.ssh/id_rsa.pub)
    key_loc="/root/.ssh/authorized_keys"
    command="$command_base $key_loc"
    vmrun -T player -gu root -gp $root_password runProgramInGuest "$vmx" \
	/bin/bash -c "$command" -- $(cat ~/.ssh/id_rsa.pub)
}

print_vm_ip_address() {
    # note: the vmware pdf is slightly wrong about syntax here
    vmx="$1"
    root_password="$2"
    vm_cmd="info-set guestinfo.ip \$(ifconfig eth0 | perl -ne 'print \$1 if m/inet.addr:(\S+)/')"
    echo "vmx=$vmx"
    vmrun -T player -gu root -gp $root_password runProgramInGuest "$vmx" /usr/sbin/vmware-rpctool "$vm_cmd"
    VM_IP=$(vmrun -T player readVariable "$vmx" guestVar ip)
    echo "$VM_IP"
}

    
if [[ ! -z $install_only ]]; then
    echo only installing VMware components
    install_vmware_components $VMwarePlayer $VMwareVIX
    exit
elif [[ ! -z $start_only ]]; then
    echo only starting "$VM"
    start_vm "$VM"
    exit
elif [[ ! -z $terminate_only ]]; then
    echo only terminating "$VM"
    terminate_vm "$VM"
    exit
elif [[ ! -z $address_only ]]; then
    print_vm_ip_address "$VM"
    exit
elif [[ ! -z $password_login_only ]]; then
    set_up_password_login "$VM" "$root_password"
    exit
elif [[ ! -z $ssh_keys_only ]]; then
    set_up_ssh_keys "$VM" "$user" "$root_password"
    exit
fi


# install vmware components only if not already present
if [[ -z $(which vmrun) ]]; then
    install_vmware_components $VMwarePlayer $VMwareVIX
fi

if [[ ! -f "$VM" ]]; then
    unzip $ZIPPED_VM
fi
start_vm "$VM"
set_up_password_login "$VM" "$root_password"
set_up_ssh_keys "$VM" "$user" "$root_password"
echo export VM_IP=$("print_vm_ip_address $VM $root_password")
 
# enable bigdata user to install python pacakges
VM_IP=$("print_vm_ip_address $VM $root_password")
ssh -o StrictHostKeyChecking=no root@$VM_IP perl -pi.bak -e "'s/^bigdata ALL=\(ALL\) ALL.*/bigdata ALL=\(ALL:ALL\) NOPASSWD: ALL/'" /etc/sudoers
