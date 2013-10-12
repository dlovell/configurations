vmdir=$1
vmname=$2
if [[ -z $vmname ]]; then
	echo "USAGE: bash import_boot_connet VMDIR VMNAME"
	exit
fi
ovf_full_path="${vmdir}"/"${vmname}".ovf
# FIXME: should not hardcode this
port_number=2222
username=bigdata


# must be NAT on VM creation; change to bridged afterwards to be able to ssh in from outside
# must specify not to change nat mac; else mac changes and can't get back in via ssh
VBoxManage import $ovf_full_path --options keepnatmacs


# start VM; remove '--type headless' to use gui
VBoxManage startvm "${vmname}" --type headless
ssh-keygen -f ~/.ssh/known_hosts -R [localhost]:$port_number
ssh -p $port_number $username@localhost


# see VM info
# VBoxManage showvminfo "${vmname}"

# to power off
# VBoxManage controlvm "${vmname}" poweroff

# to remove (must be powered off)
# VBoxManage unregistervm "${vmname}" --delete
