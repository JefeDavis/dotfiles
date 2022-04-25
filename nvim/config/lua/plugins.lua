--[[
░█▀█░█░░░█░█░█▀▀░▀█▀░█▀█░█▀▀░░
░█▀▀░█░░░█░█░█░█░░█░░█░█░▀▀█░░
░▀░░░▀▀▀░▀▀▀░▀▀▀░▀▀▀░▀░▀░▀▀▀░░
--]]

vim.cmd [[packadd packer.nvim]]

local packer = require('packer')
packer.startup(function(use)
  use {'wbthomason/packer.nvim', opt = true}
  -- ==========================================

  -- FileType Plugins
  use {
    'crispgm/nvim-go',
    requires = { 'nvim-lua/plenary.nvim', 'nvim-lua/popup.nvim' },
    ft = { 'go', 'go.mod', 'go.sum'}
  }
  use {
    'tmux-plugins/vim-tmux',
    ft = { 'tmux' }
  }
  use {
    'vimwiki/vimwiki',
    branch = 'dev',
    config = function()
      require('wiki')
    end
  }
  use 'tools-life/taskwiki'

  use 'saltstack/salt-vim'
  use 'plasticboy/vim-markdown'
  use 'stephpy/vim-yaml'
  use 'hashivim/vim-terraform'
  -- ============================================

  -- Core Plugins
  use {
    'nvim-treesitter/nvim-treesitter',
    requires = { 'nvim-treesitter/nvim-treesitter-textobjects', 'nvim-treesitter/playground' },
    config = function() require("tree-sitter") end,
  }
  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'
  use 'tpope/vim-commentary'
  use 'tpope/vim-projectionist'
  use {
    'vim-test/vim-test',
    requires = { 'tpope/vim-dispatch', 'neomake/neomake', 'preservim/vimux' }
  }
  use 'jefedavis/vim-system-copy'

  -- ============================================

  -- Navigation
  use 'ggandor/lightspeed.nvim'
  use 'yuttie/comfortable-motion.vim'
  use {
    'christoomey/vim-tmux-navigator',
    config = function ()
      vim.g.tmux_navigator_disable_when_zoomed = true
    end
  }
  -- ============================================

  -- Completion
  use {
    'neovim/nvim-lspconfig',
    config = function() require('lsp') end,
    requires = { 'williamboman/nvim-lsp-installer' }
  }
  use {
    'hrsh7th/nvim-cmp',
    commit = '4f1358e659d51c69055ac935e618b684cf4f1429',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'L3MON4D3/LuaSnip',
      'hrsh7th/cmp-nvim-lua',
      'onsails/lspkind-nvim'
    },
    config = function()
      require('complete')
    end
  }
  use {
    'mfussenegger/nvim-lint',
    config = function()
      require('linting')
    end
  }
  use {'liuchengxu/vista.vim', cmd = 'Vista'}
  -- Status and UI
  -- use {
  --   'kyazdani42/nvim-tree.lua',
  --   requires = 'kyazdani42/nvim-web-devicons',
  --   config = function() require('tree') end
  -- }
  use {
    'luukvbaal/nnn.nvim',
    config = function()
      local nnn = require('nnn')
      require('nnn').setup {
        replace_netrw = "picker",
        mappings = {
          { "<C-t>", nnn.builtin.open_in_tab },
          { "<C-s>", nnn.builtin.open_in_split },
          { "<C-v>", nnn.builtin.open_in_vsplit },
        }
      }
    end
  }
  use {
    -- 'glepnir/galaxyline.nvim',
    -- branch = 'main',
    -- config = function() require('neoline') end,
    'feline-nvim/feline.nvim',
    -- branch = 'main',
    config = function()
      require('feline').setup {
        components = require('catppuccin-line')
      }
    end,
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
  use {
    'akinsho/nvim-bufferline.lua',
    config = function() require('buffer-line') end,
    requires = 'kyazdani42/nvim-web-devicons',
  }
  use {
    'glacambre/firenvim',
    run = function() vim.fn['firenvim#install'](0) end
  }
  use {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end
  }
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      {'nvim-lua/popup.nvim'},
      {'nvim-lua/plenary.nvim'},
      {'nvim-web-devicons'},
      {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}
    },
    config = function()
      require("fuzzy")
    end
  }

  -- Git
  use {
    'tpope/vim-fugitive',
    requires = {'tpope/vim-rhubarb'}
  }
  use {'rhysd/git-messenger.vim', cmd = 'GitMessenger'}
  use {
    'lewis6991/gitsigns.nvim',
    requires = {'nvim-lua/plenary.nvim'},
    config = function() require('git') end
  }
  use 'kana/vim-textobj-user'
  -- ============================================

  -- Themes
  use {'gruvbox-material/vim', opt = true, as = 'gruvbox-material'}
  use {'arcticicestudio/nord-vim', opt = true, as = 'nord'}
  use {
    'catppuccin/nvim',
    opt = false,
    as = 'catppuccin',
    config = function() require('theme.catppuccin') end
  }
  use {'mkarmona/colorsbox', opt = true}
  use {'jefedavis/embark-nvim', opt = true, as = 'embark'}
    -- config = function() require('theme.embark') end }
end)

vim.cmd("autocmd BufWritePost plugins.lua PackerCompile")
