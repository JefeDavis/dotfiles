local wk = require("which-key")

wk.register(
  {
    ["\\"] = { "<CMD>NnnExplorer<CR>", "Open File Explorer in side pane", mode={"n","t"} },
    ["<BAR>"] = { "<CMD>NnnPicker %:p<CR>", "Open File Explorer in floating window" },
    ["_"] = { ":silent grep ", "Live Grep", silent=true },
  },
  {
    prefix = "<leader>",
  }
)
