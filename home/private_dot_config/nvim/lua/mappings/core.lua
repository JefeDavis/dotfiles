local map = vim.keymap.set
local util = require("lazyvim.util")
local M = {}

function M.Buffers()
	-- buffers
	map("n", "<leader>bh", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
	map("n", "<leader>bl", "<cmd>bnext<cr>", { desc = "Next buffer" })
	map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
	map("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
	map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
	map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
end

function M.Tabs()
	-- tabs
	map("n", "<leader><tab>$", "<cmd>tablast<cr>", { desc = "Last Tab" })
	map("n", "<leader><tab>^", "<cmd>tabfirst<cr>", { desc = "First Tab" })
	map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
	map("n", "<leader><tab>l", "<cmd>tabnext<cr>", { desc = "Next Tab" })
	map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
	map("n", "<leader><tab>h", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
	map("n", "]<tab>", "<cmd>tabnext<cr>", { desc = "Next Tab" })
	map("n", "[<tab>", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
end

function M.Windows()
	-- windows
	map("n", "<leader>ww", "<C-W>p", { desc = "Other window", remap = true })
	map("n", "<leader>wd", "<C-W>c", { desc = "Delete window", remap = true })
	map("n", "<leader>w-", "<C-W>s", { desc = "Split window below", remap = true })
	map("n", "<leader>w|", "<C-W>v", { desc = "Split window right", remap = true })
	map("n", "<leader>ws", "<C-W>s", { desc = "Split window below", remap = true })
	map("n", "<leader>wv", "<C-W>v", { desc = "Split window right", remap = true })
	map("n", "<leader>-", "<C-W>s", { desc = "Split window below", remap = true })
	map("n", "<leader>|", "<C-W>v", { desc = "Split window right", remap = true })
	map("n", "<leader>wh", "<C-w>h", { desc = "Go to left window", remap = true })
	map("n", "<leader>wj", "<C-w>j", { desc = "Go to lower window", remap = true })
	map("n", "<leader>wk", "<C-w>k", { desc = "Go to upper window", remap = true })
	map("n", "<leader>wl", "<C-w>l", { desc = "Go to right window", remap = true })

	-- Resize window using <ctrl> arrow keys
	map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
	map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
	map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
	map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })
end

function M.Diagnostics()
	-- diagnostic
	local diagnostic_goto = function(next, severity)
		local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
		severity = severity and vim.diagnostic.severity[severity] or nil
		return function()
			go({ severity = severity })
		end
	end
	map("n", "<leader>xx", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
	map("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
	map("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
	map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
	map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
	map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
	map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })
	map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
	map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })
	map("n", "[q", vim.cmd.cprev, { desc = "Previous quickfix" })
	map("n", "]q", vim.cmd.cnext, { desc = "Next quickfix" })
end

function M.Terminal()
	-- floating terminal
	local lazyterm = function()
		util.terminal(nil, { cwd = util.root() })
	end
	map("n", "<leader>ft", lazyterm, { desc = "Terminal (root dir)" })
  -- stylua: ignore
	map("n", "<leader>fT", function() util.terminal() end, { desc = "Terminal (cwd)" })
	map("n", "<C-/>", lazyterm, { desc = "Terminal (root dir)" })
	map("n", "<C-_>", lazyterm, { desc = "which_key_ignore" })

	-- Terminal Mappings
	map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
	map("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go to left window" })
	map("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go to lower window" })
	map("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go to upper window" })
	map("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go to right window" })
	map("t", "<C-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })
	map("t", "<C-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })
end

function M.Git()
	-- lazygit
	map("n", "<leader>gg", function()
		util.terminal({ "lazygit" }, { cwd = util.root(), esc_esc = false, ctrl_hjkl = false })
	end, { desc = "Lazygit (root dir)" })
	map("n", "<leader>gG", function()
		util.terminal({ "lazygit" }, { esc_esc = false, ctrl_hjkl = false })
	end, { desc = "Lazygit (cwd)" })
end

function M.Lazy()
	-- Lazy UI
	map("n", "<leader>lu", "<cmd>Lazy<cr>", { desc = "Lazy" })
	-- LazyVim Changelog
	map("n", "<leader>lc", function()
		util.news.changelog()
	end, { desc = "LazyVim Changelog" })
end

function M.Search()
	-- Clear search with <esc>
	map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

	-- Clear search, diff update and redraw
	-- taken from runtime/lua/_editor.lua
	map(
		"n",
		"<leader>ur",
		"<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
		{ desc = "Redraw / clear hlsearch / diff update" }
	)

	-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
	map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next search result" })
	map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
	map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
	map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev search result" })
	map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
	map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
end

function M.Editing()
	-- Add undo break-points
	map("i", ",", ",<c-g>u")
	map("i", ".", ".<c-g>u")
	map("i", ";", ";<c-g>u")

	--keywordprg
	map("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg" })

	-- better indenting
	map("v", "<", "<gv")
	map("v", ">", ">gv")

	-- formatting
	map({ "n", "v" }, "<leader>cf", function()
		util.format({ force = true })
	end, { desc = "Format" })
	--
	-- Move Lines
	map("n", "J", "mzJ`z", { desc = "Join line" })
	map("v", "J", ":move '>+1<CR>gv=gv", { desc = "Move highlight group down" })
	map("v", "K", ":move '<-2<CR>gv=gv", { desc = "Move highlight group up" })

	-- new file
	map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

	-- quit
	map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

	-- better up/down
	map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
	map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
	map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
	map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
end

function M.UI()
  -- stylua: ignore start
  -- toggle options
  map("n", "<leader>uf", function() util.format.toggle() end, { desc = "Toggle auto format (global)" })
  map("n", "<leader>uF", function() util.format.toggle(true) end, { desc = "Toggle auto format (buffer)" })
  map("n", "<leader>us", function() util.toggle("spell") end, { desc = "Toggle Spelling" })
  map("n", "<leader>uw", function() util.toggle("wrap") end, { desc = "Toggle Word Wrap" })
  map("n", "<leader>ul", function() util.toggle.number() end, { desc = "Toggle Line Numbers" })
  map("n", "<leader>uL", function() util.toggle("relativenumber") end, { desc = "Toggle Relative Line Numbers" })
  map("n", "<leader>ux", function() util.toggle.diagnostics() end, { desc = "Toggle Diagnostics" })
  local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
  map("n", "<leader>uc", function() util.toggle("conceallevel", false, {0, conceallevel}) end, { desc = "Toggle Conceal" })
  if vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint then
    map( "n", "<leader>uh", function() util.toggle.inlay_hints() end, { desc = "Toggle Inlay Hints" })
  end
  ---@diagnostic disable-next-line: undefined-field 
  map("n", "<leader>uT", function() if vim.b.ts_highlight then vim.treesitter.stop() else vim.treesitter.start() end end, { desc = "Toggle Treesitter Highlight" })
	map("n", "<leader>ub", function()
		util.toggle("background", false, { "light", "dark" })
	end, { desc = "Toggle Background" })

	-- highlights under cursor
	map("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })
end

function M.LoadMappings()
	M.Buffers()
	M.Tabs()
	M.Windows()
	M.Terminal()
	M.UI()
	M.Editing()
	M.Diagnostics()
	M.Git()
	M.Lazy()
	M.Search()
end

return M
