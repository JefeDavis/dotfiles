local lsp = require("feline.providers.lsp")
local testing = require('testing')
local lsp_severity = vim.diagnostic.severity
local b = vim.b

local assets = {
	left_semicircle = "",
	right_semicircle = "",
	right_semicircle_cut = "",
	left_semicircle_cut = "",
	vertical_bar_chubby = "█",
	vertical_bar_medium = "┃",
	vertical_bar_thin = "│",
	left_arrow_thin = "",
	right_arrow_thin = "",
	left_arrow_filled = "",
	right_arrow_filled = "",
	slant_left = "",
	slant_left_thin = "",
	slant_right = "",
	slant_right_thin = "",
	slant_left_2 = "",
	slant_left_2_thin = "",
	slant_right_2 = "",
	slant_right_2_thin = "",
	chubby_dot = "●",
	slim_dot = "•",
}

local clrs = require("catppuccin.core.color_palette")

-- settings
local sett = {
	bkg = clrs.black2,
	diffs = clrs.mauve,
	extras = clrs.gray1,
	curr_file = clrs.maroon,
	curr_dir = clrs.flamingo,
}

local mode_colors = {
	["n"] = { "NORMAL", clrs.lavender },
	["no"] = { "N-PENDING", clrs.lavender },
	["i"] = { "INSERT", clrs.green },
	["ic"] = { "INSERT", clrs.green },
	["t"] = { "TERMINAL", clrs.green },
	["v"] = { "VISUAL", clrs.flamingo },
	["V"] = { "V-LINE", clrs.flamingo },
	[""] = { "V-BLOCK", clrs.flamingo },
	["R"] = { "REPLACE", clrs.maroon },
	["Rv"] = { "V-REPLACE", clrs.maroon },
	["s"] = { "SELECT", clrs.maroon },
	["S"] = { "S-LINE", clrs.maroon },
	[""] = { "S-BLOCK", clrs.maroon },
	["c"] = { "COMMAND", clrs.peach },
	["cv"] = { "COMMAND", clrs.peach },
	["ce"] = { "COMMAND", clrs.peach },
	["r"] = { "PROMPT", clrs.teal },
	["rm"] = { "MORE", clrs.teal },
	["r?"] = { "CONFIRM", clrs.mauve },
	["!"] = { "SHELL", clrs.green },
}

 local test_colors = {
   init = { " ", clrs.gray1 },
   passing = { " ", clrs.green },
   running = { " ", clrs.yellow },
   failing = { " ", clrs.maroon }
 }

local shortline = false

local function is_enabled(is_shortline, winid, min_width)
	if is_shortline then
		return true
	end

	winid = winid or 0
	return vim.api.nvim_win_get_width(winid) > min_width
end

-- Initialize the components table
local components = {
	active = {},
	inactive = {},
}

table.insert(components.active, {}) -- (1) left
table.insert(components.active, {}) -- (2) center
table.insert(components.active, {}) -- (3) right

-- global components
local invi_sep = {
	str = " ",
	hl = {
		fg = sett.bkg,
		bg = sett.bkg,
	},
}

-- helpers
local function any_git_changes()
	local gst = b.gitsigns_status_dict -- git stats
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

-- #################### STATUSLINE ->

-- ######## Left

-- Current vi mode ------>
local vi_mode_hl = function()
	return {
		fg = sett.bkg,
		bg = mode_colors[vim.fn.mode()][2],
		style = "bold",
	}
end

components.active[1][1] = {
	provider = assets.vertical_bar_chubby,
	hl = function()
		return {
			fg = mode_colors[vim.fn.mode()][2],
			bg = sett.bkg,
		}
	end,
}

components.active[1][2] = {
	provider = function()
		return " " .. mode_colors[vim.fn.mode()][1] .. " "
	end,
	hl = vi_mode_hl,
	icon = "  ",
	right_sep = {
    str = assets.slant_right,
    hl  = function()
      if b.gitsigns_head then
        return {
          fg = mode_colors[vim.fn.mode()][2],
          bg = clrs.flamingo,
        }
      end
      return {
        fg = mode_colors[vim.fn.mode()][2],
        bg = sett.bkg
      }
    end
  },
}

components.active[1][3] = {
	provider = "git_branch",
	enabled = is_enabled(shortline, winid, 70),
	hl = {
		fg = sett.bkg,
		bg = clrs.flamingo,
	},
	icon = "  ",
	left_sep = {
    str = assets.slant_right,
    hl  = function()
      return {
        fg = mode_colors[vim.fn.mode()][2],
        bg = clrs.flamingo
      }
    end
  },
  right_sep = {
    str = assets.slant_right,
    hl  = function()
      if any_git_changes() then
        return {
          fg = clrs.flamingo,
          bg = sett.diffs,
        }
      end
      return {
        fg = clrs.flamingo,
        bg = sett.bkg
      }
    end
  }
}

-- there is a dilema: we need to hide Diffs if ther is no git info. We can do that, but this will
-- leave the right_semicircle colored with purple, and since we can't change the color conditonally
-- then the solution is to create two right_semicircles: one with a mauve sett.bkg and the other one normal
-- sett.bkg; both have the same fg (vi mode). The mauve one appears if there is git info, else the one with
-- the normal sett.bkg appears. Fixed :)

-- enable if git diffs are not available
-- components.active[1][4] = {
-- 	str = assets.slant_right,
-- 	hl = function()
-- 		return {
-- 			fg = clrs.flamingo,
-- 			bg = sett.bkg,
-- 		}
-- 	end,
-- 	enabled = function()
-- 		return not any_git_changes()
-- 	end,
-- }

