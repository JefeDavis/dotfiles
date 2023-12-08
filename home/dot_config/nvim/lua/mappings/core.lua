local wk = require('which-key')

wk.register(
  {
    ['<BS>'] = { '<CMD>b#<CR>', 'Open previous buffer' },
    ['<UP>'] = { '<CMD>copen<CR>', 'Open quick fix' },
    ['<DOWN>'] = { '<CMD>cclose<CR>', 'Close quick fix' },
    ['<LEFT>'] = { '<CMD>cprev<CR>zz', 'Previous quick fix item' },
    ['<RIGHT>'] = { '<CMD>cnext<CR>zz', 'Next quick fix item' },
    ['n'] = { 'nzz', 'Next search result' },
    ['N'] = { 'Nzz', 'Previous search result' },
    ['g;'] = { 'g;zz', 'Most recent change' },
    ['g,'] = { 'g,zz', 'Before most recent change' },
    ['J'] = { "mzJ`z", 'Join line' },
    ['J'] = { ':move \'>+1<CR>gv=gv', 'Move highlight group down', mode='v' },
    ['K'] = { ':move \'<-2<CR>gv=gv', 'Move highlight group up', mode='v' },
    ['<C-o>'] = { '<C-o>zz', 'Previous position in jump list' },
    ['<C-i>'] = { '<C-i>zz', 'Next position in the jump list' },
    ['*'] = { '*zz', 'Next match of word under cursor' },
    ['#'] = { '#zz', 'Previous match of word under cursor' },
    ['<leader>,'] = { '<CMD>nohlsearch<CR>', 'Clear search results' },
    ['<leader>>'] = { ':!<SPACE>', 'Run shell command', silent=false },
    ['<ESC>'] = { '<c-\\><c-n>', 'Switch back to normal mode', mode='t', silent=false },
    ['[x'] = { '<CMD>set cursorcolumn<CR>', 'Turn on cursor column' },
    [']x'] = { '<CMD>set nocursorcolumn<CR>', 'Turn off cursor column' },
    ['<leader>`'] = { '<CMD>source $MYVIMRC<CR>', 'Reload config' },
    ['<leader>~'] = { ':! chezmoi apply<CR>', 'apply chezmoi config' },
    ['<leader>p'] = { '"_fP', 'paste maintain register' },
    ['<leader>y'] = { '"+y', 'yank to system clipboard', mode= { 'n', 'v' } },
    ['<leader>Y'] = { '"+Y', 'yank line to system clipboard', mode= { 'n', 'v' } },
    ['<leader>d'] = { '"_d', 'delete to void register', mode= { 'n', 'v' } },
  }
)
