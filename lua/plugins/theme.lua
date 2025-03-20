return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		enabled = false,
		config = function()
			vim.cmd.colorscheme("catppuccin")
		end,
	},
	{
		"rebelot/kanagawa.nvim",
		name = "kanagawa",
		priority = 1000,
		enabled = true,

		config = function()
			require("kanagawa").setup({
				transparent = true,
			})
			vim.cmd.colorscheme("kanagawa-dragon")
		end,
	},
}
