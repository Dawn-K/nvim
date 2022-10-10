local M = {}

function M.setup()
	require("nvim-tree").setup {
		sync_root_with_cwd = true,
		respect_buf_cwd = true,
		update_focused_file = {
			enable = true,
			update_root = true
		},
		disable_netrw = true,
		hijack_netrw = true,
		view = {
			adaptive_size = true,
		},
		filters = {
			-- TODO bug: it will hide file has prefix of git
		--	custom = { ".git" },
		},
	}
end

return M
