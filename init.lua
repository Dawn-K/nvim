require "user.options"
require "user.keymaps"
require "user.plugins"


-- theme
vim.g.nord_italic = false
vim.cmd [[colorscheme nord]]

-- nvim-treesitter
local configs = require 'nvim-treesitter.configs'
configs.setup {
	ensure_installed = { "go", "lua" },
	highlight = { -- enable highlighting
		enable = true,
	},
	indent = {
		enable = true, -- default is disabled anyways
	}
}

local function on_attach(client, bufnr)
	-- https://neovim.discourse.group/t/can-i-force-the-diagnostics-gutter-to-stay-open/1269/2
	-- always show the sign column, set it in on_attch can only show in lsp buffer
	vim.opt.signcolumn = "yes"
	-- show diagnostic in insert mode
	vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
		vim.lsp.diagnostic.on_publish_diagnostics, {
		update_in_insert = true,
	})
end

local lsp_installer = require("nvim-lsp-installer")
lsp_installer.on_server_ready(function(server)
	local opts = {
		on_attach = on_attach,
		flags = {
			debounce_text_changes = 150,
		},
	}
	server:setup(opts)
end)
