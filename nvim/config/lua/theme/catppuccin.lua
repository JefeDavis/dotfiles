local catppuccin = require("catppuccin")
local colors = require("catppuccin.palettes").get_palette "macchiato"

catppuccin.setup {
  transparent_background = true,
  styles = {
    comments = {"italic"},
    functions ={},
    keywords = {},
    strings ={},
    variables = {"italic"},
  },
  integrations = {
    treesitter = true,
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = {"italic"},
        hints = {"italic"},
        warnings = {"italic"},
        information = {"italic"},
      },
      underlines = {
        errors = {"underline"},
        hints = {"underline"},
        warnings = {"underline"},
        information = {"underline"},
      },
    },
    lsp_trouble = false,
    cmp = true,
    lsp_saga = false,
    gitgutter = true,
    gitsigns = true,
    telescope = true,
    nvimtree = {
      enabled = true,
      show_root = false,
      transparent_panel = false,
    },
    neotree = {
      enabled = false,
      show_root = false,
      transparent_panel = false,
    },
    which_key = false,
    indent_blankline = {
      enabled = true,
      colored_indent_levels = false,
    },
    dashboard = true,
    neogit = false,
    vim_sneak = false,
    fern = false,
    barbar = false,
    bufferline = true,
    markdown = true,
    lightspeed = true,
    ts_rainbow = false,
    hop = false,
    notify = true,
    telekasten = true,
    symbols_outline = true,
  }
}

catppuccin.before_loading = function()
  catppuccin.remap(
    {
      Comment     = { fg = colors.gray2, style = {"italic"} },
      PMenu       = { fg = colors.gray2, bg = "NONE" },
      NormalFloat = { fg = colors.gray2, bg = colors.black2 },
      TSProperty  = { fg = colors.rosewater }
      -- goTSType = { fg = colors.teal },
      -- goTSTypeBuiltin = { fg = colors.teal, style = "bold" }
    }
  )
end

vim.cmd[[colorscheme catppuccin]]
vim.cmd[[silent ! kitty @ set-colors --all ~/.config/kitty/catppuccin.conf]]
vim.cmd[[silent ! tmux source-file ~/.config/tmux/catppuccin.tmux]]
