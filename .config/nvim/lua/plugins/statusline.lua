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
    local colors = {
      bg = '#202328',
      fg = '#bbc2cf',
      yellow = '#ECBE7B',
      cyan = '#008080',
      darkblue = '#081633',
      green = '#98be65',
      orange = '#FF8800',
      violet = '#a9a1e1',
      magenta = '#c678dd',
      blue = '#51afef',
      red = '#ec5f67',
    }

    local conditions = {
      buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand '%:t') ~= 1
      end,
      hide_in_width = function()
        return vim.fn.winwidth(0) > 80
      end,
      check_git_workspace = function()
        local filepath = vim.fn.expand '%:p:h'
        local gitdir = vim.fn.finddir('.git', filepath .. ';')
        return gitdir and #gitdir > 0 and #gitdir < #filepath
      end,
    }

    -- Config
    local config = {
      options = {
        -- Disable sections and component separators
        component_separators = '',
        section_separators = '',
        theme = {
          -- We are going to use lualine_c an lualine_x as left and
          -- right section. Both are highlighted by c theme .  So we
          -- are just setting default looks o statusline
          normal = { c = { fg = colors.fg, bg = colors.bg } },
          inactive = { c = { fg = colors.fg, bg = colors.bg } },
        },
      },
      sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        -- These will be filled later
        lualine_c = {},
        lualine_x = {},
      },
      inactive_sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {},
      },
    }

    -- Inserts a component in lualine_c at left section
    local function ins_left(component)
      table.insert(config.sections.lualine_c, component)
    end

    -- Inserts a component in lualine_x at right section
    local function ins_right(component)
      table.insert(config.sections.lualine_x, component)
    end

    ins_left {
      function()
        return '▊'
      end,
      color = { fg = colors.blue }, -- Sets highlighting of component
      padding = { left = 0, right = 1 }, -- We don't need space before this
    }

    ins_left {
      -- mode component
      function()
        return ''
      end,
      color = function()
        -- auto change color according to neovims mode
        local mode_color = {
          n = colors.red,
          i = colors.green,
          v = colors.blue,
          [''] = colors.blue,
          V = colors.blue,
          c = colors.magenta,
          no = colors.red,
          s = colors.orange,
          S = colors.orange,
          [''] = colors.orange,
          ic = colors.yellow,
          R = colors.violet,
          Rv = colors.violet,
          cv = colors.red,
          ce = colors.red,
          r = colors.cyan,
          rm = colors.cyan,
          ['r?'] = colors.cyan,
          ['!'] = colors.red,
          t = colors.red,
        }
        return { fg = mode_color[vim.fn.mode()] }
      end,
      padding = { right = 1 },
    }

    ins_left {
      -- filesize component
      'filesize',
      cond = conditions.buffer_not_empty,
    }

    ins_left {
      'filename',
      cond = conditions.buffer_not_empty,
      color = { fg = colors.magenta, gui = 'bold' },
    }

    ins_left { 'location' }

    ins_left { 'progress', color = { fg = colors.fg, gui = 'bold' } }

    ins_left {
      'diagnostics',
      sources = { 'nvim_diagnostic' },
      symbols = { error = ' ', warn = ' ', info = ' ' },
      diagnostics_color = {
        error = { fg = colors.red },
        warn = { fg = colors.yellow },
        info = { fg = colors.cyan },
      },
    }

    -- Insert mid section. You can make any number of sections in neovim :)
    -- for lualine it's any number greater then 2
    ins_left {
      function()
        return '%='
      end,
    }

    ins_left {
      -- Lsp server name .
      function()
        local msg = 'No Active Lsp'
        local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
        local clients = vim.lsp.get_active_clients()
        if next(clients) == nil then
          return msg
        end
        for _, client in ipairs(clients) do
          local filetypes = client.config.filetypes
          if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            return client.name
          end
        end
        return msg
      end,
      icon = ' LSP:',
      color = { fg = '#ffffff', gui = 'bold' },
    }

    -- Add components to right sections
    ins_right {
      'o:encoding', -- option component same as &encoding in viml
      fmt = string.upper, -- I'm not sure why it's upper case either ;)
      cond = conditions.hide_in_width,
      color = { fg = colors.green, gui = 'bold' },
    }

    ins_right {
      'fileformat',
      fmt = string.upper,
      icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
      color = { fg = colors.green, gui = 'bold' },
    }

    ins_right {
      'branch',
      icon = '',
      color = { fg = colors.violet, gui = 'bold' },
    }

    ins_right {
      'diff',
      -- Is it me or the symbol for modified us really weird
      symbols = { added = ' ', modified = '󰝤 ', removed = ' ' },
      diff_color = {
        added = { fg = colors.green },
        modified = { fg = colors.orange },
        removed = { fg = colors.red },
      },
      cond = conditions.hide_in_width,
    }

    ins_right {
      function()
        return '▊'
      end,
      color = { fg = colors.blue },
      padding = { left = 1 },
    }
    require('lualine').setup(config)
  end,
}

