local M = {}
local wk = require("which-key")

M.nnn = function()
  return wk.register({
    prefix = "<leader>",
    {
      ["\\"] = { "<CMD>NnnExplorer<CR>", "Open File Explorer in side pane", mode={"n","t"} },
      ["<BAR>"] = { "<CMD>NnnPicker %:p<CR>", "Open File Explorer in floating window" },
      ["_"] = { ":silent grep ", "grep", silent=false },
    }
  })
end

M.fuzzy = function()
  local builtin = require('telescope.builtin')

  return wk.register({
    prefix = '<leader>',
    {
      ['/'] = { builtin.live_grep, 'live grep' },
      ['<Backspace>'] = { builtin.buffers, 'buffers' },
      ['f'] = {
        name='+find',
        ['f'] = { builtin.find_files, 'files' },
        ['r'] = { builtin.buffers, 'buffers' },
        ['m'] = { builtin.man_pages, 'man pages' },
        ['i'] = { '<CMD>Telescope symbols<CR>', 'symbols' },
        ['?'] = { builtin.help_tags, 'help' },
        ['.'] = { builtin.resume, 'resume' },
        ['g'] = {
          name = '+git',
          ['s'] = { builtin.git_status, 'git status' },
          ['b'] = { builtin.git_branches, 'git status' },
        }
      }
    }
  })
end

return M
