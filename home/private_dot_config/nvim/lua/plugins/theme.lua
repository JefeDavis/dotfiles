return {
  {
    'catppuccin/nvim',
    cond = function ()
      local theme = os.getenv("THEME")
      return theme == 'Catppuccin-Mocha' or theme == nil
    end,
    config = function ()
      require("catppuccin").setup({
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        background = { -- :h background
            light = "latte",
            dark = "mocha",
        },
        transparent_background = true,
        integrations = {
          leap = true,
          telescope = true,
          which_key = true,
        },
        highlight_overrides = {
          all = function(colors)
            return {
              Comment     = { fg = colors.gray2, style = {"italic"} },
              PMenu       = { fg = colors.gray2, bg = "NONE" },
              NormalFloat = { fg = colors.gray2, bg = colors.black2 },
              TSProperty  = { fg = colors.rosewater }
            }
          end,
        },
      })

      vim.cmd('colorscheme catppuccin')
    end,
    name = 'catppuccin',
    priority = 1000
  }
}
