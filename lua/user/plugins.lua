local status_ok, packer = pcall(require, "packer")
if not status_ok then
	vim.notify("packer not found")
	return
end

packer.init {
	display = {
		git = { clone_timeout = 60, default_url_format = "https://github.com/%s" },
		open_fn = function()
			return require('packer.util').float({ border = 'single' })
		end
	}
}
-- require 'nvim-treesitter.configs'.setup {
-- -- A list of parser names, or "all"
-- ensure_installed = { "c", "cpp", "go", "lua", "markdown", "rust" },
--
-- -- Automatically install missing parsers when entering buffer
-- auto_install = true,
--
-- -- List of parsers to ignore installing (for "all")
-- ignore_install = {},
--
-- highlight = {
-- -- `false` will disable the whole extension
-- enable = true,
--
-- -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
-- -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
-- -- Using this option may slow down your editor, and you may see some duplicate highlights.
-- -- Instead of true it can also be a list of languages
-- additional_vim_regex_highlighting = false,
-- },
-- }

return packer.startup({
	function()
		-- Warning! nvim-lspconfig set event to "BufEnter",
		-- and treesitter set event to VimEnter or not set is work!
		--
		-- LSP
		use {
			"neovim/nvim-lspconfig",
			opt = true,
			-- this line will let the first open file with no highlight
			event = "BufEnter",
			wants = { "nvim-lsp-installer" },
			config = function()
				require("config.lsp").setup()
			end,
			requires = {
				"williamboman/nvim-lsp-installer",
			},
		}

		use {
			'nvim-treesitter/nvim-treesitter',
			event = "VimEnter",
			run = function()
				require('nvimtreesitter.install').update({ with_sync = true })
			end,
			config = function()
				require("config.nvimtreesitter").setup()
			end,
		}


		use 'wbthomason/packer.nvim'
		use 'shaunsingh/nord.nvim'
		use {
			'nvim-lualine/lualine.nvim',
			requires = { "kyazdani42/nvim-web-devicons", opt = true },
			event = "VimEnter",
			config = function()
				require("config.lualine").setup()
			end,
		}
		use 'dstein64/vim-startuptime'
		use {
			"kyazdani42/nvim-tree.lua",
			requires = { "kyazdani42/nvim-web-devicons", opt = true },
			config = function()
				require("config.nvimtree").setup()
			end,
			cmd = { "NvimTreeToggle", "NvimTreeClose", "NvimTreeFocus" },
		}
		-- for delete buffer and keep the nvim-tree in it's position
		use 'famiu/bufdelete.nvim'
		use {
			"akinsho/nvim-bufferline.lua",
			event = "BufReadPre",
			requires = { "kyazdani42/nvim-web-devicons", opt = true },
			config = function()
				require("config.bufferline").setup()
			end,
		}


		-- FZF Lua
		use {
			"ibhagwan/fzf-lua",
			event = "BufEnter",
			wants = "nvim-web-devicons",
		}

		use {
			"glepnir/lspsaga.nvim",
			event = "BufReadPre",
			config = function()
				require("config.lspsaga").setup()
			end,
		}

		use {
			-- project
			"ahmedkhalf/project.nvim",
			config = function()
				require("project_nvim").setup {
					-- your configuration comes here
					-- or leave it empty to use the default settings
					-- refer to the configuration section below
				}
			end
		}

		use {
			'nvim-telescope/telescope.nvim', tag = '0.1.0',
			-- or                            , branch = '0.1.x',
			requires = { { 'nvim-lua/plenary.nvim', 'BurntSushi/ripgrep' } },
			config = function()
				require("telescope").load_extension('projects')
			end
		}
	end,
})
