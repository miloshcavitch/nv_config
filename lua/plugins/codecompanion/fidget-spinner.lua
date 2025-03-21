local M = {}

-- Get environment variable to check if we should initialize
local getosvar = require("utils.getosvar")
local isUsingCodeCompanion = not (getosvar.get_env_var("AVANTE_OR_CODE_COMPANION") == "true")

M.handles = {}

-- Only define functionality if using CodeCompanion
if isUsingCodeCompanion then
	local progress = require("fidget.progress")

	function M.init()
		local group = vim.api.nvim_create_augroup("CodeCompanionFidgetHooks", {})

		vim.api.nvim_create_autocmd({ "User" }, {
			pattern = "CodeCompanionRequestStarted",
			group = group,
			callback = function(request)
				local handle = M.create_progress_handle(request)
				M.store_progress_handle(request.data.id, handle)
			end,
		})

		vim.api.nvim_create_autocmd({ "User" }, {
			pattern = "CodeCompanionRequestFinished",
			group = group,
			callback = function(request)
				local handle = M.pop_progress_handle(request.data.id)
				if handle then
					M.report_exit_status(handle, request)
					handle:finish()
				end
			end,
		})
	end

	function M.store_progress_handle(id, handle)
		M.handles[id] = handle
	end

	function M.pop_progress_handle(id)
		local handle = M.handles[id]
		M.handles[id] = nil
		return handle
	end

	function M.create_progress_handle(request)
		return progress.handle.create({
			title = " Requesting assistance (" .. request.data.strategy .. ")",
			message = "In progress...",
			lsp_client = {
				name = M.llm_role_title(request.data.adapter),
			},
		})
	end

	function M.llm_role_title(adapter)
		local parts = {}
		table.insert(parts, adapter.formatted_name)
		if adapter.model and adapter.model ~= "" then
			table.insert(parts, "(" .. adapter.model .. ")")
		end
		return table.concat(parts, " ")
	end

	function M.report_exit_status(handle, request)
		if request.data.status == "success" then
			handle.message = "Completed"
		elseif request.data.status == "error" then
			handle.message = " Error"
		else
			handle.message = "󰜺 Cancelled"
		end
	end
else
	-- Stub functions when not using CodeCompanion
	function M.init() end
	function M.store_progress_handle() end
	function M.pop_progress_handle()
		return nil
	end
	function M.create_progress_handle()
		return nil
	end
	function M.llm_role_title()
		return ""
	end
	function M.report_exit_status() end
end

return M
