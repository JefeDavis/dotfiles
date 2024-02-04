-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
local unmap = vim.keymap.del
local wk = require("which-key")

--Buffer Navigation
map("n", "<leader>bh", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "<leader>bl", "<cmd>bnext<cr>", { desc = "Next buffer" })
unmap("n", "<S-h>")
unmap("n", "<S-l>")

-- Move Lines
map("n", "J", "mzJ`z", { desc = "Join line" })
map("v", "J", ":move '>+1<CR>gv=gv", { desc = "Move highlight group down" })
map("v", "K", ":move '<-2<CR>gv=gv", { desc = "Move highlight group up" })
unmap({ "n", "i", "v" }, "<A-j>")
unmap({ "n", "i", "v" }, "<A-k>")

-- tabs
map("n", "<leader><tab>$", "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", "<leader><tab>^", "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader><tab>l", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
map("n", "<leader><tab>h", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
unmap("n", "<leader><tab>f")
