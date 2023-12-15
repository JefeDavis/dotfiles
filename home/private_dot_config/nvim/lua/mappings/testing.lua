local M = {}
local wk = require('which-key')

function M.setup()
  wk.register({
    prefix = "<leader>",
    ['t'] = {
      name = '+test',
      ['t'] = { '<CMD>TestNearest<CR>', 'test nearest' },
      ['T'] = { '<CMD>TestNearest --strategy=neomake<CR>', 'test nearest (neomake)' },
      ['f'] = { '<CMD>TestFile<CR>', 'test file' },
      ['F'] = { '<CMD>TestFile --strategy=neomake<CR>', 'test file (neomake)' },
      ['s'] = { '<CMD>TestSuite<CR>', 'test suite' },
      ['S'] = { '<CMD>TestSuite --strategy=neomake<CR>', 'test suite (neomake)' },
      ['v'] = { '<CMD>TestVisit<CR>zz', 'visit last test' },
      ['.'] = { '<CMD>TestLast<CR>', 're-run last test' },
      ['q'] = { '<CMD>VimuxCloseRunner<CR>', 'close test window' },
    }
  })
end

return M
