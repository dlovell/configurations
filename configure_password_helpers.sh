BASH_RC=$HOME/.bashrc
PASSWORD_HELPERS=$HOME/.bashrc_password_helpers

cat >> $PASSWORD_HELPERS <<EOF
# configure_password_helpers.sh
# see: http://www.unix.com/shell-programming-and-scripting/156250-encrypt-decrypt-string.html
ENCRYPTED_DIR=~/.encrypted
mkdir -p \$ENCRYPTED_DIR

alias openssl-enc-base64-salt='openssl enc -aes-128-cbc -base64 -salt'
alias encrypt-stdin-to-stdout='openssl-enc-base64-salt -e'
alias decrypt-stdin-to-stdout='openssl-enc-base64-salt -d'
function __generate_password {
	cat /dev/urandom | tr -dc _A-Z-a-z-0-9 | head -c \${1:-32}
}
function __get_encrypted_file {
	local encrypted_file=\$ENCRYPTED_DIR/\$1
	[ -n "\$1" -a -e \$encrypted_file ] || return 1
	echo \$encrypted_file
}
#
function encrypt-clipboard-to {
	local encrypted_file=\$(__get_encrypted_file \$1) || return 1
	xclip -sel clip -out | encrypt-stdin-to-stdout > \$encrypted_file
}
function decrypt-to-clipboard {
	local encrypted_file=\$(__get_encrypted_file \$1) || return 1
	cat \$encrypted_file | decrypt-stdin-to-stdout | xclip -sel clip
}
function generate-password-for {
	local encrypted_file=\$(__get_encrypted_file \$1) || return 1
	__generate_password | encrypt-stdin-to-stdout > \$encrypted_file
}
EOF

cat >> $BASH_RC <<EOF
# configure_password_helpers.sh
source $PASSWORD_HELPERS
EOF
