local M = {}
local vim = vim

local keymap = vim.keymap.set
local buf_keymap = vim.api.nvim_buf_set_keymap

local function keymappings(client, bufnr)
	local opts = { noremap = true, silent = true }

	-- Key mappings
	buf_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
	keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
	keymap("n", "[g", "<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<CR>", opts)
	keymap("n", "]g", "<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<CR>", opts)


	keymap("n", "<leader>re", "<cmd>Lspsaga rename<CR>", opts)
	keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

	-- Move
	keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	-- keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	keymap("n", "gf", "<cmd>lua vim.lsp.buf.incoming_calls()<CR>", opts)
	-- show signature
	keymap("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	-- keymap("n", "", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)

end

function M.setup(client, bufnr)
	keymappings(client, bufnr)
end

return M
