packer_config_filename=$1
if [[ -z $packer_config_filename ]]; then
	echo "USAGE: bash create_vm_via_packer.sh PACKER_CONFIG_FILENAME"
	exit
fi

# validate and build
packer validate $packer_config_filename
if [[ $? -ne 0 ]]; then
	echo "Failed to validate $packer_config_filename"
	exit
fi
export PACKER_LOG=1 && packer build $packer_config_filename >out 2>err
vm_ip=$(grep Detected err | tail -n 1 | awk '{print $NF}')
echo "vm_ip=$vm_ip"
ssh-keygen -f ~/.ssh/known_hosts -R $vm_ip