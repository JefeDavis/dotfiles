function! PackagerInit() abort
  packadd vim-packager
  call packager#init()
  call packager#add('kristijanhusak/vim-packager', { 'type': 'opt' })
  call packager#add('christoomey/vim-tmux-navigator')
  call packager#add('neovim/nvim-lspconfig')
  call packager#add('nvim-lua/completion-nvim')
  call packager#add('embark-theme/vim', { 'type': 'opt', 'name': 'embark'})
  call packager#add('challenger-deep-theme/vim', { 'type': 'opt', 'name': 'challenger-deep'})
  call packager#add('aloussase/cyberpunk', { 'type': 'opt' })
  call packager#add('arcticicestudio/nord-vim', { 'type': 'opt', 'name': 'nord' })
  call packager#add('morhetz/gruvbox', { 'type': 'opt', 'name': 'gruvbox' })
  call packager#add('dylanaraps/wal.vim', { 'type': 'opt', 'name': 'wal' })
  call packager#add('mattn/vim-filewatcher', { 'do': 'pushd filewatcher && go get -d && go build && popd'})

endfunction


command! PackagerInstall call PackagerInit() | call packager#install()
command! -bang PackagerUpdate call PackagerInit() | call packager#update({ 'force_hooks': '<bang>' })
command! PackagerClean call PackagerInit() | call packager#clean()
command! PackagerStatus call PackagerInit() | call packager#status()
