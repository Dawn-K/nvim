local map = vim.keymap.set
local default_opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, expr = true, silent = true }

local api = vim.api
local g = vim.g
local opt = vim.opt

g.mapleader = ' '
g.maplocalleader = ' '

-- search
map("n", "n", "nzz", default_opts)
map("n", "N", "Nzz", default_opts)

-- switch buffer
map("n", "<S-h>", ":bprevious<CR>", default_opts)
map("n", "<S-l>", ":bnext<CR>", default_opts)

-- file
map("n","<leader>n", ":NvimTreeFocus<CR>",default_opts)

--use bufdelete to close current buffer. :q will close all buffer
map("n","<leader>q", ":Bdelete<CR>",default_opts)
