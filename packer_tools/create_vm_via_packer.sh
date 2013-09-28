packer_config_filename=$1
if [[ -z $packer_config_filename ]]; then
	echo "USAGE: bash create_vm_via_packer.sh PACKER_CONFIG_FILENAME"
	exit
fi

# validate and build
packer validate $packer_config_filename && packer build $packer_config_filename
