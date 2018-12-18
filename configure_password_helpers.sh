# how to encrypt the google app password
# http://www.unix.com/shell-programming-and-scripting/156250-encrypt-decrypt-string.html


BASH_RC=$HOME/.bashrc


cat >> $BASH_RC <<EOF
# configure_password_helpers.sh
ENCRYPTED_DIR=~/.encrypted
mkdir -p \$ENCRYPTED_DIR
PIDGIN_FILE=\$ENCRYPTED_DIR/pidgin
#
# plain-text passwords only viewable at creation
# https://security.google.com/settings/security/apppasswords
OPENSSL_BASE_CMD="openssl enc -aes-128-cbc -a -salt"
XCLIP_CMD="xclip -sel clip"
#
function __encrypt_clipboard_to_file {
        \$XCLIP_CMD -out | \$OPENSSL_BASE_CMD -e -out \$1
}
function __decrypt_file_to_clipboard {
        \$OPENSSL_BASE_CMD -d -in \$1 | \$XCLIP_CMD
}
#
function __encrypt_clipboard_to_pidgin {
	__encrypt_clipboard_to_file \$PIDGIN_FILE
}
function __decrypt_pidgin_to_clipboard {
	__decrypt_file_to_clipboard \$PIDGIN_FILE
}
EOF
