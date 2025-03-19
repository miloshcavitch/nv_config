return {
	{
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	enabled = false,
	config = function()
			vim.cmd.colorscheme "catppuccin"
		end
	},
	{
	"rebelot/kanagawa.nvim",
	name = "kanagawa",
	priority = 1000,
	enabled = true,
	config = function()
			vim.cmd.colorscheme "kanagawa-dragon"
			end
	}
}


