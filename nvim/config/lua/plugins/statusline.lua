return {
  'feline-nvim/feline.nvim',
  config = function()
      require('feline').setup {
        components = require('catppuccin-line')
      }
  end,
  dependencies = {'kyazdani42/nvim-web-devicons'}
}
