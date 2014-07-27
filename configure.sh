my_abs_path=$(readlink -f "$0")
project_location=$(dirname $my_abs_path)
cd $project_location


bash configure_git.sh
bash configure_tmux.sh
bash configure_vim.sh
bash configure_vim_for_python.sh
bash configure_vim_for_vim_slime.sh
bash configure_vim_for_syntastic.sh
