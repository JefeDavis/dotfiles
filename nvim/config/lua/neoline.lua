local testing = require('testing')
local gl = require('galaxyline')
local condition = require('galaxyline.condition')
local vcs = require('galaxyline.provider_vcs')
local file = require('galaxyline.provider_fileinfo')
local gls = gl.section
gl.short_line_list = {'NvimTree','vista_kind','dbui'}

local colors = {
  bg = "#2d2b40",
  bg_dark = "#1e1c31",
  bg_alt = "#3e3859",
  fg = "#cbe3e7",
  fg_dark = "#8A889D",

}

-- Read from testing.lua module
-- and adjust icon and color per testing state
local testing_results = function ()
  if testing.TESTING_STATUS == 'init' then
    return " "
  elseif testing.TESTING_STATUS == 'passing' then
    return " "
  elseif testing.TESTING_STATUS == 'running' then
    return " "
  elseif testing.TESTING_STATUS == 'failing' then
    return " "
  end

end


-----------------------------------------------------------
-- Bar Sections
-----------------------------------------------------------

-- LEFT
-----------------------------------------------------------
gls.left[1] = {
  FileName = {
    icon = function()
      return file.get_file_icon()
    end,
    provider = function()
      if condition.buffer_not_empty() then
        return  file.get_current_file_name() .. ' '
      else
        return 'SCRATCH '
      end
    end,
    highlight = { colors.fg_dark, colors.bg_dark },
    separator = '',
    separator_highlight = {colors.bg, colors.bg_dark}
  }
}

gls.left[2] = {
  GitBranch = {
    provider = function()
      if vcs.get_git_branch() then
        return vcs.get_git_branch() .. ' '
      else
        return '· '
      end
    end,
    icon = '  ',
    highlight = { colors.fg_dark, colors.bg },
    separator = '',
    separator_highlight = {colors.bg, colors.bg_alt }
  }
}

gls.left[3] = {
  GitDiffAdded = {
    icon = '   ',
    provider = function()
      if vcs.diff_add() then
        return vcs.diff_add() .. ' '
      else
        return '· '
      end
    end,
    highlight = { colors.fg_dark, colors.bg_alt }
  }
}

gls.left[4] = {
  GitDiffChanged = {
    icon = '   ',
    provider = function()
      if vcs.diff_modified() then
        return vcs.diff_modified() .. ' '
      else
        return '· '
      end
    end,
    highlight = { colors.fg_dark, colors.bg_alt }
 
  }
}

gls.left[5] = {
  GitDiffRemoved = {
    icon = '   ',
    provider = function()
      if vcs.diff_remove() then
        return vcs.diff_remove() .. ' '
      else
        return '· '
      end
    end,
    highlight = { colors.fg_dark, colors.bg_alt },
    separator = '',
    separator_highlight = { colors.bg_alt , colors.bg_dark }
  }
}

-- RIGHT
-----------------------------------------------------------

gls.right[1] = {
  LanguageServer = {
    provider = function()
      active_client = vim.lsp.buf_get_clients()[1]
      if active_client ~= nil then
        return '  鷺  '
      else
        return '  '
      end
    end,
    highlight = { colors.fg_dark, colors.bg_alt },
    separator = '',
    separator_highlight = { colors.bg_alt , colors.bg_dark }
  }
}

gls.right[2] = {
  TestResults = {
    provider = testing_results,
    highlight = { colors.fg_dark, colors.bg },
    separator = '',
    separator_highlight = {  colors.bg , colors.bg_alt }
  }
}

gls.right[3] = {
  Position = {
    provider = function()
      local line = vim.fn.line('.')
      local col = vim.fn.col('.')
      return ' ' .. line .. ':' .. col .. ' '
    end,
    highlight = { colors.fg_dark, colors.bg_dark },
    separator = '',
    separator_highlight = { colors.bg, colors.bg_dark }
  }
}


-- SHORTLINE
-----------------------------------------------------------
gls.short_line_left[1] = {
  FileName = {
    provider = 'FileName',
    highlight = "PreProc"
  }
}
