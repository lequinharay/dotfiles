set encoding=utf8
set fileencodings=utf8,euc-jp,sjis,iso-2022-jp,ucs-2,cp932
set title
set nowrap
set ic
set number
set ruler
set laststatus=2
set ea


set expandtab
set tabstop=4
set softtabstop=0
set shiftwidth=4
set autoindent

"set list

set hlsearch
set incsearch

set showmatch
set smartindent

syntax on

:helptags ~/.vim/doc

"filetype
autocmd BufNewFile,BufRead *.py set filetype=python

"color
set background=dark
colorscheme delek

setlocal omnifunc=syntaxcomplete#Complete
