local M = {}

function M.config(_, opts)
  local palette = require('catppuccin.palettes').get_palette()
  local feline = require('feline')
  local vi_mode = require('feline.providers.vi_mode')
  local file = require('feline.providers.file')
  local lsp = require('feline.providers.lsp')
  local lsp_severity = vim.diagnostic.severity
  local separators = require('feline.defaults').statusline.separators.default_value

  local mode_colors = {
    ["n"] = { "NORMAL", palette.lavender },
    ["no"] = { "N-PENDING", palette.lavender },
    ["i"] = { "INSERT", palette.green },
    ["ic"] = { "INSERT", palette.green },
    ["t"] = { "TERMINAL", palette.green },
    ["v"] = { "VISUAL", palette.flamingo },
    ["V"] = { "V-LINE", palette.flamingo },
    [""] = { "V-BLOCK", palette.flamingo },
    ["R"] = { "REPLACE", palette.maroon },
    ["Rv"] = { "V-REPLACE", palette.maroon },
    ["s"] = { "SELECT", palette.maroon },
    ["S"] = { "S-LINE", palette.maroon },
    [""] = { "S-BLOCK", palette.maroon },
    ["c"] = { "COMMAND", palette.peach },
    ["cv"] = { "COMMAND", palette.peach },
    ["ce"] = { "COMMAND", palette.peach },
    ["r"] = { "PROMPT", palette.teal },
    ["rm"] = { "MORE", palette.teal },
    ["r?"] = { "CONFIRM", palette.mauve },
    ["!"] = { "SHELL", palette.green },
  }

  local test_colors = {
    init = { " ", palette.overlay1 },
    passing = { " ", palette.green },
    running = { " ", palette.yellow },
    failing = { " ", palette.maroon },
  }

  -- Settings
  local sett = {
    text = palette.mantle,
    bkg = palette.mantle,
    branch = palette.rosewater,
    diffs = palette.mauve,
    extras = palette.overlay1,
    loader = palette.rosewater,
    errors = palette.red,
    warnings = palette.yellow,
    info = palette.sky,
    hints = palette.rosewater,
    macro = palette.lavender,
    curr_file = palette.maroon,
    curr_dir = palette.flamingo,
  }
  
  if require('catppuccin').options.transparent_background then
    sett.bkg = "NONE"
  end

-- Helpers
  local function any_git_changes()
    local gst = vim.b.gitsigns_status_dict -- git stats
    if gst then
      if
        gst["added"] and gst["added"] > 0
        or gst["removed"] and gst["removed"] > 0
        or gst["changed"] and gst["changed"] > 0
      then
        return true
      end
    end
    return false
  end

local testing_status = 'init'

local set_testing_status = function(value)
  testing_status = value
end
  
local neomake_on_job_started = function ()
  set_testing_status('running')
end

local neomake_on_job_ended = function ()
  local context = g.neomake_hook_context

  if context.jobinfo.exit_code == 0 then
    set_testing_status('passing')
  elseif context.jobinfo.exit_code == 1 then
    set_testing_status('failing')
  end
