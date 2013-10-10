# settings
config_filename=vbox_ubuntu-12.04.2-server-amd64_packer_config.json
MAC_ADDR=080027DC1BB1
# should force vmname and output_ovf using packer, virtualbox arguments
vmname=~/VirtualBox\ VMs/packer-virtualbox/packer-virtualbox.vbox
output_ovf=output-virtualbox/packer-virtualbox.ovf


# build!
bash create_vm_via_packer.sh $config_filename $MAC_ADDR

# finish up
VBoxManage import $output_ovf
# must be NAT on VM creation; change to bridged afterwards to be able to ssh in from outside
VBoxManage modifyvm "$vmname" --nic1 bridged
VBoxManage modifyvm "$vmname" --bridgeadapter1 eth0
VBoxManage modifyvm "$vmname" --macaddress1 $MAC_ADDR


# start VM; append '--type headless' to have no gui
# VBoxManage startvm "$vmname"
# remove VM
# VBoxManage unregistervm "$vmname" --delete
# see VM info
# VBoxManage showvminfo "$vmname"
