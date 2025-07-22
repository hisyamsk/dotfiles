local statusline = {
  'beauwilliams/statusline.lua',
  config = function()
    local statusline = require 'statusline'
    statusline.tabline = false
  end,
}

local lualine = {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup()
  end,
}

return lualine
