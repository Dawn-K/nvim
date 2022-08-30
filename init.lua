require "user.options"
require "user.keymaps"
require "user.plugins"

-- TODO
-- 1. autopair
-- 2. codeaction config such as only one bulb and shortcut
-- 3. comment
-- 4. model the treesitter and lsp-config

require("user.color").setup()

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

local servers = {
	-- server list: https://github.com/williamboman/nvim-lsp-installer#available-lsps
	gopls = {},
	sumneko_lua = {},
	pyright = {},
}

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

-- Warning!  lsp-installer must be configured before lsp-config
-- https://github.com/williamboman/nvim-lsp-installer/discussions/509
local lsp_installer = require("nvim-lsp-installer")
lsp_installer.on_server_ready(function(server)
	local opts = {
		on_attach = function(client, bufnr)
			default_attach(client, bufnr)
		end,
		flags = {
			debounce_text_changes = 150,
		},
	}
	server:setup(opts)
end)

-- Complete
local cmp = require("cmp")
local luasnip = require('luasnip')
cmp.setup {
	completion = {
		completeopt = 'menu,menuone,noinsert'
	},
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end
	},
	window = {
		documentation = cmp.config.window.bordered()
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = 'nvim_lsp_signature_help' },
		{ name = "luasnip" },
	},
	mapping = {
		-- select but not insert
		-- "behavior = cmp.SelectBehavior.Select" can only select but not insert
		["<A-j>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
		["<A-k>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
		-- replace the word, better than jetbrains!
		["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
		-- seems less?
		['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
		['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
	},
	sorting = {
		-- TODO custom the order  1. remove snippet from luasnip 2.
		-- compare kind: https://github.com/hrsh7th/nvim-cmp/blob/main/lua/cmp/types/lsp.lua#L104-L130
		-- custom compare function: https://github.com/hrsh7th/nvim-cmp/blob/main/lua/cmp/config/compare.lua
		comparators = {
			cmp.config.compare.offset,
			cmp.config.compare.exact,
			cmp.config.compare.score,
			cmp.config.compare.recently_used,
			cmp.config.compare.locality,
			-- cmp.config.compare.kind, -- now some snippet is annoy
			cmp.config.compare.sort_text,
			cmp.config.compare.length,
			cmp.config.compare.order,


			-- copied from cmp-under, but I don't think I need the plugin for this.
			-- I might add some more of my own.
			function(entry1, entry2)
				local _, entry1_under = entry1.completion_item.label:find "^_+"
				local _, entry2_under = entry2.completion_item.label:find "^_+"
				entry1_under = entry1_under or 0
				entry2_under = entry2_under or 0
				if entry1_under > entry2_under then
					return false
				elseif entry1_under < entry2_under then
					return true
				end
			end,
		},
	},
	formatting = {
		fields = { 'kind', 'abbr', 'menu' },
		format = function(entry, item)
			local menu_icon = {
				nvim_lsp = 'λ',
				luasnip = '⋗',
				buffer = 'Ω',
				path = '🖫'
			}

			item.menu = menu_icon[entry.source.name]

			local kind_icon = {
				Text = "",
				Method = "",
				Function = "",
				Constructor = "",
				Field = "",
				Variable = "",
				Class = "ﴯ",
				Interface = "",
				Module = "",
				Property = "ﰠ",
				Unit = "",
				Value = "",
				Enum = "",
				Keyword = "",
				Snippet = "",
				Color = "",
				File = "",
				Reference = "",
				Folder = "",
				EnumMember = "",
				Constant = "",
				Struct = "",
				Event = "",
				Operator = "",
				TypeParameter = ""
			}
			item.kind = kind_icon[item.kind]
			return item
		end,
	},
}

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

local _, lspconfig = pcall(require, "lspconfig")

local function setup_server(server, config)
	-- disable lsp
	if not config then
		return
	end

	-- set default value
	config = vim.tbl_deep_extend("keep", config, default_config)

	lspconfig[server].setup(config)
end

for server, config in pairs(servers) do
	setup_server(server, config)
end
