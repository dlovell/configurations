# Modifications to vim: indenting for python per http://precheur.org/vim/python

mkdir ~/.vim/ftplugin

cat -- >> ~/.vim/ftplugin/python.vim <<EOF
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal textwidth=80
setlocal smarttab
setlocal expandtab
EOF

cat -- >> ~/.vimrc <<EOF
filetype plugin indent on
EOF