local feline = {
  'freddiehaddad/feline.nvim',
  opts = {},
  config = function(_, opts)
    local line_ok, feline = pcall(require, 'feline')
    if not line_ok then
      return
    end

    local one_monokai = {
      fg = '#abb2bf',
      bg = '#1e2024',
      green = '#98c379',
      yellow = '#e5c07b',
      purple = '#c678dd',
      orange = '#d19a66',
      peanut = '#f6d5a4',
      red = '#e06c75',
      aqua = '#61afef',
      darkblue = '#282c34',
      dark_red = '#f75f5f',
    }

    local vi_mode_colors = {
      NORMAL = 'green',
      OP = 'green',
      INSERT = 'yellow',
      VISUAL = 'purple',
      LINES = 'orange',
      BLOCK = 'dark_red',
      REPLACE = 'red',
      COMMAND = 'aqua',
    }

    local c = {
      vim_mode = {
        provider = {
          name = 'vi_mode',
          opts = {
            show_mode_name = true,
            -- padding = "center", -- Uncomment for extra padding.
          },
        },
        hl = function()
          return {
            fg = require('feline.providers.vi_mode').get_mode_color(),
            bg = 'darkblue',
            style = 'bold',
            name = 'NeovimModeHLColor',
          }
        end,
        left_sep = 'block',
        right_sep = 'block',
      },
      gitBranch = {
        provider = 'git_branch',
        hl = {
          fg = 'peanut',
          bg = 'darkblue',
          style = 'bold',
        },
        left_sep = 'block',
        right_sep = 'block',
      },
      gitDiffAdded = {
        provider = 'git_diff_added',
        hl = {
          fg = 'green',
          bg = 'darkblue',
        },
        left_sep = 'block',
        right_sep = 'block',
      },
      gitDiffRemoved = {
        provider = 'git_diff_removed',
        hl = {
          fg = 'red',
          bg = 'darkblue',
        },
        left_sep = 'block',
        right_sep = 'block',
      },
      gitDiffChanged = {
        provider = 'git_diff_changed',
        hl = {
          fg = 'fg',
          bg = 'darkblue',
        },
        left_sep = 'block',
        right_sep = 'right_filled',
      },
      separator = {
        provider = '',
      },
      fileinfo = {
        provider = {
          name = 'file_info',
          opts = {
            type = 'relative-short',
          },
        },
        hl = {
          style = 'bold',
        },
        left_sep = ' ',
        right_sep = ' ',
      },
      diagnostic_errors = {
        provider = 'diagnostic_errors',
        hl = {
          fg = 'red',
        },
      },
      diagnostic_warnings = {
        provider = 'diagnostic_warnings',
        hl = {
          fg = 'yellow',
        },
      },
      diagnostic_hints = {
        provider = 'diagnostic_hints',
        hl = {
          fg = 'aqua',
        },
      },
      diagnostic_info = {
        provider = 'diagnostic_info',
      },
      lsp_client_names = {
        provider = 'lsp_client_names',
        hl = {
          fg = 'purple',
          bg = 'darkblue',
          style = 'bold',
        },
        left_sep = 'left_filled',
        right_sep = 'block',
      },
      file_type = {
        provider = {
          name = 'file_type',
          opts = {
            filetype_icon = true,
            case = 'titlecase',
          },
        },
        hl = {
          fg = 'red',
          bg = 'darkblue',
          style = 'bold',
        },
        left_sep = 'block',
        right_sep = 'block',
      },
      file_encoding = {
        provider = 'file_encoding',
        hl = {
          fg = 'orange',
          bg = 'darkblue',
          style = 'italic',
        },
        left_sep = 'block',
        right_sep = 'block',
      },
      position = {
        provider = 'position',
        hl = {
          fg = 'green',
          bg = 'darkblue',
          style = 'bold',
        },
        left_sep = 'block',
        right_sep = 'block',
      },
      line_percentage = {
        provider = 'line_percentage',
        hl = {
          fg = 'aqua',
          bg = 'darkblue',
          style = 'bold',
        },
        left_sep = 'block',
        right_sep = 'block',
      },
      scroll_bar = {
        provider = 'scroll_bar',
        hl = {
          fg = 'yellow',
          style = 'bold',
        },
      },
    }

    local left = {
      c.vim_mode,
      c.gitBranch,
      c.gitDiffAdded,
      c.gitDiffRemoved,
      c.gitDiffChanged,
      c.separator,
    }

    local middle = {
      c.fileinfo,
      c.diagnostic_errors,
      c.diagnostic_warnings,
      c.diagnostic_info,
      c.diagnostic_hints,
    }

    local right = {
      c.lsp_client_names,
      c.file_type,
      c.file_encoding,
      c.position,
      c.line_percentage,
      c.scroll_bar,
    }

    local components = {
      active = {
        left,
        middle,
        right,
      },
      inactive = {
        left,
        middle,
        right,
      },
    }

    feline.setup {
      components = components,
      theme = one_monokai,
      vi_mode_colors = vi_mode_colors,
    }
  end,
}

return statusline
