return {
  {
    'tpope/vim-fugitive',
    event = 'VimEnter',
    dependencies = {'tpope/vim-rhubarb'},
    config = function()
      require('mappings.git').fugitive()
    end
  },

  {
    'sindrets/diffview.nvim',
    cmd = "DiffviewOpen",
    dependencies = { 'nvim-lua/plenary.nvim', 'kyazdani42/nvim-web-devicons' },
    config = true
  },

  {
    'rhysd/git-messenger.vim',
    cmd = 'GitMessenger'
  },

  {
    'lewis6991/gitsigns.nvim',
    event = 'VimEnter',
    dependencies = {'nvim-lua/plenary.nvim'},
    config = function()
      require('gitsigns').setup({
        signs = {
          add          = {hl = 'GitGutterAdd'   , text = '│'},
          change       = {hl = 'GitGutterChange', text = '│'},
          delete       = {hl = 'GitGutterDelete', text = '│'},
          topdelete    = {hl = 'GitGutterDelete', text = '│'},
          changedelete = {hl = 'GitGutterDelete', text = '│'},
        },
        on_attach = function(bufnr)
          require('mappings.git').gitsigns()
        end
      })
    end
  }
}
