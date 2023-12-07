local M = {}
local wk = require('which-key')

M.surround = function()
  return wk.register({
    {
      mode = 'n',
      prefix = 'g',
      ['z'] = {
        name = '+surround',
        '<Plug>(nvim-surround-normal)', 'Surround',
        ['z'] = { '<Plug>(nvim-surround-normal-cur)', 'Surround - same line' },
        ['d'] = { '<Plug>(nvim-surround-delete)', 'Delete surround' },
        ['r'] = { '<Plug>(nvim-surround-change)', 'Change surround' },
        ['c'] = { '<Plug>(nvim-surround-change)', 'Change surround' },
      },
      ['Z'] = {
        name = '+surround-line',
        '<Plug>(nvim-surround-normal-line)', 'Surround, - new lines',
        ['Z'] = { '<Plug>(nvim-surround-normal-cur-line)', 'Surround - same line' },
        ['R'] = { '<Plug>(nvim-surround-change-line)', 'Change surround, - new lines' },
        ['C'] = { '<Plug>(nvim-surround-change-line)', 'Change surround, - new lines' },
      },
    },
    {
      mode = 'x',
      ['gz'] = { '<Plug>(nvim-surround-visual)', 'Add a surrounding pair' },
      ['gZ'] = { '<Plug>(nvim-surround-visual-line)', 'Add a surrounding pair around a motion, on new lines' },
    },
    {
      mode = 'i',
      ['<C-g>z'] = { '<Plug>(nvim-surround-insert)', 'Add a surrounding pair around the cursor' },
      ['<C-g>Z'] = { '<Plug>(nvim-surround-insert-line)', 'Add a surrounding pair around the cursor, on new lines' },
    }
  })
end

M.commentary = function()
  return wk.register({
    {
      mode = 'n',
      prefix ='g',
      ['c'] = { 
        name ="+comment",
        '<Plug>Commentary', 'Toggle comment',
        ['c'] = { '<Plug>CommentaryLine', 'Toggle comment - line' },
        ['u'] = { '<Plug>Commentary<Plug>Commentary', 'Uncomment current and adjacent lines' },
      }
    },
    {
      ['gc'] = { '<Plug>Commentary', 'Toggle comment highlighted lines', mode='x' },
      ['gc'] = { '<Plug>Commentary', 'Comment', mode='o' },
    }
  })
end

return M
