local lint = require 'lint'

lint.linters_by_ft = {
  go = { 'golangcilint', }
}

local group = vim.api.nvim_create_augroup('MyLinter', {})

vim.api.nvim_create_autocmd({'BufWritePost', 'BufEnter'}, {pattern = {"*.go", "go.mod"}, callback = function() lint.try_lint() end, group = group})
