" Theme stuff
" Dynamically switch color scheme and have things respect it
function SwitchColorScheme(name)
  let g:VIM_COLOR_SCHEME = a:name
  call ColorScheme()
  "call lightline#init()
  "call lightline#colorscheme()
  "call lightline#update()
endfunction

function! ColorScheme()
  if g:VIM_COLOR_SCHEME ==# 'embark'
    packadd embark
    let g:embark_terminal_italics = 1
    colorscheme embark
    hi Cursor guibg=#F48FB1 guifg=white
    "let g:lightline.colorscheme = 'embark'
    "let g:clap_theme = 'embark'
    hi link Sneak Search
    hi link ClapMatches Search
    hi LuaTreeFolderIcon guifg=#d4bfff
    hi LuaTreeFolderName guifg=#cbe3e7

    execute "silent ! tmux source-file ~/.config/tmux/embark.tmux"

  elseif g:VIM_COLOR_SCHEME ==# 'nord'
    " Lazy load theme in
    packadd nord
    let g:nord_underline = 1
    let g:nord_italic_comments = 1
    let g:nord_italic = 1
    let g:nord_cursor_line_number_background = 1
    colorscheme nord
    "let g:lightline.colorscheme = 'nord'

  elseif g:VIM_COLOR_SCHEME ==# 'challenger-deep'
    packadd challenger-deep
    let g:challenger_deep_terminal_italics = 1
    "let g:lightline.colorscheme = 'challenger-deep'
    colorscheme challenger_deep
    execute "silent ! tmux source-file ~/.config/tmux/embark.tmux"

  elseif g:VIM_COLOR_SCHEME ==# 'cyberpunk'
    packadd cyberpunk
    colorscheme cyberpunk

  elseif g:VIM_COLOR_SCHEME ==# 'gruvbox'
    packadd gruvbox
    colorscheme gruvbox
    set background=dark

  else 
    packadd wal
    set notermguicolors
    colorscheme wal
  endif


endfunction

if empty($THEME)
  if filereadable(expand('~/.config/theme/current-theme'))
      let theme = readfile(expand('~/.config/theme/current-theme'))[0]
  else
    let theme = 'wal'
  endif
else
  let theme = $THEME
endif

" The Defaults
:call SwitchColorScheme(theme)

" Check for theme change
function! ThemeCheck(timer)
    let homeDir = expand("~")
    let theme = readfile(homeDir.'/.config/theme/current-theme')[0]
    call SwitchColorScheme(theme)
endfunction

" Regularly check file for changes
let timer = timer_start(500, 'ThemeCheck', {'repeat': -1})
