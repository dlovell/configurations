config_filename=vbox_ubuntu-12.04.2-server-amd64_packer_config.json
mac_addr=$(perl -ne 'if(m/macaddress/) {m/"(\w+)"\]/; print $1}' $config_filename)
vmname=~/VirtualBox\ VMs/packer-virtualbox/packer-virtualbox.vbox
output_ovf=output-virtualbox/packer-virtualbox.ovf
#
bash create_vm_via_packer.sh $config_filename
VBoxManage import $output_ovf
# must be NAT on VM creation; change to bridged afterwards to be able to ssh in from outside
VBoxManage modifyvm "$vmname" --nic1 bridged
VBoxManage modifyvm "$vmname" --bridgeadapter1 eth0
VBoxManage modifyvm "$vmname" --macaddress1 $mac_addr

# start VM; append '--type headless' to have no gui
# VBoxManage startvm "$vmname"
# remove VM
# VBoxManage unregistervm "$vmname" --delete
# see VM info
# VBoxManage showvminfo "$vmname"
