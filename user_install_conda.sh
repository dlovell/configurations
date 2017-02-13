#!/usr/bin/env bash
set -eu


function get_latest_anaconda {
	wget $ANACONDA_BASE_URL -o wget.err -O- \
		| grep Anaconda3 | grep Linux-x86_64 \
		| sort \
		| tail -n 1 \
		| perl -ne 'print $1 if m/">(Anaconda3.*)<\/a/'
}


ANACONDA_BASE_URL=https://repo.continuum.io/archive
ANACONDA_URL=$ANACONDA_BASE_URL/$(get_latest_anaconda)
MINICONDA_URL=http://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
CONDA_URL=$ANACONDA_URL
WHICH_CONDA=$(basename $CONDA_URL)
BASH_RC=$HOME/.bashrc


function install_conda {
	CONDA_DEST=~/$WHICH_CONDA
	if [[ ! -f $CONDA_DEST ]]; then
		wget $CONDA_URL -O $CONDA_DEST
	fi
	bash $CONDA_DEST -b
	# get prefix
	source <(grep -m 1 ^PREFIX= $CONDA_DEST --binary-files=text)
	echo "
# added by Anaconda3/Miniconda3 installer
export PATH=\"$PREFIX/bin:\$PATH\"" >>$BASH_RC
}


install_conda
