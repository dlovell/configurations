vmname=packer-virtualbox
#
tar xvfz output-virtualbox.crosscat.tgz
VBoxManage import output-virtualbox.crosscat/"${vmname}".ovf --options keepnatmacs
VBoxManage startvm "${vmname}"
ssh -p 2222 packer@localhost

# to power off
# VBoxManage controlvm "${vmname}" poweroff
# to remove (must be powered off)
# VBoxManage unregistervm "${vmname}" --delete
