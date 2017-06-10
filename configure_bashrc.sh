cat >> ~/.bashrc <<EOF
function tree-less {
	tree -C \$@ | less -R
}
EOF
