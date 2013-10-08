echo packer | sudo -S apt-get install -y unzip
wget https://github.com/dlovell/vm_tools/archive/master.zip
unzip master.zip
echo packer | sudo -S bash vm_tools-master/install.sh
bash -i vm_tools-master/run_configure_scripts.sh
echo packer | sudo -S shutdown -h now
