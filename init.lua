-- Bootstrap lazy.nvim
vim.g.mapleader = " "

vim.opt.tabstop = 3
vim.opt.shiftwidth = 3
vim.opt.softtabstop = 0
vim.opt.expandtab = false

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.undodir = "~/.config/nvim/.undo//"
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

-- transparency
-- remaps

vim.keymap.set("n", "<S-Up>", "10k", { noremap = true })
vim.keymap.set("n", "<S-Down>", "10j", { noremap = true })

require("lazy").setup("plugins")
