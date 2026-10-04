local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.mouse = 'a'
-- Don't show the mode, since it's already in status line
opt.showmode = false
opt.termguicolors = true

opt.breakindent = true
opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
-- Preview substitutions live, as you type!
opt.inccommand = 'split'

opt.signcolumn = 'yes'
opt.cursorline = true
opt.scrolloff = 10
opt.title = true

opt.updatetime = 250
opt.timeoutlen = 300

opt.splitright = true
opt.splitbelow = true

opt.list = true
opt.listchars = { tab = '│ ', trail = '·', nbsp = '␣' }

-- Defaults; vim-sleuth adjusts these per file
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

opt.guicursor = 'i-ci:block-blinkwait175-blinkoff150-blinkon175'

opt.wildignore:append { '*.o', '*.a', 'node_modules/*', '.git/*' }

-- Completion menu (blink.cmp draws its own, this is for the cmdline/native fallback)
opt.completeopt = { 'menu', 'menuone', 'noinsert' }
