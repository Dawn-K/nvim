local M = {}

function M.setup()
	require("lspsaga").init_lsp_saga {
		-- todo fix code_action
		rename_action_quit = "<C-c>",
		rename_in_select = false,
	}
end

return M
