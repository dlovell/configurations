#!/usr/bin/env bash
set -eu


ANACONDA_URL=http://repo.continuum.io/archive/Anaconda-2.0.1-Linux-x86_64.sh
MINICONDA_URL=http://repo.continuum.io/miniconda/Miniconda3-3.5.5-Linux-x86_64.sh
CONDA_URL=$MINICONDA_URL
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
# added by Miniconda3 3.5.5 installer
export PATH=\"$PREFIX/bin:\$PATH\"" >>$BASH_RC
}

function conda_install_things {
	conda install pip patchelf
}


install_conda
conda_install_things
