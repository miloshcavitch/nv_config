-- Bootstrap lazy.nvim
vim.g.mapleader = " "

vim.opt.tabstop = 3
vim.opt.shiftwidth = 3
vim.opt.softtabstop = 0
vim.opt.expandtab = false

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.undofile = true
vim.opt.hlsearch = false
vim.opt.incsearch = true

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

local opts = {}

-- remaps

function map_keys(mode, keys, action, opts)
	opts = opts or {}

	-- If keys is a string (single key), convert it to a table
	if type(keys) == "string" then
		keys = { keys }
	end

	-- Map each key to the action
	for _, key in ipairs(keys) do
		vim.keymap.set(mode, key, action, opts)
	end
end

-- speed scroll
vim.keymap.set("n", "<S-Up>", "10k", { noremap = true }, { desc = "speed scroll up" })
vim.keymap.set("n", "<S-Down>", "10j", { noremap = true }, { desc = "speed scroll down" })

-- function mover
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "move selection up a line" })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "move selection down a line" })

-- system clipboard
vim.keymap.set("n", "<leader>y", '"+y', { desc = "Add to system clipboard" })
vim.keymap.set("v", "<leader>y", '"+y', { desc = "Add to system clipboard" })
vim.keymap.set("n", "<leader>p", '"+p`[v`]:s/\\r//g<CR>', { desc = "Paste from system clipboard" })
vim.keymap.set("v", "<leader>p", '"+p`[v`]:s/\\r//g<CR>', { desc = "Paste from system clipboard" })
-- Window resizing
vim.keymap.set("n", "<C-Up>", ":resize -2<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Buffer navigation
vim.keymap.set("n", "<S-l>", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-h>", ":bprevious<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete buffer" })
vim.keymap.set("n", "<leader>bn", ":enew<CR>", { desc = "New buffer" })

-- Split windows
vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", { desc = "Split vertically" })
vim.keymap.set("n", "<leader>sh", ":split<CR>", { desc = "Split horizontally" })
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
vim.keymap.set("n", "<leader>sx", ":close<CR>", { desc = "Close current split" })
-- ================================================================

require("lazy").setup("plugins")
