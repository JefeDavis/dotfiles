return {
  {
    'catppuccin/nvim',
    cond = function ()
      local theme = os.getenv("THEME")
      return theme == 'catppuccin' or theme == nil
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
          treesitter = true,
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
            },
            underlines = {
              errors = { "underline" },
              hints = { "underline" },
              warnings = { "underline" },
              information = { "underline" },
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
  },
  {
    'embark-theme/vim',
    cond = function()
      local theme = os.getenv("THEME")
      return theme == 'embark' or theme == nil
    end,
    config = function()
      vim.g.embark_terminal_italics = 1
      vim.cmd('colorscheme embark')
    end,
    name = 'embark'
  },
  {
    'sainnhe/everforest',
    cond = function()
      return os.getenv('THEME') == 'everforest'
    end,
    config = function()
      vim.g.everforest_background = 'hard'
      vim.cmd.colorscheme 'everforest'
    end
  },
  {
    'folke/tokyonight.nvim',
    cond = function()
      return os.getenv('THEME') == 'tokyonight-day'
    end,
    config = function()
      require 'tokyonight'.setup {
        style = 'day',
        on_highlights = function(hl, c)
          hl["@text.todo"] = {
            bg = c.purple,
            fg = "#000000"
          }
        end

      }
      vim.cmd('colorscheme tokyonight')
    end
  },
  {'mkarmona/colorsbox'}
}