end

    -- AutoCommands
  local neomake_hooks = vim.api.nvim_create_augroup("MyNeomakeHooks", { clear = true })

  vim.api.nvim_create_autocmd("User", { pattern = "NeomakeJobStarted", callback = neomake_on_job_started, group = neomake_hooks })
  vim.api.nvim_create_autocmd("User", { pattern = "NeomakeJobFinished", callback = neomake_on_job_ended, group = neomake_hooks })

  -- Config
  local c = {
    -- Left
    vim_mode = {
      provider = function ()
        return " " .. mode_colors[vim.fn.mode()][1] .. " "
      end,
      hl = function()
        return {
          fg = sett.text,
          bg = mode_colors[vim.fn.mode()][2],
          style = "bold",
        }
      end,
      icon = "  ",
      left_sep = {
        str = separators.left_rounded,
        hl = function()
          return {
            fg = mode_colors[vim.fn.mode()][2],
            bg = sett.bkg,
          }
        end
      },
      right_sep = {
        str = separators.slant_right,
        hl = function()
          if vim.b.gitsigns_head then
            return {
              fg = mode_colors[vim.fn.mode()][2],
              bg = sett.branch,
            }
          end
          return {
            fg = mode_colors[vim.fn.mode()][2],
            bg = sett.bkg,
          }
        end
      }
    },

    branch = {
      provider = "git_branch",
      hl = {
        fg = sett.text,
        bg = sett.branch,
      },
      right_sep = {
        str = separators.slant_right,
        hl = function()
          if any_git_changes() then
            return {
              fg = sett.branch,
              bg = sett.diffs,
            }
          end
          return {
            fg = sett.branch,
            bg = sett.bkg,
          }
        end,
      }
    },

    diff = {
      added = {
        provider = "git_diff_added",
        hl = {
          fg = sett.text,
          bg = sett.diffs,
        },
        icon = ' ',
      },

      changed = {
        provider = "git_diff_changed",
        hl = {
          fg = sett.text,
          bg = sett.diffs,
        },
        icon = ' ',
      },

      removed = {
        provider = "git_diff_removed",
        hl = {
          fg = sett.text,
          bg = sett.diffs,
        },
        icon = ' ',
      },

      right_sep = {
        provider = separators.slant_right,
        hl = {
          fg = sett.diffs,
          bg = sett.bkg,
        },
        enabled = function()
          return any_git_changes()
        end,
      }
    },

    file_progress = {
      provider = function()
        local current_line = vim.fn.line(".")
        local total_line = vim.fn.line("$")

        if current_line == 1 then
          return ' Top '
        elseif current_line == vim.fn.line("$") then
          return 'Bot '
        end

        local result, _ = math.modf((current_line / total_line) * 100)
        return " " .. result .. "%%"
      end,
      hl = {
        fg = sett.extras,
        bg = sett.bkg,
      },
      left_sep = {
        str = ' ',
        hl = {
          fg = sett.text,
          bg = sett.bkg,
        }
      }
    },

    position = {
      provider = "position",
      hl = {
        fg = sett.extras,
        bg = sett.bkg,
      },
      left_sep = {
        str = ' ',
        hl = {
          fg = sett.text,
          bg = sett.bkg,
        }
      }
    },

    -- Center
    lsp_loader = {
      provider = function()
        local lspm = vim.lsp.util.get_progress_messages()[1]

        if lspm then
          local msg = lspm.message or ""
          local percentage = lspm.percentage or 0
          local title = lspm.title or ""
          local spinners = {
            " ",
            " ",
            " ",
          }
          local success_icon = {
            " ",
            " ",
            " ",
          }
          local ms = vim.loop.hrtime() / 1000000
          local frame = math.floor(ms / 120) % #spinners

          if percentage >= 70 then
            return string.format(" %%<%s %s %s (%s%%%%) ", success_icon[frame + 1], title, msg, percentage)
          end

          return string.format(" %%<%s %s %s (%s%%%%) ", spinners[frame + 1], title, msg, percentage)
        end

        return ""
      end,
      hl = {
        fg = sett.loader,
        bg = sett.bkg,
      }
    },

    diagnostics = {
      errors = {
        provider = "diagnostic_errors",
        enabled = function()
          return lsp.diagnostics_exist(lsp_severity.ERROR)
        end,

        hl = {
          fg = sett.errors,
          bg = sett.bkg,
        },
        icon = " ",
      },

      warnings = {
        provider = "diagnostic_warnings",
        enabled = function()
          return lsp.diagnostics_exist(lsp_severity.WARN)
        end,
        hl = {
          fg = sett.warnings,
          bg = sett.bkg,
        },
        icon = " ",
      },

      info = {
        provider = "diagnostic_info",
        enabled = function()
          return lsp.diagnostics_exist(lsp_severity.INFO)
        end,
        hl = {
          fg = sett.info,
          bg = sett.bkg,
        },
        icon = " ",
      },

      hints = {
        provider = "diagnostic_hints",
        enabled = function()
          return lsp.diagnostics_exist(lsp_severity.HINT)
        end,
        hl = {
          fg = sett.hints,
          bg = sett.bkg,
        },
        icon = "󰠠 ",
      }
    },

    -- Right
    testing = {
      provider = function()
        return test_colors[testing_status][1]
      end,
      hl = function()
        return {
          fg = test_colors[testing_status][2],
          bg = sett.bkg,
        }
      end,
    },

    lsp_status = {
      provider = " 󰐻 ",
      hl = function()
        if lsp.is_lsp_attached() then
          return {
            fg = sett.info,
            bg = sett.bkg,
          }
        end
        return {
          fg = sett.extras,
          bg = sett.bkg,
        }
      end,
    },
    
    macro = {
      provider = function()
        local recording_register = vim.fn.reg_recording()
        if #recording_register == 0 then
          return ''
        end
        return string.format(' 󰁥 %s ', recording_register)
      end,
      hl = {
        fg = sett.text,
        bg = sett.macro,
      },
      left_sep = {
        always_visible = true,
        str = separators.slant_left,
        hl = {
          fg = sett.macro,
          bg = sett.bkg,
        }
      }
    },

    filename = {
      provider = {
        name = "file_info",
        opts = {
          colored_icon = false,
          file_readonly_icon = "󰌾 ",
          file_modified_icon = " ",
        }
      },
      hl = {
        fg = sett.text,
        bg = sett.curr_file,
      },
      left_sep = {
        str = separators.slant_left .. separators.block,
        hl = {
          fg = sett.curr_file,
          bg = sett.macro,
        }
      }
    },

    directory = {
      provider = function()
        local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
        return "  " .. dir_name
      end,
      hl = {
        fg = sett.text,
        bg = sett.curr_dir,
      },
      left_sep = {
        str = separators.slant_left,
        hl = {
          fg = sett.curr_dir,
          bg = sett.curr_file,
        }
      },
      right_sep = {
        str = separators.right_rounded,
        hl = {
          fg = sett.curr_dir,
          bg = sett.bkg,
        }
      }
    },
    window = {
      provider = function()
        return string.upper(vim.bo.ft) .. " "
      end,
      icon = '  ',
      hl = {
        fg = sett.text,
        bg = sett.curr_file,
        style= 'bold',
      },
      left_sep = {
        str = separators.left_rounded,
        hl = {
          fg = sett.curr_file,
          bg = sett.bkg,
        }
      },
      right_sep = {
        str = separators.right_rounded,
        hl = {
          fg = sett.curr_file,
          bg = sett.bkg,
        }
      }
    }
  }

  local active = {
    { -- left
      c.vim_mode,
      c.branch,
      c.diff.added,
      c.diff.changed,
      c.diff.removed,
      c.diff.right_sep,
      c.file_progress,
      c.position,
    },

    { -- center
      c.lsp_loader,
      c.diagnostics.errors,
      c.diagnostics.warnings,
      c.diagnostics.info,
      c.diagnostics.hints,
    },

    { -- right
      c.testing,
      c.lsp_status,
      c.macro,
      c.filename,
      c.directory,
    },
  }

  local inactive = {
    { -- left
    },
    
    { --center
    },

    { -- right
      c.window,
    },
  }

  local components = {
    active = active,
    inactive = inactive,
    force_inactive = {
        filetypes = {
            '^lazy$',
            '^nnn$',
            '^NvimTree$',
            '^packer$',
            '^startify$',
            '^fugitive$',
            '^fugitiveblame$',
            '^qf$',
            '^help$',
        },
        buftypes = {
            '^terminal$',
            '^nofile$',
        },
        bufnames = {}
    }
  }

  return components
end

return M
