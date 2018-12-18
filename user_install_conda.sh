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
BASH_ALIASES=$HOME/.bash_aliases


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

	# set up for some other stuff
	$PREFIX/bin/conda install pandoc --yes
	echo "
function shell_view_rst {
	pandoc \$1 | lynx -stdin
}

function shell_view_md {
	man <(rst2man.py \$1)
}
" >> $BASH_RC
	echo "
alias conda-get-latest='conda env list | grep \"^anaconda-[0-9]\{8\}\" | cut -d\" \" -f1 | sort | tail -n 1'
alias conda-create-latest='conda create --name anaconda-\$(date +%Y%m%d) anaconda'
alias source-activate-latest='source activate \$(conda-get-latest)'
alias conda-clone-latest='conda create --clone \$(conda-get-latest) --name'
alias sactivate='source activate'
" >> $BASH_ALIASES
}


if [ -z $(which conda) ]; then
	install_conda
fi
