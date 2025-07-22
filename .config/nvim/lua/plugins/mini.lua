return { -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  config = function()
    require('mini.pairs').setup()
    require('mini.statusline').setup {
      content = {
        active = function()
          -- Get components
          local mode, mode_hl = MiniStatusline.section_mode { trunc_width = 120 }
          local git = MiniStatusline.section_git { trunc_width = 75 }
          local diagnostics = MiniStatusline.section_diagnostics { trunc_width = 75 }
          local filename = vim.fn.expand '%:t' -- Only show filename (no path)
          local fileinfo = MiniStatusline.section_fileinfo { trunc_width = 120 }
          local location = MiniStatusline.section_location { trunc_width = 75 }

          -- Combine groups
          return MiniStatusline.combine_groups {
            { hl = mode_hl, strings = { mode } },
            { hl = 'MiniStatuslineDevinfo', strings = { git, diagnostics } },
            '%<', -- Truncate from here if needed
            { hl = 'MiniStatuslineFilename', strings = { filename } },
            '%=', -- Left/right separator
            { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
            { hl = mode_hl, strings = { location } },
          }
        end,
      },
      require('mini.bufremove').setup(),
      require('mini.tabline').setup(),

      vim.keymap.set('n', '<A-c>', function()
        require('mini.bufremove').delete(0, false)
      end),
    }
  end,
}
