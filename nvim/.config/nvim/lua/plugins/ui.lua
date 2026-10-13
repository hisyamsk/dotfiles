require('kanagawa').setup {
  commentStyle = { italic = false },
  colors = {
    theme = {
      all = {
        ui = {
          bg_gutter = 'none',
          -- Popup menus share the float bg (sumiInk0) instead of waveBlue1
          pmenu = { bg = '#16161D', bg_sbar = '#16161D' },
        },
      },
    },
  },
  overrides = function()
    return {
      -- gopls tags every keyword as plain "keyword", which would cover
      -- treesitter's finer captures (e.g. red @keyword.return)
      ['@lsp.type.keyword.go'] = {},
    }
  end,
}
vim.cmd.colorscheme 'kanagawa-wave'

require('mini.icons').setup()
MiniIcons.mock_nvim_web_devicons()

require('mini.tabline').setup()
require('mini.diff').setup()

require('mini.statusline').setup {
  content = {
    active = function()
      local mode, mode_hl = MiniStatusline.section_mode { trunc_width = 120 }
      local git = MiniStatusline.section_git { trunc_width = 75 }
      local diff = MiniStatusline.section_diff { trunc_width = 75 }
      local diagnostics = MiniStatusline.section_diagnostics { trunc_width = 75 }
      local filename = vim.fn.expand '%:t' -- Only show filename (no path)
      local fileinfo = MiniStatusline.section_fileinfo { trunc_width = 120 }
      local location = MiniStatusline.section_location { trunc_width = 75 }

      return MiniStatusline.combine_groups {
        { hl = mode_hl, strings = { mode } },
        { hl = 'MiniStatuslineDevinfo', strings = { git, diff, diagnostics } },
        '%<',
        { hl = 'MiniStatuslineFilename', strings = { filename } },
        '%=',
        { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
        { hl = mode_hl, strings = { location } },
      }
    end,
  },
}

vim.diagnostic.config {
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.INFO] = ' ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    },
  },
}
