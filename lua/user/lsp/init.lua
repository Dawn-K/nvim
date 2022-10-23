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
		lspconfig[server_name].setup {}
	end,
})


require("user.lsp.handlers").setup()
