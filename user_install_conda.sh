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
BASH_RC_CONDA=${BASH_RC}_conda
BASH_ALIASES=$HOME/.bash_aliases
BASH_ALIASES_CONDA=${BASH_ALIASES}_conda


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
	cat >> $BASH_RC_CONDA <<EOF
# user_install_conda.sh
function shell_view_rst {
	pandoc \$1 | lynx -stdin
}

function shell_view_md {
	man <(rst2man.py \$1)
}
EOF
	cat >> $BASH_RC <<EOF
# user_install_conda.sh
source $BASH_RC_CONDA
EOF

	cat >> $BASH_ALIASES_CONDA <<EOF
# user_install_conda.sh
alias conda-get-latest='conda env list | grep \"^anaconda-[0-9]\{8\}\" | cut -d\" \" -f1 | sort | tail -n 1'
alias conda-create-latest='conda create --name anaconda-\$(date +%Y%m%d) anaconda'
alias conda-clone-latest='conda create --clone \$(conda-get-latest) --name'
alias sactivate-latest='source activate \$(conda-get-latest)'
alias sactivate='source activate'
alias sdeactivate='source deactivate'
EOF
	cat >> $BASH_ALIASES <<EOF
# user_install_conda.sh
source $BASH_ALIASES_CONDA
EOF
}


if [ -z $(which conda) ]; then
	install_conda
fi
