local M = {}
function M.setup()

	local colorscheme = "nord"
	vim.g.nord_italic = false -- must config before apply colorscheme

	local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
	if not status_ok then
		vim.notify("colorscheme " .. colorscheme .. " not found")
		return
	end


	-- background
	vim.api.nvim_set_hl(0, "NonText", { bg = "#2E3440" })

	-- set select
	vim.api.nvim_set_hl(0, "Pmenu", { bg = "#3B4252" })
	vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#434C5E" })

	-- set cmp
	--  gray
	vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { fg = "#808080" })
	--  blue
	vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#569CD6" })
	vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#569CD6" })
	--  light blue
	vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = "#9CDCFE" })
	vim.api.nvim_set_hl(0, "CmpItemKindInterface", { fg = "#9CDCFE" })
	vim.api.nvim_set_hl(0, "CmpItemKindText", { fg = "#9CDCFE" })
	--  pink
	vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = "#C586C0" })
	vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = "#C586C0" })
	--  front
	vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = "#D4D4D4" })
	vim.api.nvim_set_hl(0, "CmpItemKindProperty", { fg = "#D4D4D4" })
	vim.api.nvim_set_hl(0, "CmpItemKindUnit", { fg = "#D4D4D4" })
end

return M
