# WIP: this should not be run by root
function oops {
	echo "$0:" "$@" >&2
	exit 1
}

[ -z "$SUDO_USER" ] || oops "must not run as $SUDO_USER"
sudo apt install --yes curl && curl https://nixos.org/nix/install | sh
