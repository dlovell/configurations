my_abs_path=$(readlink -f "$0")
project_location=$(dirname $my_abs_path)
cd $project_location

bash configure_emacs.sh
bash configure_git.sh
bash configure_pip_and_virtualenv.sh
bash configure_tmux_vim_slime_for_repl.sh
bash configure_vim_for_python.sh
