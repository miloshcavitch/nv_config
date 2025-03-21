local M = {}

function M.load_env()
	local home = vim.fn.expand("$HOME")
	local env_path = home .. "/.config/nvim/.env"

	local env_file = io.open(env_path, "r")
	if env_file then
		for line in env_file:lines() do
			-- Skip comments and empty lines
			if line:match("^[^#]") and line:match("=") then
				local key, value = line:match("([^=]+)=(.*)")
				key = key:gsub("^%s*(.-)%s*$", "%1") -- trim whitespace
				value = value:gsub("^%s*(.-)%s*$", "%1") -- trim whitespace
				-- Remove quotes if they exist
				value = value:gsub('^"(.*)"$', "%1")
				value = value:gsub("^'(.*)'$", "%1")
				-- Set the environment variable in Neovim
				vim.env[key] = value
			end
		end
		env_file:close()
	end
end

return M
