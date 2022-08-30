local M = {}

-- todo make it clean
function M.setup(on_attch)
	-- Warning!  lsp-installer must be configured before lsp-config
	-- https://github.com/williamboman/nvim-lsp-installer/discussions/509
	local lsp_installer = require("nvim-lsp-installer")
	lsp_installer.on_server_ready(function(server)
		local opts = {
			on_attach = on_attch,
			flags = {
				debounce_text_changes = 150,
			},
		}
		server:setup(opts)
	end)
end

return M
