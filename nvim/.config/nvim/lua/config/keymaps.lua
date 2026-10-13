local map = vim.keymap.set

-- OS clipboard
map({ 'n', 'v' }, '<leader>y', '"+y', { desc = 'Copy to OS Clipboard' })
map({ 'n', 'v' }, '<leader>p', '"+p', { desc = 'Paste from OS Clipboard' })

map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostics
map('n', '[d', function()
  vim.diagnostic.jump { count = -1, float = true }
end, { desc = 'Go to previous [D]iagnostic message' })
map('n', ']d', function()
  vim.diagnostic.jump { count = 1, float = true }
end, { desc = 'Go to next [D]iagnostic message' })
map('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Buffers
map('n', '<Tab>', '<cmd>bnext<CR>', { desc = 'Next buffer' })
map('n', '<S-Tab>', '<cmd>bprev<CR>', { desc = 'Previous buffer' })
for i = 1, 9 do
  map('n', '<A-' .. i .. '>', function()
    local bufs = vim.fn.getbufinfo { buflisted = 1 }
    if bufs[i] then
      vim.cmd.buffer(bufs[i].bufnr)
    end
  end, { desc = 'Go to buffer ' .. i })
end
map('n', '<A-x>', '<cmd>bd<CR>', { desc = 'Close buffer' })
map('n', '<A-c>', function()
  require('mini.bufremove').delete(0, false)
end, { desc = 'Close buffer (keep window)' })

-- Move highlighted text up/down
map('v', 'J', ":m '>+1<CR>gv=gv", { silent = true })
map('v', 'K', ":m '<-2<CR>gv=gv", { silent = true })

map('n', '<leader>-', '<cmd>Explore<CR>', { desc = 'File explorer' })
