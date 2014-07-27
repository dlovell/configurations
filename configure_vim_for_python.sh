# Modifications to vim: indenting for python using ftplugin per http://henry.precheur.org/vim/python
# requires configure_vim.sh to have been run


FTPLUGIN_DIR=~/.vim/ftplugin
PYTHON_VIM=~$FTPLUGIN_DIR/python.vim


cat -- >> $PYTHON_VIM <<EOF
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal textwidth=80
setlocal smarttab
setlocal expandtab
EOF
