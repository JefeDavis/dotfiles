" Expand the home directory to an absolute path.
let homeDir = expand('~')

" Find the desired VimPackager install location for different system configurations.
if(has('win32') || has('win64'))
    if has('nvim')
        let plugVim=homeDir.'/AppData/Local/nvim/pack/packager/opt/vim-packager'
    else
        let plugVim=homeDir.'/vimfiles/pack/packager/opt/vim-packager'
    endif
else
    if has('nvim')
        let plugVim=homeDir.'/.config/nvim/pack/packager/opt/vim-packager'
    else
        let plugVim=homeDir.'/.vim/pack/packager/opt/vim-packager'
    endif
endif

" Url of the VimPackager script.
let plugUri = 'https://github.com/kristijanhusak/vim-packager'

if empty(glob(expand(plugVim)))
    " Download VimPackager using git.
    exec '!git clone '.plugUri.' '.plugVim
endif
