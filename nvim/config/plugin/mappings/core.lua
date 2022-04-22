-- define the leaders
vim.g.mapleader = " "
vim.g.maplocalleader = "-"
vim.g.camelcasemotion_key = '<leader>'

-- quickfix list
vim.keymap.set('n', '<UP>', '<CMD>cope<CR>')
vim.keymap.set('n', '<DOWN>', '<CMD>cclose<CR>')
vim.keymap.set('n', '<RIGHT>', '<CMD>cnext<CR>')
vim.keymap.set('n', '<LEFT>', '<CMD>cprev<CR>')

-- make jump commands center the screen on search term
vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'N', 'Nzz')
vim.keymap.set('n', 'g;', 'g;zz')
vim.keymap.set('n', 'g,', 'g,zz')
vim.keymap.set('n', '<C-o>', '<C-o>zz')
vim.keymap.set('n', '<C-i>', '<C-i>zz')
vim.keymap.set('n', '*', '*zz')
vim.keymap.set('n', '#', '#zz')
vim.keymap.set('n', '<BS>', ':b#<CR>')
vim.keymap.set('n', '<leader>,', '<CMD>nohlsearch<CR>')

-- Have esc work just like it does in vim when running terminal
vim.keymap.set('t', '<Esc>', '<c-\\><c-n>', { silent = false })

-- More quickly call external programs
vim.keymap.set('n', '<leader>>', ':!<SPACE>', { silent = false })

vim.keymap.set('', '<ScrollWheelDown>', ':call comfortable_motion#flick(40)<CR>')
vim.keymap.set('', '<ScrollWheelUp>', ':call comfortable_motion#flick(-40)<CR>')

vim.keymap.set('n', '[x', '<CMD>set cursorcolumn<CR>')
vim.keymap.set('n', ']x', '<CMD>set nocursorcolumn<CR>')
