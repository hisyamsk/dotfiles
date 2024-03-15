---------------------------------
-- Key bindings
---------------------------------
local map = vim.api.nvim_set_keymap
local kmap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Leader
vim.g.mapleader = " "

-- Vim
map("n", "<C-e>", ":Neotree toggle<CR>", opts)
map("n", "<C-p>", ':lua require("telescope.builtin").find_files()<CR>', opts)
map("n", "<C-s>", ':lua require("telescope.builtin").live_grep()<CR>', opts)
map("n", "gpr", ':lua require("telescope.builtin").lsp_references()<CR>', opts)
map("n", "<C-Right>", ":BufferLineCycleNext<CR>", opts)
map("n", "<C-Left>", ":BufferLineCyclePrev<CR>", opts)
map("n", "<C-x>", ":BufferLinePickClose<CR>", opts)
map("n", "<C-Up>", ":BufferLineCloseRight<CR>", opts)
map("n", "<C-Down>", ":BufferLineCloseLeft<CR>", opts)

-- format code
-- map("n", "<C-f>", ":Prettier<CR>", opts)
map("n", "<C-f>", ":lua vim.lsp.buf.format()<CR>", opts)
