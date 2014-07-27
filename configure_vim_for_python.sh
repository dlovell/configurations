# Modifications to vim: indenting for python per http://precheur.org/vim/python


VIMRC=~/.vimrc
FTPLUGIN_DIR=~/.vim/ftplugin
PYTHON_VIM=~$FTPLUGIN_DIR/python.vim


mkdir -p $FTPLUGIN_DIR

cat -- >> $PYTHON_VIM <<EOF
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal textwidth=80
setlocal smarttab
setlocal expandtab
EOF

cat -- >> $VIMRC <<EOF
filetype plugin indent on
EOF
