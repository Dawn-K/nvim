local M = {}

local servers = {
	gopls = {},
	sumneko_lua = {},
	-- html = {},
	--rust_analyzer = {},
	--jsonls = {},
	--pyright = {},
	--tsserver = {},
	--vimls = {},
}

local function on_attach(client, bufnr)
	-- https://neovim.discourse.group/t/can-i-force-the-diagnostics-gutter-to-stay-open/1269/2
	-- always show the sign column, set it in on_attch can only show in lsp buffer
	vim.opt.signcolumn = "yes"
	-- Enable completion triggered by <C-X><C-O>
	-- See `:help omnifunc` and `:help ins-completion` for more information.
	-- vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Use LSP as the handler for formatexpr.
	-- See `:help formatexpr` for more information.
	-- vim.api.nvim_buf_set_option(0, "formatexpr", "v:lua.vim.lsp.formatexpr()")

	-- Configure key mappings
	require("config.lsp.keymaps").setup(client, bufnr)

	-- show diagnostic in insert mode
	vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
		vim.lsp.diagnostic.on_publish_diagnostics, {
		update_in_insert = true,
	})
end

local opts = {
	on_attach = on_attach,
	flags = {
		debounce_text_changes = 150,
	},
}

function M.setup()
	require("config.lsp.installer").setup(servers, opts)
end

return M
