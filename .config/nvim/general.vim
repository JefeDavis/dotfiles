syntax enable

" Colors and styling
hi link xmlEndTag xmlTag
hi htmlArg gui=italic cterm=italic
hi Comment gui=italic cterm=italic
hi Type gui=italic cterm=italic
set termguicolors

" Spaces and Tabs
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent

" UI Config
set encoding=utf8
" Give us real time preview of substitutions
set inccommand=nosplit
set list
set lcs=eol:¬,extends:❯,precedes:❮,tab:>-
