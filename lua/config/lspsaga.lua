local M = {}

function M.setup()
	require("lspsaga").init_lsp_saga {
		rename_action_quit = "<Esc>",
		rename_in_select = false,
	}
end

return M