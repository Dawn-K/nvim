require "user.options"
require "user.keymaps"
require "user.plugins"

-- TODO
-- 1. autopair
-- 2. codeaction config such as only one bulb and shortcut
-- 3. comment
-- 4. model the treesitter and lsp-config

require("user.color").setup()

-- Warning  nvim-treesitter must config before lsp-config
require("config.nvim-treesitter").setup()

-- include lsp-installer lsp-config cmp
-- require("config.lsp.lsp").setup()
require("config.lsp.nvim-cmp").setup()
require("user.lsp")
