return { -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  config = function()
    require('mini.pairs').setup()
    -- require('mini.statusline').setup()
    -- require('mini.surround').setup()
    -- require('mini.diff').setup {
    --   view = {
    --     -- Visualization style. Possible values are 'sign' and 'number'.
    --     -- Default: 'number' if line numbers are enabled, 'sign' otherwise.
    --     style = 'sign',
    --
    --     -- Signs used for hunks with 'sign' view
    --     signs = { add = '+', change = '~', delete = '_' },
    --
    --     -- Priority of used visualization extmarks
    --     priority = 199,
    --   },
    -- }
  end,
}
