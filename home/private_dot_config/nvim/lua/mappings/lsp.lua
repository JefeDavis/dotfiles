local M = {}
local wk = require('which-key')

M.on_attach = function(_, bufnr)
  wk.register({
    {
      mode = 'n',
      prefix = 'g',
      buffer = bufnr,
      ['l'] = {
        name = '+lsp',
        ['d'] = { require('telescope.builtin').lsp_definitions, 'Goto Definition' },
        ['r'] = { require('telescope.builtin').lsp_references, 'Goto References' },
        ['i'] = { require('telescope.builtin').lsp_implementations, 'Goto Implementation' },
        ['o'] = { require('telescope.builtin').lsp_type_definitions, 'Type Definition' },
        ['l'] = { vim.diagnostic.open_float, 'Open Diagnostic Float' },
        ['k'] = { vim.lsp.buf.hover, 'Hover Documentation' },
        ['s'] = { vim.lsp.buf.signature_help, 'Signature Documentation' },
        ['D'] = { vim.lsp.buf.declaration, 'Goto Declaration' },
        ['v'] = { '<cmd> vsplit | lua vim.lsp.buf.definition()<cr>', 'Goto Declaration' },
      },
    },
  })
end

return M
