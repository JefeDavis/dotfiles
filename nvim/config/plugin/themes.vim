" Theme stuff
" Dynamically switch color scheme and have things respect it
function SwitchColorScheme(name)
  let g:VIM_COLOR_SCHEME = a:name
  call ColorScheme()
endfunction

function! ColorScheme()
  if g:VIM_COLOR_SCHEME ==# 'gruvbox-light'
    packadd gruvbox-material
    set background=light
    let g:gruvbox_material_background = 'hard'
    let g:gruvbox_material_transparent_background = 1
    colorscheme gruvbox-material
    let g:clap_theme = 'gruvbox_light'
    hi link Sneak Search
    " hi Normal guibg=#FDF6E3
    " hi EndOfBuffer guibg=#FDF6E3
    hi CursorLine guibg=#FAF2CF
    hi PMenu guibg=#FAF2CF
    hi ClapFile guifg=#654735
    hi Visual guibg=#d9e1cc
    execute "silent ! kitty @ set-colors --all ~/.config/kitty/gruvbox-light.conf"
    execute "silent ! tmux source-file ~/.config/tmux/gruvbox-light.tmux"

  elseif g:VIM_COLOR_SCHEME ==# 'cyberpunk'
    execute "colorscheme ".  g:VIM_COLOR_SCHEME

    execute "silent ! kitty @ set-colors --all ~/.config/kitty/". g:VIM_COLOR_SCHEME. ".conf"
    execute "silent ! tmux source-file ~/.config/tmux/". g:VIM_COLOR_SCHEME. ".tmux"

  elseif g:VIM_COLOR_SCHEME ==# 'embark'
    execute "packadd ".  g:VIM_COLOR_SCHEME
    let g:embark_terminal_italics = 1
    execute "colorscheme ".  g:VIM_COLOR_SCHEME
    hi PMenu guibg=##1e1c31

    execute "silent ! kitty @ set-colors --all ~/.config/kitty/". g:VIM_COLOR_SCHEME. ".conf"
    execute "silent ! tmux source-file ~/.config/tmux/". g:VIM_COLOR_SCHEME. ".tmux"

  else
    execute "packadd ".  g:VIM_COLOR_SCHEME
    execute "colorscheme ".  g:VIM_COLOR_SCHEME

    execute "silent ! kitty @ set-colors --all ~/.config/kitty/". g:VIM_COLOR_SCHEME. ".conf"
    execute "silent ! tmux source-file ~/.config/tmux/". g:VIM_COLOR_SCHEME. ".tmux"
  endif
endfunction

if empty($THEME)
  if filereadable(expand("$HOME/.config/current-theme"))
    let theme = readfile(expand("$HOME/.config/current-theme"))[0]
  else
    let theme = 'embark'
  endif
else
  let theme = $THEME
endif

function! SynGroup()                                                            
    let l:s = synID(line('.'), col('.'), 1)                                       
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
  endfun

" The Defaults
" :call SwitchColorScheme(theme)

