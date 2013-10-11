# settings
config_filename=vbox_ubuntu-12.04.2-server-amd64_packer_config.json
vmname=packer-virtualbox
output_ovf=output-virtualbox/"${vmname}".ovf


# build!
bash create_vm_via_packer.sh "$config_filename"


# finish up
# must be NAT on VM creation; change to bridged afterwards to be able to ssh in from outside
# must specify not to change nat mac; else mac changes and can't get back in via ssh
VBoxManage import "$output_ovf" --options keepnatmacs


# start VM; append '--type headless' to have no gui
# VBoxManage startvm "$vmname"
# remove VM
# VBoxManage unregistervm "$vmname" --delete
# see VM info
# VBoxManage showvminfo "$vmname"
