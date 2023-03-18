local map = vim.keymap.set

map('n', '<leader>\\', '<CMD>NnnExplorer<CR>')
map('t', '<leader>\\', '<CMD>NnnExplorer<CR>')
map('n', '<leader><BAR>', '<CMD>NnnPicker %:p<CR>')
map('n', '<leader>_', ':silent grep ', { silent = false })
