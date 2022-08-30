local M = {}

function M.setup()
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
end

return M
