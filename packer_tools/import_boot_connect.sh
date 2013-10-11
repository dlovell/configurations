vmname=packer-virtualbox
#
tar xvfz output-virtualbox.crosscat.tgz
VBoxManage import output-virtualbox.crosscat/"${vmname}".ovf
VBoxManage modifyvm "${vmname}" --macaddress1 080027DC1BB1
VBoxManage startvm "${vmname}"
ssh -p 2222 packer@localhost

# to power off
# VBoxManage controlvm "${vmname}" poweroff
# to remove (must be powered off)
# VBoxManage unregistervm "${vmname}" --delete
