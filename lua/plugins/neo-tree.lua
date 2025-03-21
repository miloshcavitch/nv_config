return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("neo-tree").setup({
			filesystem = {
				filtered_items = {
					visible = true,
					hide_dotfiles = false,
					hide_gitignored = false,
				},
			},
		})
		vim.keymap.set("n", "<C-n>", function()
			local neotree_buffers = {}

			-- Find all Neotree buffers
			for _, buf in ipairs(vim.api.nvim_list_bufs()) do
				if vim.bo[buf].filetype == "neo-tree" then
					table.insert(neotree_buffers, buf)
				end
			end

			if #neotree_buffers > 0 then
				-- Close all Neotree windows
				vim.cmd("Neotree close")
			else
				-- Open Neotree
				vim.cmd("Neotree filesystem reveal left")
			end
		end, { noremap = true, silent = true })
	end,
}
