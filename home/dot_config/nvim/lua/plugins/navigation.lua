return {
  {
    'luukvbaal/nnn.nvim',
    config = function()
      local nnn = require("nnn")
      require('nnn').setup {
        mappings = {
          { "<C-t>", nnn.builtin.open_in_tab },       -- open file(s) in tab
          { "<C-x>", nnn.builtin.open_in_split },     -- open file(s) in split
          { "<C-v>", nnn.builtin.open_in_vsplit },    -- open file(s) in vertical split
        }
      }
      require('mappings.navigation').nnn()
    end
  },
  {
    'christoomey/vim-tmux-navigator',
    init = function ()
      vim.g.tmux_navigator_disable_when_zoomed = true
    end
  },
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.5',
    dependencies = { 
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      { 'nvim-telescope/telescope-symbols.nvim' },
    },
    config = function()
      require('telescope').setup{
        defaults = {
          prompt_prefix=' ',
        },
        pickers = {
          find_files = {
            find_command = {'rg', '--files', '--hidden', '-g', '!.git'},
            layout_config = {
              height = 0.70
            }
          },
          buffers = {
            show_all_buffers = true
          },
          git_status = {
            git_icons = {
              added = " ",
              changed = " ",
              copied = " ",
              deleted = " ",
              renamed = "➡",
              unmerged = " ",
              untracked = " ",
            },
            theme = "ivy"
          }
        }
      }
      require('telescope').load_extension('fzf')
      require('mappings.navigation').fuzzy()
    end
  }
}
