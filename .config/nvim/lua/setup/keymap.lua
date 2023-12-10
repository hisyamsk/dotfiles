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
map("n", "<C-Right>", ":BufferLineCycleNext<CR>", opts)
map("n", "<C-Left>", ":BufferLineCyclePrev<CR>", opts)
map("n", "<C-x>", ":BufferLinePickClose<CR>", opts)
map("n", "<C-Up>", ":BufferLineCloseRight<CR>", opts)
map("n", "<C-Down>", ":BufferLineCloseLeft<CR>", opts)

-- format code
-- map("n", "<C-f>", ":Prettier<CR>", opts)
map("n", "<C-f>", ":lua vim.lsp.buf.format()<CR>", opts)

-- keymap for goto-preview
vim.keymap.set("n", "gpd", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", {noremap=true})
vim.keymap.set("n","gpt", "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>", {noremap=true})
vim.keymap.set("n","gpi", "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>", {noremap=true})
vim.keymap.set("n","gpD", "<cmd>lua require('goto-preview').goto_preview_declaration()<CR>",  {noremap=true})
vim.keymap.set("n","gP", "<cmd>lua require('goto-preview').close_all_win()<CR>", {noremap=true})
vim.keymap.set("n","gpr", "<cmd>lua require('goto-preview').goto_preview_references()<CR>", {noremap=true})
