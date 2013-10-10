packer_config_filename=$1
MAC_ADDRESS=$2
if [[ -z $MAC_ADDRESS ]]; then
	echo "USAGE: bash create_vm_via_packer.sh PACKER_CONFIG_FILENAME MAC_ADDRESS"
	exit
fi


# presume paths are relative to config filename location
# so cd to it; else validate fails
config_abs_path=$(readlink -f "$packer_config_filename")
config_abs_dir=$(dirname $config_abs_path)
cd $config_abs_dir


# validate and build
MAC_VAR_STR="-var MAC_ADDRESS=$MAC_ADDRESS"
packer validate $MAC_VAR_STR $packer_config_filename
if [[ $? -ne 0 ]]; then
	echo "Failed to validate $packer_config_filename"
	exit
fi


export PACKER_LOG=1 && packer build $MAC_VAR_STR $packer_config_filename >out 2>err
vm_ip=$(grep Detected err | tail -n 1 | awk '{print $NF}')
echo "vm_ip=$vm_ip"
ssh-keygen -f ~/.ssh/known_hosts -R $vm_ip
