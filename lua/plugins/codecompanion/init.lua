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
			-- Use getosvar to load the API keys
			local anthropic_api_key = getosvar.get_env_var("ANTHROPIC_API_KEY")
			local openrouter_api_key = getosvar.get_env_var("OPENROUTER_API_KEY")

			require("codecompanion").setup({
				opts = {
					log_level = "DEBUG",
				},
				display = {
					chat = {
						window = {
							position = "right",
							width = 0.3,
						},
					},
				},
				strategies = {
					chat = {
						adapter = "openrouter", -- Default adapter for chat
					},
					inline = {
						adapter = "openrouter", -- Default adapter for inline
					},
				},
				adapters = {
					anthropic = function()
						return require("codecompanion.adapters").extend("anthropic", {
							env = {
								api_key = anthropic_api_key or "MY_OTHER_ANTHROPIC_KEY",
							},
						})
					end,
					openrouter = function()
						return require("codecompanion.adapters").extend("openai_compatible", {
							name = "openrouter", -- Custom name for the adapter
							formatted_name = "OpenRouter", -- Display name
							url = "https://openrouter.ai/api/v1/chat/completions",
							env = {
								api_key = openrouter_api_key,
							},
							headers = {
								["Content-Type"] = "application/json",
								["Authorization"] = "Bearer ${api_key}",
								["HTTP-Referer"] = "http://localhost", -- OpenRouter often requires this
								["X-Title"] = "Neovim CodeCompanion",
							},
							schema = {
								model = {
									default = "anthropic/claude-3.7-sonnet",
									choices = {
										"anthropic/claude-3.5-sonnet",
										"openai/o3-mini",
										"openai/gpt-4o-mini",
										"google/gemini-2.0-flash-001",
										"deepseek/deepseek-r1",
										"deepseek/deepseek-r1-distill-llama-70b",
										-- Add other models as needed
									},
								},
								-- temperature = {
								-- 	order = 2,
								-- 	mapping = "parameters",
								-- 	type = "number",
								-- 	default = 0.7,
								-- 	desc = "Controls randomness. Lower values like 0.2 result in more focused and deterministic outputs, while higher values like 0.8 make output more random and creative.",
								-- 	validate = function(n)
								-- 		return n >= 0 and n <= 1, "Must be between 0 and 1"
								-- 	end,
								-- },
								-- max_tokens = {
								-- 	order = 3,
								-- 	mapping = "parameters",
								-- 	type = "integer",
								-- 	default = 1024,
								-- 	desc = "The maximum number of tokens to generate in the completion.",
								-- 	validate = function(n)
								-- 		return n > 0, "Must be greater than 0"
								-- 	end,
								-- },
							},
						})
					end,
				},
			})

			-- Chat toggle keybinding
			vim.keymap.set({ "n", "v", "i" }, "<leader>aa", ":CodeCompanionChat Toggle<CR>", { silent = true })

			-- OpenRouter adapter selection keybinding (optional)
			vim.keymap.set("n", "<leader>ao", function()
				vim.cmd("CodeCompanionChat SetAdapter openrouter")
			end, { silent = true, desc = "Set OpenRouter as CodeCompanion adapter" })

			-- Anthropic adapter selection keybinding (optional)
			vim.keymap.set("n", "<leader>ac", function()
				vim.cmd("CodeCompanionChat SetAdapter anthropic")
			end, { silent = true, desc = "Set Anthropic as CodeCompanion adapter" })
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
