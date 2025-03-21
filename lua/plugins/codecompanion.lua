-- Get environment variable to check if we should load the plugin
local getosvar = require("utils.getosvar")
local isUsingCodeCompanion = not (getosvar.get_env_var("AVANTE_OR_CODE_COMPANION") == "true")

-- Only return the plugin if we're using CodeCompanion
if isUsingCodeCompanion then
	return {
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"j-hui/fidget.nvim",
		},
		config = function()
			-- Use getosvar to load the API key
			local api_key = getosvar.get_env_var("ANTHROPIC_API_KEY")

			require("codecompanion").setup({
				strategies = {
					chat = {
						adapter = "anthropic",
					},
					inline = {
						adapter = "anthropic",
					},
				},
				adapters = {
					anthropic = function()
						return require("codecompanion.adapters").extend("anthropic", {
							env = {
								api_key = api_key or "MY_OTHER_ANTHROPIC_KEY",
							},
						})
					end,
				},
			})
			vim.keymap.set({ "n", "v", "i" }, "<C-l>", ":CodeCompanionChat Toggle<CR>", { silent = true })
		end,
		init = function()
			-- Use proper Lua module path with dots instead of slashes
			require("plugins.codecompanion.fidget-spinner").init()
		end,
	}
else
	-- Return an empty table when not using CodeCompanion
	return {}
end
