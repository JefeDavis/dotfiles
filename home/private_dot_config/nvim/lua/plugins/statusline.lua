return {
  'freddiehaddad/feline.nvim',
  config = function()
      require('feline').setup {
        components = require('catppuccin-line').config(),
      }
  end,
  dependencies = {'kyazdani42/nvim-web-devicons'}
}
