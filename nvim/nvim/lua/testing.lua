local g = vim.g
local v = vim.v

g.VimuxOrientation = "h"
g.VimuxHeight = "30"

g["test#preserve_screen"] = false
g.neomake_open_list = true
g['test#strategy'] = {
  nearest = 'dispatch',
  file = 'dispatch',
  suite = 'vimux'
}
g['test#go#runner'] = 'gotest'
g['test#neovim#term_position'] = 'vert'
g.neomake_warning_sign = {
  text = '∙'
}
g.neomake_error_sign = {
  text = '∙'
}

--g.dispatch_compilers = {golang = 'gotest'}

local M = {}
M.TESTING_STATUS = 'init'

M.neomake_on_job_started = function ()
  M.TESTING_STATUS = 'running'
end

M.neomake_on_job_ended = function ()
  local context = g.neomake_hook_context

  if context.jobinfo.exit_code == 0 then
    M.TESTING_STATUS = 'passing'
  elseif context.jobinfo.exit_code == 1 then
    M.TESTING_STATUS = 'failing'
  end
end

-- AUTOCOMMANDS
vim.cmd([[
  augroup my_neomake_hooks
    au!
    autocmd User NeomakeJobFinished call luaeval("require('testing').neomake_on_job_ended()")
    autocmd User NeomakeJobStarted call luaeval("require('testing').neomake_on_job_started()")
  augroup END
]])


return M
