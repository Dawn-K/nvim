local M = {}

local function default_init(client)
end

local function default_attach(client, bufnr)
	-- https://neovim.discourse.group/t/can-i-force-the-diagnostics-gutter-to-stay-open/1269/2
	-- always show the sign column, set it in on_attch can only show in lsp buffer
	vim.opt.signcolumn = "yes"
	-- show diagnostic in insert mode
	vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
		vim.lsp.diagnostic.on_publish_diagnostics, {
		update_in_insert = true,
	})
end

function M.setup()
	local servers = {
		-- server list: https://github.com/williamboman/nvim-lsp-installer#available-lsps
		gopls = {},
		sumneko_lua = {},
		pyright = {},
	}

	-- MUST CONFIG BEFORE lsp-config
	require("config.lsp.nvim-lsp-installer").setup(default_attach)

	-- seems independent with lsp-config, but lsp-config need the cmp_nvim_lsp
	require("config.lsp.nvim-cmp").setup()

	-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
	local updated_capabilities = vim.lsp.protocol.make_client_capabilities()
	updated_capabilities = require('cmp_nvim_lsp').update_capabilities(updated_capabilities)

	local default_config = {
		on_init = default_init,
		on_attach = default_attach,
		capabilities = updated_capabilities,
		flags = {
			debounce_text_changes = 150,
		},
	}

	local status_ok, lspconfig = pcall(require, "lspconfig")
	if not status_ok then
		-- vim.notify seems annoying
		vim.notify("lspconfig not found")
		return 
	end

	local function setup_server(server, config)
		-- disable lsp
		if not config then
			vim.notify("setup_server not config")
			return
		end

		-- set default value
		config = vim.tbl_deep_extend("keep", config, default_config)

		vim.notify("setup server")
		-- TODO
		lspconfig[server].setup(default_config)
	end

	for server, config in pairs(servers) do
		setup_server(server, config)
	end
end

return M
