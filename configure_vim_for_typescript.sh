#!/usr/bin/env bash
set -eu


BUNDLE_DIR=~/.vim/bundle
VIMRC=~/.vimrc
CTAGS=~/.ctags


function install_typescript_vim_for_pathogen {
	TYPESCRIPT_VIM_URL=https://github.com/leafgarland/typescript-vim

	mkdir -p $BUNDLE_DIR && cd $BUNDLE_DIR
	git clone $TYPESCRIPT_VIM_URL
}


install_typescript_vim_for_pathogen
# https://github.com/majutsushi/tagbar/wiki
npm install --global git+https://github.com/Perlence/tstags.git
echo "
let g:tagbar_type_typescript = {
  \ 'ctagsbin' : 'tstags',
  \ 'ctagsargs' : '-f-',
  \ 'kinds': [
    \ 'e:enums:0:1',
    \ 'f:function:0:1',
    \ 't:typealias:0:1',
    \ 'M:Module:0:1',
    \ 'I:import:0:1',
    \ 'i:interface:0:1',
    \ 'C:class:0:1',
    \ 'm:method:0:1',
    \ 'p:property:0:1',
    \ 'v:variable:0:1',
    \ 'c:const:0:1',
  \ ],
  \ 'sort' : 0
\ }
" >> $VIMRC
echo "
--langdef=typescript
--langmap=typescript:.ts
--regex-typescript=/^[ \t]*(export([ \t]+abstract)?)?[ \t]*class[ \t]+([a-zA-Z0-9_]+)/\3/c,classes/
--regex-typescript=/^[ \t]*(export)?[ \t]*module[ \t]+([a-zA-Z0-9_]+)/\2/n,modules/
--regex-typescript=/^[ \t]*(export)?[ \t]*function[ \t]+([a-zA-Z0-9_]+)/\2/f,functions/
--regex-typescript=/^[ \t]*export[ \t]+var[ \t]+([a-zA-Z0-9_]+)/\1/v,variables/
--regex-typescript=/^[ \t]*var[ \t]+([a-zA-Z0-9_]+)[ \t]*=[ \t]*function[ \t]*\(\)/\1/v,varlambdas/
--regex-typescript=/^[ \t]*(export)?[ \t]*(public|private)[ \t]+(static)?[ \t]*([a-zA-Z0-9_]+)/\4/m,members/
--regex-typescript=/^[ \t]*(export)?[ \t]*interface[ \t]+([a-zA-Z0-9_]+)/\2/i,interfaces/
--regex-typescript=/^[ \t]*(export)?[ \t]*enum[ \t]+([a-zA-Z0-9_]+)/\2/e,enums/
--regex-typescript=/^[ \t]*import[ \t]+([a-zA-Z0-9_]+)/\1/I,imports/
" >> $CTAGS
