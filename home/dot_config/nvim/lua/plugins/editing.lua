return {
  {
    'tpope/vim-projectionist',
    ft = 'go',
    config = function()
      vim.g.projectionist_heuristics = {
        ['*.go'] = {
          ['*.go'] = {
              ['alternate'] = '{}_test.go',
              ['type'] = 'source'
          },
          ['*_test.go'] = {
              ['alternate'] = '{}.go',
              ['type'] = 'test'
          },
        }
      }
    end,
  },
  { 
    'tpope/vim-commentary',
    config = function()
      require('mappings.editing').commentary()
    end
  },
  { 'tpope/vim-speeddating' },
  { 'tpope/vim-repeat' },
  {
    "kylechui/nvim-surround",
    version ="*", -- Use for stability; omit to use `main` branch for the latest features
    event = 'VeryLazy',
    config = function()
      require('nvim-surround').setup({
        -- set mappings in mappings module
        keymaps = {
          insert          = false,
          insert_line     = false,
          normal          = false,
          normal_cur      = false,
          normal_line     = false,
          normal_cur_line = false,
          visual          = false,
          visual_line     = false,
          delete          = false,
          change          = false,
        }
      })
      require('mappings.editing').surround()
    end
  },
}
