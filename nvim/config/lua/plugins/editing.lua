return {
  {
    'jiangmiao/auto-pairs',
    init = function()
      vim.g.AutoPairsMapSpace = 0
    end
  },
  'tpope/vim-surround',
  'tpope/vim-commentary',
  'tpope/vim-repeat',
  'tpope/vim-endwise',
  'tpope/vim-speeddating',
  'jefedavis/vim-system-copy',
  'tpope/vim-projectionist',
  {
    'ggandor/leap.nvim',
    config = function()
      require('leap').add_default_mappings()
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
