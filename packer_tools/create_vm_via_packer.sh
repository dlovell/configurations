packer_config_filename=$1
if [[ -z $packer_config_filename ]]; then
	echo "USAGE: bash create_vm_via_packer.sh PACKER_CONFIG_FILENAME"
	exit
fi


# presume paths are relative to config filename location
# so cd to it; else validate fails
config_abs_path=$(readlink -f "$packer_config_filename")
config_abs_dir=$(dirname $config_abs_path)
cd $config_abs_dir


# validate and build
packer validate $packer_config_filename
if [[ $? -ne 0 ]]; then
	echo "Failed to validate $packer_config_filename"
	exit
fi


export PACKER_LOG=1 && packer build $packer_config_filename >out 2>err
# if NAT with port 2222
ssh-keygen -f "/home/dlovell/.ssh/known_hosts" -R [127.0.0.1]:2222
# if bridged, currently only works for VMware
# vm_ip=$(grep Detected err | tail -n 1 | awk '{print $NF}')
# echo "vm_ip=$vm_ip"
# ssh-keygen -f ~/.ssh/known_hosts -R $vm_ip
