# install packer on ubuntu
which_packer=$(which packer)
if [[ -z $which_packer ]]; then
	which_dir=~/packer
	which_zip=0.3.7_linux_amd64.zip
	#
	sudo apt-get install -y qemu-utils
	cd
	wget https://dl.bintray.com/mitchellh/packer/$which_zip
	mkdir $which_dir
	cd $which_dir
	unzip ../$which_zip
	cat -- >> ~/.bashrc <<EOF
	export PATH=$PATH:$which_dir
EOF
fi
