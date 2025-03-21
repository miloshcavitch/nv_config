-- Module for getting environment variables from ~/.config/nvim/.env
local M = {}

-- Function to get an environment variable by name
function M.get_env_var(var_name)
	-- Path to .env file
	local env_file_path = os.getenv("HOME") .. "/.config/nvim/.env"

	-- Try to open the file
	local file = io.open(env_file_path, "r")
	if not file then
		return nil, "Could not open .env file at " .. env_file_path
	end

	-- Read file line by line
	for line in file:lines() do
		-- Skip comments and empty lines
		if not line:match("^%s*#") and line:match("%S") then
			-- Extract variable name and value (format: VAR_NAME=value)
			local var, value = line:match("^%s*([^=]+)%s*=%s*(.*)%s*$")
			if var and var == var_name then
				file:close()
				return value
			end
		end
	end

	-- If we get here, the variable wasn't found
	file:close()
	return nil, "Environment variable '" .. var_name .. "' not found"
end

return M
