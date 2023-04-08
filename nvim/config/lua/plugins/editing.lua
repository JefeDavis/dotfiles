return {
  {
    'jiangmiao/auto-pairs',
    init = function()
      vim.g.AutoPairsMapSpace = 0
    end
  },
  'tpope/vim-commentary',
  'tpope/vim-repeat',
  'tpope/vim-endwise',
  'tpope/vim-speeddating',
  'jefedavis/vim-system-copy',
  'tpope/vim-projectionist',
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        keymaps = {
          insert          = '<C-g>z',
          insert_line     = 'gC-ggZ',
          normal          = 'gz',
          normal_cur      = 'gZ',
          normal_line     = 'gzz',
          normal_cur_line = 'gZZ',
          visual          = 'gz',
          visual_line     = 'gZ',
          delete          = 'gzd',
          change          = 'gzr',
        }
      })
    end
  },
  {
    'ggandor/leap.nvim',
    config = function()
      require('leap').add_default_mappings()
    end
  },
  {
    'ggandor/leap-spooky.nvim',
    config = function()
      require('leap-spooky').setup()
    end
  },
  'yuttie/comfortable-motion.vim',

  -- Completion, Navigation, Linters, Fixers
  {
    'christoomey/vim-tmux-navigator',
    init = function ()
      vim.g.tmux_navigator_disable_when_zoomed = true
    end
  },
  {
    'mfussenegger/nvim-lint',
    config = function()
      require('linting')
    end
  },
  {
    'NvChad/nvim-colorizer.lua',
    opts = {
      user_default_options = {
        mode = 'virtualtext',
        names = false
      }
    }
  },
  {
    'glacambre/firenvim',
    cond = function()
      return vim.g.started_by_firenvim
    end,
    build = function() vim.fn['firenvim#install'](0) end
  }
}
