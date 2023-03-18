return {
  'stephpy/vim-yaml',
  'saltstack/salt-vim',
  'towolf/vim-helm',
  'jparise/vim-graphql',
  'hashivim/vim-terraform',
  'tmux-plugins/vim-tmux',
  {
    "ray-x/go.nvim",
    dependencies = {  -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup()
    end,
    event = {"CmdlineEnter"},
    ft = {"go", 'gomod'},
    build = ':lua require("go.install").update_all_sync()'
  }
}
