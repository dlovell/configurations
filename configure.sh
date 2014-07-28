function python_readlink {
	PYTHON_COMMAND='import sys, os; print os.path.realpath(sys.argv[1])'
	PYTHON_OUTPUT=$(python -c "$PYTHON_COMMAND" $1)
	echo $PYTHON_OUTPUT
}

my_abs_path=$(python_readlink "$0")
project_location=$(dirname $my_abs_path)
cd $project_location


bash configure_git.sh
bash configure_tmux.sh
bash configure_vim.sh
bash configure_vim_for_python.sh
bash configure_vim_for_vim_slime.sh
bash configure_vim_for_syntastic.sh
