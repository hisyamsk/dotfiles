require('mini.pairs').setup()
require('mini.bufremove').setup()

-- Surround with vim-surround keys: ys{motion}{char}, yss, ds{char}, cs{old}{new}, visual S
require('mini.surround').setup {
  mappings = {
    add = 'ys',
    delete = 'ds',
    replace = 'cs',
    find = '',
    find_left = '',
    highlight = '',
    suffix_last = '',
    suffix_next = '',
  },
  search_method = 'cover_or_next',
}
vim.keymap.del('x', 'ys')
vim.keymap.set('x', 'S', [[:<C-u>lua MiniSurround.add('visual')<CR>]], { silent = true })
vim.keymap.set('n', 'yss', 'ys_', { remap = true })

-- Fuzzy finder (replaces telescope, same keys)
require('mini.pick').setup()
require('mini.extra').setup()
vim.ui.select = MiniPick.ui_select

local pick, extra = MiniPick.builtin, MiniExtra.pickers
local map = function(keys, fn, desc)
  vim.keymap.set('n', keys, fn, { desc = desc })
end

map('<leader>sh', pick.help, '[S]earch [H]elp')
map('<leader>sk', extra.keymaps, '[S]earch [K]eymaps')
map('<leader>sf', pick.files, '[S]earch [F]iles')
map('<leader>ss', function()
  local names = vim.tbl_keys(MiniPick.registry)
  table.sort(names)
  vim.ui.select(names, { prompt = 'Pickers' }, function(name)
    if name then
      vim.schedule(MiniPick.registry[name])
    end
  end)
end, '[S]earch [S]elect Picker')
map('<leader>sw', function()
  pick.grep { pattern = vim.fn.expand '<cword>' }
end, '[S]earch current [W]ord')
map('<leader>sg', pick.grep_live, '[S]earch by [G]rep')
map('<leader>sd', extra.diagnostic, '[S]earch [D]iagnostics')
map('<leader>sr', pick.resume, '[S]earch [R]esume')
map('<leader>s.', extra.oldfiles, '[S]earch Recent Files')
map('<leader><leader>', pick.buffers, '[ ] Find existing buffers')
map('<leader>/', function()
  extra.buf_lines { scope = 'current' }
end, '[/] Fuzzily search in current buffer')
map('<leader>s/', function()
  extra.buf_lines { scope = 'all' }
end, '[S]earch [/] in Open Files')
map('<leader>sn', function()
  pick.files(nil, { source = { cwd = vim.fn.stdpath 'config' } })
end, '[S]earch [N]eovim files')
