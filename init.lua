require "user.options"
require "user.keymaps"
require "user.plugins"

-- TODO
-- codeaction config such shortcut
-- TODO hint
-- border between from panel

require("user.color").setup()

-- Warning  nvim-treesitter must config before lsp-config
require("config.nvim-treesitter").setup()

-- include lsp-installer lsp-config cmp
require("config.lsp.nvim-cmp").setup()
require("user.lsp")


require("user.comment").setup()
require("user.autopairs").setup()
require("user.gitsigns")
require("user.toggleterm").setup()
