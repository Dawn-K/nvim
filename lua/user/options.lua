local api = vim.api
local g = vim.g
local o = vim.o
local opt = vim.opt

-- file
g.encoding = "UTF-8"
o.fileencoding = 'utf-8'

opt.mouse = "a"
opt.wrap = false
opt.hlsearch = false

-- view
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.showmode = true

-- tab
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4

-- move
o.scrolloff = 5
o.sidescrolloff = 5

opt.termguicolors = true
