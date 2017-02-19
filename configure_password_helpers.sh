# how to encrypt the google app password
# http://www.unix.com/shell-programming-and-scripting/156250-encrypt-decrypt-string.html


BASH_RC=$HOME/.bashrc


cat >> $BASH_RC <<EOF
OPENSSL_BASE_CMD="openssl enc -aes-128-cbc -a -salt"
XCLIP_CMD="xclip -sel clip"
PIDGIN_FILE=~/.encrypted/pidgin

function __encrypt_clipboard_to_stdout {
        \$XCLIP_CMD -out | \$OPENSSL_BASE_CMD -e
}

function __decrypt_stdin_to_clipboard {
        \$OPENSSL_BASE_CMD -d | \$XCLIP_CMD
}

function __encrypt_clipboard_to_pidgin {
	# plain-text passwords only viewable at creation
	# https://security.google.com/settings/security/apppasswords
        mkdir -p \$(dirname \$PIDGIN_FILE)
        \$XCLIP_CMD -out | \$OPENSSL_BASE_CMD -e > \$PIDGIN_FILE
}

function __decrypt_pidgin_to_clipboard {
        \$OPENSSL_BASE_CMD -d -in \$PIDGIN_FILE | \$XCLIP_CMD
}
EOF
