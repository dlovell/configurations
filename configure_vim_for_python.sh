# Modifications to vim: indenting for python using ftplugin per http://henry.precheur.org/vim/python
# requires configure_vim.sh to have been run: sets up ftplugin
set -eu


FTPLUGIN_DIR=~/.vim/ftplugin
PYTHON_VIM=$FTPLUGIN_DIR/python.vim


# # tried to insert this into vimrc but didn't take?
# nnoremap <silent> <buffer> <cr> :PythonSearchContext<cr>

mkdir -p $FTPLUGIN_DIR
cat -- >> $PYTHON_VIM <<EOF
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal textwidth=80
setlocal smarttab
setlocal expandtab
EOF
