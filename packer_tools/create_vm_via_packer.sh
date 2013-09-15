# create vmware config
packer_config_filename=vmware_packer_config.json
cat -- >$packer_config_filename <<EOF
{
	"builders": [{
	"type": "vmware",
	"iso_url": "http://releases.ubuntu.com/13.04/ubuntu-13.04-server-amd64.iso",
	"iso_checksum": "7d335ca541fc4945b674459cde7bffb9",
	"iso_checksum_type": "md5",
	"ssh_username": "vagrant",
	"ssh_password": "vagrant",
	"shutdown_command": "echo vagrant | sudo -S shutdown -P now",
	"disk_size": 8000,
	"boot_command": [ "<esc><esc><enter><wait>", "/install/vmlinuz noapic ", "preseed/url=http://gist.github.com/Josiah/6005339/raw/2a13d3839818848b5d7e802c08aa29986bd5a150/preseed.cfg ", "debian-installer=en_US auto locale=en_US kbd-chooser/method=us ", "hostname={{ .Name }} ", "fb=false debconf/frontend=noninteractive ", "keyboard-configuration/modelcode=SKIP keyboard-configuration/layout=USA ", "keyboard-configuration/variant=USA console-setup/ask_detect=false ", "initrd=/install/initrd.gz -- <enter>" ]
}]
}
EOF

# validate and build
packer validate $packer_config_filename && packer build $packer_config_filename
