# settings
config_filename=vbox_ubuntu-12.04.2-server-amd64_packer_config.json
vmname=packer-virtualbox
vmdir=output-virtualbox


# build!
bash create_vm_via_packer.sh "$config_filename"

# import and connect
bash import_boot_connect.sh $vmdir $vmname 
