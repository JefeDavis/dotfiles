return {
  {
    "hrsh7th/nvim-cmp", --> AutoCompletion plugin
    event = "InsertEnter",
    dependencies = {
      "L3MON4D3/LuaSnip",  --> Snippets plugin
      "saadparwaiz1/cmp_luasnip", --> Snippets source for nvim-cmp
      "hrsh7th/cmp-nvim-lsp", --> LSP source for nvim-cmp
      "hrsh7th/cmp-path",
      "rafamadriz/friendly-snippets", --> Adds a number of user-friendly preconfigured snippets for different languages
      "onsails/lspkind.nvim", --> vscode-like pictograms for neovim lsp completion items
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      require("luasnip.loaders.from_vscode").lazy_load()
      luasnip.config.setup({})

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        mapping = require('mappings.completion').setup(),
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
          { name = "calc" },
          { name = "treesitter" },
          { name = "crates" },
          { name = "tmux" },
        },
        formatting = {
          format = function(entry, vim_item)
            local lspkind_ok, lspkind = pcall(require, "lspkind")
            if not lspkind_ok then
              -- Source
              vim_item.menu = ({
                nvim_lsp = "[LSP]",
                luasnip = "[LuaSnip]",
                buffer = "[Buffer]",
              })[entry.source.name]
              return vim_item
            else
              -- From lspkind
              return lspkind.cmp_format()(entry, vim_item)
            end
          end,
        },
      })
    end,
  }
}
