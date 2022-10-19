local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	vim.notify("telescope not found")
	return
end

local M = {}

function M.setup()
	telescope.load_extension('projects')
	local actions = require("telescope.actions")
	telescope.setup {
		defaults = {
			mappings = {
				i = {
					["<C-j>"] = actions.move_selection_next,
					["<C-k>"] = actions.move_selection_previous,
				}
			}
		},
	}
end

return M
