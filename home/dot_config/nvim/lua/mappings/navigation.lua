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

M.motion = function()
  return wk.register({
    ['<ScrollWheelDown>'] = { ':call comfortable_motion#flick(40)<CR>', 'Scroll down', mode={ 'n', 'v', 'x' } },
    ['<ScrollWheelUp'] = { ':call comfortable_motion#flick(-40)<CR>', 'Scroll up', mode={ 'n', 'v', 'x' } },
  })
end

M.tmux = function()
  return wk.register({
    ['<C-h>'] = { ':<C-U>TmuxNavigateLeft<CR>', 'move focus left', mode={ 'n', 'v', 'x' } },
    ['<C-j>'] = { ':<C-U>TmuxNavigateDown<CR>', 'move focus down', mode={ 'n', 'v', 'x' } },
    ['<C-k>'] = { ':<C-U>TmuxNavigateUp<CR>', 'move focuse up', mode={ 'n', 'v', 'x' } },
    ['<C-l>'] = { ':<C-U>TmuxNavigateRight<CR>', 'move focus right', mode={ 'n', 'v', 'x' } },
    ['<C-\\>'] = { ':<C-U>TmuxNavigateLast<CR>', 'move to focus previous', mode={ 'n', 'v', 'x' } },
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
