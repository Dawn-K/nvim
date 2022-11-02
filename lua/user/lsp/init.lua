local mason_ok, mason = pcall(require, "mason")
if not mason_ok then
	vim.notify("mason not found")
	return
end

local mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_ok then
	vim.notify("mason-lspconfig not found")
	return
end

-- It's important that you set up the plugins in the following order:
--
-- 1. mason.nvim
-- 2. mason-lspconfig.nvim
-- 3. lspconfig
--
mason.setup()
mason_lspconfig.setup({
	-- not need install the software first?
	-- https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md
	ensure_installed = { "sumneko_lua", "gopls", "rust_analyzer", "pyright" },
})

local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_ok then
	vim.notify("lspconfig not found")
	return
end

-- https://github.com/williamboman/mason-lspconfig.nvim/issues/18
mason_lspconfig.setup_handlers({
	function(server_name) -- default handler (optional)
		lspconfig[server_name].setup({})
	end,
})

require("user.lsp.handlers").setup()

local mason_null_ls_ok, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_ok then
	vim.notify("mason-null-ls not found")
	return
end

local null_ls_ok, null_ls = pcall(require, "null-ls")
if not null_ls_ok then
	vim.notify("null-ls not found")
	return
end

mason_null_ls.setup({
	-- need install the software first
	ensure_installed = { "stylua", "autopep8" },
})

mason_null_ls.setup_handlers({
	function(source_name)
		-- all sources with no handler get passed here
	end,
})

-- null-ls will show autostart is false, don't care it.
-- https://github.com/jose-elias-alvarez/null-ls.nvim/discussions/593
-- will setup any installed and configured sources above
null_ls.setup({
	sources = {
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.autopep8,
	},
})
