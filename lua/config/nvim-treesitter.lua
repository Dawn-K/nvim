local M = {}

function M.setup()
	-- nvim-treesitter
	local configs = require 'nvim-treesitter.configs'

	configs.setup {
		-- server list: https://github.com/nvim-treesitter/nvim-treesitter#supported-languages
		ensure_installed = { "go", "lua", "python" },
		highlight = { -- enable highlighting
			enable = true,
		},
		indent = {
			enable = true, -- default is disabled anyways
		}
	}
end

return M
