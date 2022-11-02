require("user.options")
require("user.keymaps")
require("user.plugins")

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
require("user.telescope").setup()
require("user.mini").setup()
require("user.nvim-surround").setup()
