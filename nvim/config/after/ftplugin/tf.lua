local capabilities = require 'lsp_capabilities'()

if vim.fn.executable('terraform-ls') then
  vim.lsp.start({
    name = 'terraform-ls',
    cmd = { 'terraform-ls' },
    capabilities = capabilities,
    root_dir = vim.fs.dirname(vim.fs.find({'main.tf', '.git'}, { upward = true })[1]),
  })
end
