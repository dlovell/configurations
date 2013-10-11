tar xvfz output-virtualbox.crosscat.tgz
VBoxManage import output-virtualbox.crosscat/packer-virtualbox.ovf 
VBoxManage modifyvm ~/VirtualBox\ VMs/packer-virtualbox/packer-virtualbox.vbox --macaddress1 080027DC1BB1
VBoxManage startvm ~/VirtualBox\ VMs/packer-virtualbox/packer-virtualbox.vbox
ssh -p 2222 packer@localhost
