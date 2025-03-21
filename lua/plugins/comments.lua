return {
	{
		"tpope/vim-commentary",
		config = function()
			vim.keymap.set("n", "<C-_>", ":Commentary<CR>", { noremap = true })
			vim.keymap.set("n", "<C-/>", ":Commentary<CR>", { noremap = true })

			vim.keymap.set("v", "<C-_>", ":Commentary<CR>", { noremap = true })
			vim.keymap.set("v", "<C-/>", ":Commentary<CR>", { noremap = true })
		end,
	},
}
