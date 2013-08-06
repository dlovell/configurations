#!/bin/bash


# set the default values
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
    -i      VMX=$VMX
    -u      user=$user
    -w      user_password=$user_password
    -r      root_password=$root_password
    -s      only start the VM and print its ip address
    -t      only suspend the VM
    -k      only set up ssh key login
    -a      only print vm ip address
    -e      only toggle eth0 on VM
    -p      only set up password login
EOF
exit
}


#Process the arguments
while getopts hi:u:w:r:stkaep opt
do
    case "$opt" in
        h) usage;;
        i) VMX=$OPTARG;;
        u) user=$user;;
        w) user_password=$user_password;;
        r) root_password=$root_password;;
        s) start_only="True";;
        t) suspend_only="True";;
        k) ssh_keys_only="True";;
        a) address_only="True";;
        e) toggle_eth0_only="True";;
        p) password_login_only="True";;
    esac
done


# Ensure VM was set
if [[ -z $VMX ]]; then
    echo "'-i <VMX>' must be passed"
    echo "not setting up VM!!!!"
    exit
fi

# Ensure VM exists
if [[ ! -f "$VMX" ]]; then
    echo "VM doesn't exist: $VMX"
    echo "not setting up VM !!!!"
    exit
fi

# Ensure vmware components present
if [[ -z $(which vmrun) ]]; then
    echo "VMware Player and VIX API must be installed"
    exit
fi


run_cmd_prefix="vmrun -T player"
run_cmd_as_root_infix="-gu root -gp \"$root_password\" runProgramInGuest \"$VMX\""

run_cmd_as_root() {
    vm_cmd=$1
    cmd_str="$run_cmd_prefix $run_cmd_as_root_infix $vm_cmd"
    bash -c "$cmd_str"
}

install_vmware_components() {
    vmware_player="$1"
    vmware_vix="$2"
    #
    sudo apt-get install build-essential linux-headers-$(uname -r)
    sudo bash "$vmware_player"
    sudo bash "$vmware_vix"
}

start_vm() {
    is_running=$(vmrun -T player list | grep "$VMX")
    if [[ -z $is_running ]]; then
	vmrun -T player start "$VMX" nogui
        # $vm_cmd="/usr/bin/env bash bin/reset-hadoop.sh"
        # run_cmd_as_root "$vm_cmd"
    fi
}

suspend_vm() {
    # vmrun -T player stop "$VMX"
    vmrun -T player suspend "$VMX"
}

print_vm_ip_address() {
    # note: the vmware pdf is slightly wrong about syntax here
    vm_cmd="info-set guestinfo.ip \\\$(ifconfig eth0 | perl -ne 'print \\\$1 if m/inet.addr:(\S+)/')"
    vm_cmd="/usr/sbin/vmware-rpctool \"$vm_cmd\""
    run_cmd_as_root "$vm_cmd"
    #
    VM_IP=$(vmrun -T player readVariable "$VMX" guestVar ip)
    echo "$VM_IP"
}

install_sshd() {
    vm_cmd="/usr/bin/apt-get install -y openssh-server"
    run_cmd_as_root "$vm_cmd"
}

restart_ssh() {
    vm_cmd="/etc/init.d/ssh restart"
    run_cmd_as_root "$vm_cmd"
}

set_up_password_login() {
    install_sshd
    #
    vm_cmd="/usr/bin/perl -i.bak -pe 's/^#\s+(Password.*)/\\\$1/' /etc/ssh/ssh_config"
    run_cmd_as_root "$vm_cmd"
    #
    restart_ssh
}

set_up_ssh_keys() {
    install_sshd
    #
    id_rsa_pub=$(cat ~/.ssh/id_rsa.pub)
    #
    vm_cmd="/bin/mkdir /home/$user/.ssh"
    run_cmd_as_root "$vm_cmd"
    vm_cmd="/bin/bash -c 'echo \\\$@ >> /home/$user/.ssh/authorized_keys' -- $id_rsa_pub"
    run_cmd_as_root "$vm_cmd"
    # FIXME: chown -R $user /home/$user/.ssh/
    #
    vm_cmd="/bin/mkdir /root/.ssh"
    run_cmd_as_root "$vm_cmd"
    vm_cmd="/bin/bash -c 'echo \\\$@ >> /root/.ssh/authorized_keys' -- $id_rsa_pub"
    run_cmd_as_root "$vm_cmd"
    #
    restart_ssh
}

toggle_eth0() {
    vm_cmd="/usr/sbin/service network-manager restart"
    run_cmd_as_root "$vm_cmd"
}


if [[ ! -z $start_only ]]; then
    echo only starting "$VM"
    start_vm "$VMX"
    exit
elif [[ ! -z $suspend_only ]]; then
    echo only suspending "$VMX"
    suspend_vm "$VMX"
    exit
elif [[ ! -z $ssh_keys_only ]]; then
    echo only setting up ssh keys on "$VMX"
    set_up_ssh_keys "$VMX"
    exit
elif [[ ! -z $address_only ]]; then
    print_vm_ip_address "$VMX"
    exit
elif [[ ! -z $toggle_eth0_only ]]; then
    toggle_eth0 "$VMX"
    exit
elif [[ ! -z $password_login_only ]]; then
    set_up_password_login "$VMX"
    exit
fi

echo "starting vm $VMX"
start_vm "$VMX"
# set_up_password_login "$VMX"
echo "setting up ssh key login"
set_up_ssh_keys "$VMX"
# give VM extra time to get an IP address
sleep 5

# enable user to install python pacakges
VM_IP=$(print_vm_ip_address "$VMX")
ssh -o StrictHostKeyChecking=no root@$VM_IP ls
has_user=$(ssh root@$VM_IP grep $user /etc/sudoers)
if [[ -z $has_user ]]; then
	ssh root@$VM_IP "echo \"$user ALL=(ALL:ALL) NOPASSWD: ALL\" >> /etc/sudoers"
else
	ssh root@$VM_IP perl -pi.bak -e "'s/^$user ALL=\(ALL\) ALL.*/$user ALL=\(ALL:ALL\) NOPASSWD: ALL/'" /etc/sudoers
fi

# FIXME: should do these steps too
# scp /opt/vm_tools/install.sh root@$VM_IP:/root/
# ssh root@$VM_IP bash /root/install.sh
# user=bigdata
# ssh root@$VM_IP mkdir /opt/vm_tools
# ssh root@$VM_IP chown $user /opt/vm_tools
# scp -r /opt/vm_tools $user@$VM_IP:/opt/
# ssh root@$VM_IP bash /opt/vm_tools/install.sh
# ssh $user@$VM_IP “ls /opt/vm_tools/configure_*sh | xargs -n1 bash”
