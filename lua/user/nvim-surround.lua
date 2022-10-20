local status_ok, surround = pcall(require, "nvim-surround")
if not status_ok then
	vim.notify("nvim-surround not found")
	return
end

local M = {}

function M.setup()
	require("nvim-surround").setup({})
end

return M
