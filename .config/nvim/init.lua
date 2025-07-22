vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

-- Make line numbers default
vim.opt.number = true
vim.opt.relativenumber = true
-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'
-- Don't show the mode, since it's already in status line
vim.opt.showmode = false

vim.opt.termguicolors = true

-- copy to OS clipboard
vim.keymap.set('n', '<leader>y', '"+y', { desc = 'Copy to OS Clipboard' })
vim.keymap.set('v', '<leader>y', '"+y', { desc = 'Copy to OS Clipboard' })
-- paste to OS clipboard
vim.keymap.set('n', '<leader>p', '"+p', { desc = 'Paste from OS Clipboard' })
vim.keymap.set('v', '<leader>p', '"+p', { desc = 'Paste from OS Clipboard' })

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- add title
vim.opt.title = true

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.list = true
vim.opt.listchars = { tab = '│ ', trail = '·', nbsp = '␣' }

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

vim.opt.guicursor = 'n-v-c:block-blinkon0'
vim.opt.guicursor = 'i-ci:block-blinkwait175-blinkoff150-blinkon175'

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

vim.keymap.set('n', 'gbt', '<Cmd>Gitsigns toggle_current_line_blame<CR>', { desc = 'Toggle git blame' })

-- Next/previous buffer
vim.keymap.set('n', '<Tab>', ':bnext<CR>', { silent = true })
vim.keymap.set('n', '<S-Tab>', ':bprev<CR>', { silent = true })

-- Jump to buffer by number (1–9)
for i = 1, 9 do
  vim.keymap.set('n', '<A-' .. i .. '>', function()
    local bufs = vim.fn.getbufinfo { buflisted = 1 }
    if bufs[i] then
      vim.cmd('buffer ' .. bufs[i].bufnr)
    end
  end, { desc = 'Go to buffer ' .. i })
end

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- move highlighted text up/down using visual mode
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

vim.keymap.set('n', '<leader>-', ':Explore <CR>')

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

local args = require 'plugins.args'
require('lazy').setup({
  require 'plugins.vim-sleuth',
  require 'plugins.surround',
  require 'plugins.comment',
  require 'plugins.cmp-cmdline',
  require 'plugins.fzf',
  require 'plugins.lsp',
  require 'plugins.conform',
  require 'plugins.nvim-cmp',
  require 'plugins.kanagawa',
  require 'plugins.treesitter',
  require 'plugins.mini',
  require 'plugins.git',
}, args)
