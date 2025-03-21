return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local config = require("nvim-treesitter.configs")
		config.setup({
			ensure_installed = { "lua", "javascript", "python", "c_sharp", "c", "yaml" },
			sync_installed = false,
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
