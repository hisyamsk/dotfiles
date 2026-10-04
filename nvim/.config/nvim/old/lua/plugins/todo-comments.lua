-- Highlight todo, notes, etc in comments
return
-- Highlight todo, notes, etc in comments
{ 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
{ -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  config = function()
    require('mini.surround').setup()
    require('mini.pairs').setup()
  end,
}
