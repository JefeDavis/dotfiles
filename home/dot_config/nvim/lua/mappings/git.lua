local M = {}
local Job = require('plenary.job')
local gitsigns = require('gitsigns')
local wk = require('which-key')

-- Gets the default branch for the current repository
-- `git default` is a git alias
local get_default_branch = function()
  return Job:new({ command = 'git', args = { 'default-branch' } }):sync()[1]
end

-- Do a diff split against origin's default branch
-- Can be helpful when on a long lived feature branch to see the difference of a file
local diff_against_default_branch = function()
  return vim.api.nvim_command("Gvdiffsplit origin/" .. get_default_branch() .. ":%")
end

-- GRead from origin's default branch
-- Blow away all changes from the current branch
local read_default_branch = function()
  return vim.api.nvim_command("Gread origin/" .. get_default_branch() .. ":%")
end

function M.gitsigns ()
  local function next_hunk()
    -- Move to next hunk
    gitsigns.next_hunk()
    -- center cursor
    vim.cmd('normal zz')
  end

  local function prev_hunk()
    -- Move to prev hunk
    gitsigns.prev_hunk()
    -- center cursor
    vim.cmd('normal zz')
  end

  wk.register({
    prefix = "<leader>",
    ['B'] = { gitsigns.toggle_current_line_blame, "toggle blame" },
    ['g'] = {
      name = "+git",
      ['h'] = {
        name = '+hunk',
        ['v'] = { gitsigns.preview_hunk, "preview hunk" },
        ['n'] = { next_hunk, "next git hunk" },
        ['N'] = { prev_hunk, "previous git hunk" },
        ['a'] = { gitsigns.stage_hunk, "stage hunk" },
        ['r'] = { gitsigns.undo_stage_hunk, "unstage hunk" },
        ['u'] = { gitsigns.reset_hunk, "reset hunk" },
        ['d'] = { gitsigns.toggle_current_line_blame, "toggle deleted" },
      }
    }
  })
end

function M.fugitive()
  wk.register({
    prefix = "<leader>",
    ['g'] = {
      name = "+git",
      ['g'] = { '<CMD>G<CR>', 'git tui' },
      ['s'] = { '<CMD>Git status<CR>', 'status' },
      ['o'] = { '<CMD>GBrowse<CR>', 'open in browser' },
      ['O'] = { '<CMD>GBrowse!<CR>', 'copy url to clipboard' },
      ['c'] = {
        name="+commit",
        ['c'] = { '<CMD>Git commit<CR>', 'commit' },
        ['f'] = { '<CMD>Git commit --fixup HEAD<CR>', 'fixup commit' },
        ['a'] = { '<CMD>Git commit --amend --no-edit<CR>', 'ammend commit' },
      },
      ['d'] = { 
        name = '+diff',
        ['d'] = { '<CMD>Gdiff<CR>', 'diff' },
        ['h'] = { diff_against_default_branch, 'diff against default branch' },
        ['v'] = { '<CMD>Git difftool --name-only<CR>', 'show changed files' },
        ['V'] = { '<CMD>Git difftool<CR>', 'interactive diff tool' },
      },
      ['b'] = { '<CMD>Git blame<CR>', 'blame' },
      ['w'] = { '<CMD>Gwrite<CR>', 'save and stage' },
      ['wq'] = { '<CMD>Gwq<CR>', 'save, stage, and exit' },
      ['u'] = {
        name = '+reset',
        ['r'] = { '<CMD>Gread<CR>', 'reset' },
        ['R'] = { read_default_branch, 'reset hard' },
      },
      ['l'] = { '<CMD>Gclog<CR>', 'log' },
      ['L'] = { '<CMD>0Gclog<CR>', 'log since head' },
      ['m'] = { '<CMD>GitMessenger<CR>', 'messenger' },
      ['p'] = { 
        name= '+push/pull',
        ['f'] = { '<CMD>Git fetch<CR>', 'fetch' },
        ['r'] = { '<CMD>Git pull<CR>', 'pull' },
        ['p'] = { '<CMD>Git push<CR>', 'push' },
        ['P'] = { '<CMD>Git push --force-with-lease<CR>', 'force push' },
      },
      ['r'] = {
        name = '+rebase',
        ['r'] = { '<CMD>Git rebase -i <CR>', 'rebase to since HEAD' },
        ['h'] = { '<CMD>Git rebase -i main <CR>', 'rebase to default branch' },
      },
    },
  })
end

return M
