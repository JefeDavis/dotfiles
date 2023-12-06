local g = vim.g

require('mappings.testing').setup()

return {
  'vim-test/vim-test',
  config = function()
    g['test#preserve_screen'] = false
    g['test#strategy'] = {
      nearest = 'vimux',
      file = 'vimux',
      suite = 'vimux',
    }
    g['test#go#runner'] = 'gotest'
    g['test#neovim#term_position'] = 'vert'
  end,
  dependencies = {
    { 
      'tpope/vim-dispatch',
      config = function()
        vim.api.nvim_create_autocmd('FileType', {
          desc = 'set dispatch compiler to got test when go file is opened',
          pattern = {'go', 'gomod', 'gosum' },
          callback = function()
            local b = vim.b
            b.dispatch = 'go test %'
            end
          })
      end,
    },
    {
      'neomake/neomake',
      config = function()
        g.neomake_open_list = true
        g.neomake_warning_sign = { text = '∙' }
        g.neomake_error_sign = { text = '∙' }
      end
    },
    {
      'preservim/vimux',
      config = function()
        g.VimuxOrientation = 'h'
        g.VimuxHeight = '30'
      end
    }
  }
}
