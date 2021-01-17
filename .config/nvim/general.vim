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
set smartindent
set showtabline=2

" UI Config
set encoding=utf8
" Give us real time preview of substitutions
set inccommand=nosplit
set list
set lcs=eol:¬,extends:❯,precedes:❮,tab:>-
set number
set relativenumber
set ruler
set cursorline
set wrap
set linebreak
set wildmenu
set lazyredraw
set showmatch
set shortmess+=c
set updatetime=300
set signcolumn=yes

" Searching
set incsearch
set hlsearch
set smartcase
set ignorecase

" Folding
set foldenable
set foldlevelstart=10
set foldnestmax=10

"misc
set nobackup
set nowritebackup
set noswapfile
set hidden
set history=100
set path+=**
set splitbelow
set splitright

set diffopt=vertical,filler


