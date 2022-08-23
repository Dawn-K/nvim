local default_opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, expr = true, silent = true }
local map = vim.keymap.set
local api = vim.api
local g = vim.g
local opt = vim.opt

g.mapleader = ' '
g.maplocalleader = ' '


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

-- Show
map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", default_opts)
map("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>", default_opts)

-- Refactor
map("n", "<leader>re", "<cmd>Lspsaga rename<CR>", default_opts)
map("n", "<leader>s", "<cmd>lua vim.lsp.buf.formatting()<CR>", default_opts)

-- Move
map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", default_opts)
map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", default_opts)
map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", default_opts)
map("n", "gf", "<cmd>lua vim.lsp.buf.references()<CR>", default_opts)
map("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", default_opts)
map("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", default_opts)
map("n", "[g", "<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<CR>", default_opts)
map("n", "]g", "<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<CR>", default_opts)
