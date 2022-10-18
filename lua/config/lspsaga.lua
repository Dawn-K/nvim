local M = {}

function M.setup()
	require("lspsaga").init_lsp_saga {
		-- todo fix code_action
		rename_action_quit = "<C-c>",
		rename_in_select = false,
		code_action_lightbulb = {
			enable = true,
			enable_in_insert = true,
			cache_code_action = true,
			sign = false,
			update_time = 150,
			sign_priority = 20,
			virtual_text = true,
		},
	}
end

return M
