vim.keymap.set('n', '<leader>tT', '<CMD>TestFile<CR>')
vim.keymap.set('n', '<leader>tt', '<CMD>TestFile -strategy=neomake<CR>')
vim.keymap.set('n', '<leader>tN', '<CMD>TestNearest<CR>')
vim.keymap.set('n', '<leader>tn', '<CMD>TestNearest -strategy=neomake<CR>')
vim.keymap.set('n', '<leader>t.', '<CMD>TestLast<CR>')
vim.keymap.set('n', '<leader>tv', '<CMD>TestVisit<CR>zz')
vim.keymap.set('n', '<leader>tS', '<CMD>TestSuite<CR>')
vim.keymap.set('n', '<leader>ts', '<CMD>TestSuite -strategy=neomake<CR>')
vim.keymap.set('n', '<leader>tc', '<CMD>VimuxCloseRunner<CR>')
