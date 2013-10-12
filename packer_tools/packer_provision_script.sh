# settings
sudo_pass=bigdata


echo $sudo_pass | sudo -S apt-get install -y unzip
wget https://github.com/dlovell/vm_tools/archive/master.zip
unzip master.zip
echo $sudo_pass | sudo -S bash vm_tools-master/install.sh
bash -i vm_tools-master/run_configure_scripts.sh
echo $sudo_pass | sudo -S shutdown -h now
