local buffer = require('bufferline')

buffer.setup {
  options = {
    numbers = "ordinal",
    show_close_icon = false,
    tab_size = 20,
    separator_style = "thick",
    offsets = {
      {
      filetype = "nnn",
      text = "File Explorer",
      highlight = "Directory",
      text_align = "left",
      }
    },
    custom_filter = function(buf_number, buf_numbers)
      if vim.bo[buf_number].filetype ~= "nnn" then
        return true
      end
    end
  },
}
