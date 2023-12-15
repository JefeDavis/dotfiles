return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
    'nvim-treesitter/playground',
  },
  config = function()
    local parser_config = require 'nvim-treesitter.parsers'.get_parser_configs()

    require 'nvim-treesitter.configs'.setup {
      ensure_installed = 'all',
      sync_install = false,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = true
      },
      textobjects = {
        select = {
          enable = true,
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ['af'] = { query = '@function.outer', descr = 'around a function' },
            ['if'] = { query = '@function.inner', descr = 'inside a function' },
            ['ac'] = { query = '@class.outer', descr = 'around a class' },
            ['ic'] = { query = '@class.inner', descr = 'inside a class' },
            ['ab'] = { query = '@block.outer', descr = 'around a block' },
            ['ib'] = { query = '@block.inner', descr = 'inside a block' },
          }
        },
        move = {
          enable = true,
          set_jumps = false,
          goto_next_start = {
            [']]'] = '@function.outer',
          },
          goto_next_end = {
            [']['] = '@function.outer',
          },
          goto_previous_start = {
            ['[['] = '@function.outer',
          },
          goto_previous_end = {
            ['[]'] = '@function.outer',
          },
        },
      }
    }
  end
}
