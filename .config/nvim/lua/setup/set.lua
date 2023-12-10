vim.opt.guicursor = "n-v-c-i-ci-ve:block,n-v-c:blinkwait0-blinkoff0-blinkon0,i-ci-ve:blinkwait700-blinkoff400-blinkon250"
vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.termguicolors = true
vim.opt.clipboard = ""
vim.opt.swapfile = false
vim.opt.title = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.scrolloff = 8
vim.opt.cursorline = true

vim.opt.smartindent = true

vim.opt.wrap = false
vim.opt.list = true

vim.o.foldcolumn = '1' -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
