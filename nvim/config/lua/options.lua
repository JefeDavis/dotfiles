-- Set editor options in lua
local opt = vim.opt

-- SPACING AND INDENTATION
-- ===================================================================
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true
opt.autoindent = true
opt.wrap = true
opt.linebreak = true

-- UI CONFIG
-- ===================================================================
-- gutters, line numbers, searching
opt.termguicolors = true
opt.conceallevel = 2
opt.encoding = "utf8"
opt.number = true
opt.relativenumber = true
opt.ruler = true
opt.cursorline = true
-- when typing a bracket highlight the match
opt.showmatch = true
-- no idea what this does?
opt.list = true
-- list chars for 'hidden' characters
opt.lcs = "eol:¬,extends:❯,precedes:❮,tab:>-"
opt.fillchars = { diff = "/", fold = "." }
-- alsways show symbol gutter (I hate seeing the editor shift)
opt.signcolumn = 'yes'
-- highlight words that match / search
opt.hlsearch = true
-- start hlsearch as I type
opt.incsearch = true
-- search case insensitive until I add a capital letter
opt.ignorecase = true
opt.smartcase = true
-- show effects of substitution as I perform it
opt.inccommand = "nosplit"
-- Don't show what mode I am in
-- My statusline will tell me this not the editor
opt.showmode = false
opt.cmdheight = 1
-- how often to poll for updates
-- affects things like gutter symbols
opt.updatetime = 300
opt.lazyredraw = true
-- fix the crazy default behavior of how splits are created
opt.splitbelow = true
opt.splitright = true
-- MENUS
opt.wildmenu = true
opt.completeopt = "menuone,menu,noselect,noinsert"
opt.history = 100
opt.shortmess = 'FWco'
opt.modeline = true
opt.laststatus = 3

-- FOLDING
-- ===================================================================
opt.foldenable = true
opt.foldlevelstart = 10
opt.foldnestmax = 10
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

--MOUSE
--====================================================================
opt.mouse = 'a'


-- BACKUP/SWAP
--====================================================================
-- I also live to live dangerously
opt.backup = false
opt.writebackup = false
opt.swapfile = false

if vim.fn.executable("rg") then
    vim.o.greprg= "rg --vimgrep --hidden -g !.git"
end

--define the leaders
vim.g.mapleader = " "
vim.g.maplocalleader = "-"
