cat >> ~/.bashrc <<EOF
stty -ixon
function tree-less {
	tree -C \$@ | less -R
}
function sudo-brightness {
	BACKLIGHT_DIR=/sys/class/backlight
	BACKLIGHT_DIR=\$BACKLIGHT_DIR/\$(ls \$BACKLIGHT_DIR)
	echo \$1 | sudo tee \$BACKLIGHT_DIR/brightness
}
EOF
