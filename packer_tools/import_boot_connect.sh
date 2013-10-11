tar xvfz output-virtualbox.crosscat.tgz
VBoxManage import output-virtualbox.crosscat/packer-virtualbox.ovf 
VBoxManage modifyvm ~/VirtualBox\ VMs/packer-virtualbox/packer-virtualbox.vbox --macaddress1 080027DC1BB1
VBoxManage startvm ~/VirtualBox\ VMs/packer-virtualbox/packer-virtualbox.vbox
ssh -p 2222 packer@localhost

# to power off
# VBoxManage controlvm ~/VirtualBox\ VMs/packer-virtualbox/packer-virtualbox.vbox poweroff
# to remove (must be powered off)
# VBoxManage unregistervm ~/VirtualBox\ VMs/packer-virtualbox/packer-virtualbox.vbox --delete