-- -- enable if git diffs are available
-- components.active[1][5] = {
-- 	provider = assets.slant_right,
-- 	hl = function()
-- 		return {
-- 			fg = clrs.flamingo,
-- 			bg = sett.diffs,
-- 		}
-- 	end,
-- 	enabled = function()
-- 		return any_git_changes()
-- 	end,
-- }
-- Current vi mode ------>


-- Diffs ------>
components.active[1][4] = {
	provider = "git_diff_added",
	hl = {
		fg = sett.bkg,
		bg = sett.diffs,
	},
	icon = '   ',
}

components.active[1][5] = {
	provider = "git_diff_changed",
	hl = {
		fg = sett.bkg,
		bg = sett.diffs,
	},
	icon = '   ',
}

components.active[1][6] = {
	provider = "git_diff_removed",
	hl = {
		fg = sett.bkg,
		bg = sett.diffs,
	},
	icon = '    ',
}

components.active[1][7] = {
	provider = assets.slant_right,
	hl = {
		fg = sett.diffs,
		bg = sett.bkg,
	},
	enabled = function()
		return any_git_changes()
	end,
}
-- Diffs ------>

-- Extras ------>

-- file progess
components.active[1][8] = {
	provider = function()
		local current_line = vim.fn.line(".")
		local total_line = vim.fn.line("$")

		if current_line == 1 then
			return " Top "
		elseif current_line == vim.fn.line("$") then
			return " Bot "
		end
		local result, _ = math.modf((current_line / total_line) * 100)
		return " " .. result .. "%% "
	end,
	-- enabled = shortline or function(winid)
	-- 	return vim.api.nvim_win_get_width(winid) > 90
	-- end,
	hl = {
		fg = sett.extras,
		bg = sett.bkg,
	},
	left_sep = invi_sep,
}

-- position
components.active[1][9] = {
	provider = "position",
	-- enabled = shortline or function(winid)
	-- 	return vim.api.nvim_win_get_width(winid) > 90
	-- end,
	hl = {
		fg = sett.extras,
		bg = sett.bkg,
	},
	left_sep = invi_sep,
}
-- Extras ------>

-- ######## Left

-- ######## Center

-- Diagnostics ------>
-- workspace loader
components.active[2][1] = {
	provider = function()
		local Lsp = vim.lsp.util.get_progress_messages()[1]

		if Lsp then
			local msg = Lsp.message or ""
			local percentage = Lsp.percentage or 0
			local title = Lsp.title or ""
			local spinners = {
				"",
				"",
				"",
			}
			local success_icon = {
				"",
				"",
				"",
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
	enabled = is_enabled(shortline, winid, 80),
	hl = {
		fg = clrs.rosewater,
		bg = sett.bkg,
	},
}

-- genral diagnostics (errors, warnings. info and hints)
components.active[2][2] = {
	provider = "diagnostic_errors",
	enabled = function()
		return lsp.diagnostics_exist(lsp_severity.ERROR)
	end,

	hl = {
		fg = clrs.red,
		bg = sett.bkg,
	},
	icon = "  ",
}

components.active[2][3] = {
	provider = "diagnostic_warnings",
	enabled = function()
		return lsp.diagnostics_exist(lsp_severity.WARN)
	end,
	hl = {
		fg = clrs.yellow,
		bg = sett.bkg,
	},
	icon = "  ",
}

components.active[2][4] = {
	provider = "diagnostic_info",
	enabled = function()
		return lsp.diagnostics_exist(lsp_severity.INFO)
	end,
	hl = {
		fg = clrs.sky,
		bg = sett.bkg,
	},
	icon = "  ",
}

components.active[2][5] = {
	provider = "diagnostic_hints",
	enabled = function()
		return lsp.diagnostics_exist(lsp_severity.HINT)
	end,
	hl = {
		fg = clrs.rosewater,
		bg = sett.bkg,
	},
	icon = "  ",
}
-- Diagnostics ------>

-- ######## Center

-- ######## Right
components.active[3][1] = {
  provider = function()
    return test_colors[testing.TESTING_STATUS][1]
  end,
  hl = function()
    return {
      fg = test_colors[testing.TESTING_STATUS][2],
      bg = sett.bkg
    }
  end,
}

components.active[3][2] = {
	provider = " 鷺",
	-- provider = "lsp_client_names",
	hl = function()
    local active_client = vim.lsp.buf_get_clients()[1]
    if active_client ~= nil then
      return {
        fg = clrs.sky,
        bg = sett.bkg
      }
    end
    return {
      fg = clrs.gray1,
      bg = sett.bkg
    }
  end
}

components.active[3][3] = {
	provider = function()
		local filename = vim.fn.expand("%:t")
		local extension = vim.fn.expand("%:e")
		local icon = require("nvim-web-devicons").get_icon(filename, extension)
		if icon == nil then
			icon = "   "
			return icon
		end
		return " " .. icon .. " " .. filename .. " "
	end,
	enabled = is_enabled(shortline, winid, 70),
	hl = {
		fg = sett.bkg,
		bg = sett.curr_file,
	},
	left_sep = {
		str = assets.slant_left,
		hl = {
			fg = sett.curr_file,
			bg = sett.bkg
		},
	},
}

components.active[3][4] = {
	provider = function()
		local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
		return "  " .. dir_name .. " "
	end,

	enabled = is_enabled(shortline, winid, 80),

	hl = {
		fg = sett.bkg,
		bg = sett.curr_dir,
	},
	left_sep = {
		str = assets.slant_left,
		hl = {
			fg = sett.curr_dir,
			bg = sett.curr_file,
		},
	},
}
-- ######## Right

return components

