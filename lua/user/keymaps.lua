local default_opts = { noremap = true, silent = true }
local map = vim.keymap.set
local g = vim.g

g.mapleader = ' '
g.maplocalleader = ' '

map("n", "<C-j>", "<Down>", default_opts)
map("n", "<C-k>", "<Up>", default_opts)

map("n", "s", "<cmd>HopChar1<cr>", default_opts)
map("n", "<S-s>", "<cmd>HopChar2<cr>", default_opts)

map("n", "<leader><leader>j", "<cmd>HopLineStartAC<cr>", default_opts)
map("n", "<leader><leader>k", "<cmd>HopLineStartBC<cr>", default_opts)

-- switch buffer
map("n", "<S-h>", ":bprevious<CR>", default_opts)
map("n", "<S-l>", ":bnext<CR>", default_opts)

-- File
-- Nvim Tree
map("n", "<leader>n", ":NvimTreeFocus<CR>", default_opts)
-- use bufdelete to close current buffer. :q will close all buffer
map("n", "<leader>q", ":Bdelete<CR>", default_opts)

-- Search
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", default_opts)
map("n", "<leader>fp", "<cmd>Telescope projects<cr>", default_opts)
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", default_opts)
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", default_opts)
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", default_opts)
map("n", "n", "nzz", default_opts)
map("n", "N", "Nzz", default_opts)

-- Git
map("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<cr>", default_opts)

-- Show
map("n", "K", "<cmd>Lspsaga hover_doc<CR>", default_opts)
map("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>", default_opts)

-- Refactor
map("n", "<leader>re", "<cmd>Lspsaga rename<CR>", default_opts)
map("n", "<leader>s", "<cmd>lua vim.lsp.buf.format{ async=true }<CR>", default_opts)

-- Move
map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", default_opts)
map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", default_opts)
map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", default_opts)
map("n", "gf", "<cmd>lua vim.lsp.buf.references()<CR>", default_opts)

-- Diagnsotic jump can use `<c-o>` to jump back
map("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", default_opts)
map("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", default_opts)

-- Only jump to error
map("n", "[g", function()
	require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, default_opts)
map("n", "]g", function()
	require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
end, default_opts)
