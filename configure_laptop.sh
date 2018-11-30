cat >> ~/.bashrc.new <<EOF
function sudo-usb-unbind {
	# lsusb -t
	# echo ‘<bus>-<port>’ | sudo tee /sys/bus/usb/drivers/usb/unbind
	for device in 1-6 1-7 1-8; do
		echo \$device | sudo tee /sys/bus/usb/drivers/usb/unbind
	done
	echo 0 > sudo tee /sys/bus/usb/devices/1-6/power/autosuspend_delay_ms
	echo auto > sudo tee /sys/bus/usb/devices/1-6/power/control
}
EOF

cat >> ~/.bash_aliases <<EOF
alias radio-all-on='nmcli radio all on'
alias radio-all-off='nmcli radio all off'
alias connection-up='nmcli connection up'
alias device-wifi-list='nmcli device wifi list'
alias device-wifi-connect='nmcli device wifi connect'
#
alias tmux-pasuspender='tmux new-session -d -s pasuspender pasuspender -- sleep 10000000000'
EOF
