local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	vim.notify("Packer not found, installing it ...")
	IS_PACKER_NEWLY_INSTALLED = true
	fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	vim.cmd([[packadd packer.nvim]])
	vim.notify("Installing packer success")
end

local status_ok, packer = pcall(require, "packer")
if not status_ok then
	vim.notify("packer not found")
	return
end

packer.init({
	display = {
		git = { clone_timeout = 60, default_url_format = "https://github.com/%s" },
		open_fn = function()
			return require("packer.util").float({ border = "single" })
		end,
	},
})
return packer.startup({
	function()
		use({
			"phaazon/hop.nvim",
			branch = "v2", -- optional but strongly recommended
			config = function()
				-- you can configure Hop the way you like here; see :h hop-config
				require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
			end,
		})
		-- Warning! nvim-lspconfig set event to "BufEnter",
		-- and treesitter set event to VimEnter or not set is work!
		use({
			"nvim-treesitter/nvim-treesitter",
			run = function()
				require("nvim-treesitter.install").update({ with_sync = true })
			end,
		})
		use("numToStr/Comment.nvim")

		use("windwp/nvim-autopairs")

		use("lewis6991/gitsigns.nvim")

		use("akinsho/toggleterm.nvim")

		use("echasnovski/mini.nvim")

		use({
			"kylechui/nvim-surround",
			tag = "*", -- Use for stability; omit to use `main` branch for the latest features
		})

		use("williamboman/mason.nvim")
		use("WhoIsSethDaniel/mason-tool-installer")
		use("williamboman/mason-lspconfig.nvim")
		use("neovim/nvim-lspconfig")

		use("jose-elias-alvarez/null-ls.nvim")
		use("jayp0521/mason-null-ls.nvim")

		use("wbthomason/packer.nvim")
		use("shaunsingh/nord.nvim")
		use({
			"nvim-lualine/lualine.nvim",
			requires = { "kyazdani42/nvim-web-devicons", opt = true },
			event = "VimEnter",
			config = function()
				require("config.lualine").setup()
			end,
		})
		use("dstein64/vim-startuptime")
		use({
			"kyazdani42/nvim-tree.lua",
			requires = { "kyazdani42/nvim-web-devicons", opt = true },
			config = function()
				require("config.nvimtree").setup()
			end,
			cmd = { "NvimTreeToggle", "NvimTreeClose", "NvimTreeFocus" },
		})
		-- for delete buffer and keep the nvim-tree in it's position
		use("famiu/bufdelete.nvim")
		use({
			"akinsho/nvim-bufferline.lua",
			event = "BufReadPre",
			requires = { "kyazdani42/nvim-web-devicons", opt = true },
			config = function()
				require("config.bufferline").setup()
			end,
		})

		-- FZF Lua
		use({
			"ibhagwan/fzf-lua",
			event = "BufEnter",
			wants = "nvim-web-devicons",
		})

		use({
			"glepnir/lspsaga.nvim",
			event = "BufReadPre",
			config = function()
				require("config.lspsaga").setup()
			end,
		})

		use({
			-- project
			"ahmedkhalf/project.nvim",
			config = function()
				require("project_nvim").setup({
					-- your configuration comes here
					-- or leave it empty to use the default settings
					-- refer to the configuration section below
				})
			end,
		})

		use({
			"nvim-telescope/telescope.nvim",
			tag = "0.1.0",
			-- or                            , branch = '0.1.x',
			requires = { { "nvim-lua/plenary.nvim", "BurntSushi/ripgrep" } },
		})

		-- Complete
		use("hrsh7th/nvim-cmp")
		use("hrsh7th/cmp-nvim-lsp")
		use("hrsh7th/cmp-nvim-lsp-document-symbol")
		use("L3MON4D3/LuaSnip")

		-- Automatically sync plugins after cloning packer.nvim
		-- Pust this at the end after all plugins.
		if IS_PACKER_NEWLY_INSTALLED then
			require("packer").sync()
		end
	end,
})
