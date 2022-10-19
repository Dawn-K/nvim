local M = {}

-- TODO: backfill this to template
M.setup = function()
	local signs = {
		{ name = "DiagnosticSignError", text = "" },
		{ name = "DiagnosticSignWarn", text = "" },
		{ name = "DiagnosticSignHint", text = "" },
		{ name = "DiagnosticSignInfo", text = "" },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

	-- Create a custom namespace. This will aggregate signs from all other
	-- namespaces and only show the one with the highest severity on a
	-- given line
	local ns = vim.api.nvim_create_namespace("my_namespace")

	-- Get a reference to the original signs handler
	local orig_signs_handler = vim.diagnostic.handlers.signs

	local config = {
		virtual_text = true,
		-- show signs
		signs = {
			active = signs,
			-- 没搞懂
			-- https://neovim.io/doc/user/diagnostic.html#diagnostic-handlers-example
			show = function(_, bufnr, _, opts)
				-- Get all diagnostics from the whole buffer rather than just the
				-- diagnostics passed to the handler
				local diagnostics = vim.diagnostic.get(bufnr)
				-- seems no use
				vim.notify("debug show function")

				-- Find the "worst" diagnostic per line
				local max_severity_per_line = {}
				for _, d in pairs(diagnostics) do
					local m = max_severity_per_line[d.lnum]
					if not m or d.severity < m.severity then
						max_severity_per_line[d.lnum] = d
					end
				end

				-- Pass the filtered diagnostics (with our custom namespace) to
				-- the original handler
				local filtered_diagnostics = vim.tbl_values(max_severity_per_line)
				orig_signs_handler.show(ns, bufnr, filtered_diagnostics, opts)
			end,
			hide = function(_, bufnr)
				orig_signs_handler.hide(ns, bufnr)
			end,
		},
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = false,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.opt.signcolumn = "yes:2"


	-- show diagnostic in insert mode
	vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
		vim.lsp.diagnostic.on_publish_diagnostics, {
		update_in_insert = true,
	})

	vim.diagnostic.config(config)

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
	})
end

local function lsp_highlight_document(client)
	-- Set autocommands conditional on server_capabilities
	if client.server_capabilities.document_highlight then
		vim.api.nvim_exec(
			[[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
			false
		)
	end
end

M.on_attach = function(client, bufnr)
	lsp_highlight_document(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
	nvim.notify("cmp_nvim_lsp not found")
	return
end

M.capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

return M
