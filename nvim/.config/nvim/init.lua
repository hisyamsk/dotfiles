vim.loader.enable()

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

require 'config.options'
require 'config.keymaps'
require 'config.autocmds'

-- Run build steps after install/update (vim.pack is built into nvim 0.12)
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'nvim-treesitter' and kind == 'update' then
      if not ev.data.active then
        vim.cmd.packadd 'nvim-treesitter'
      end
      vim.cmd 'TSUpdate'
    end
  end,
})

local gh = function(repo)
  return 'https://github.com/' .. repo
end

vim.pack.add {
  gh 'rebelot/kanagawa.nvim',
  gh 'nvim-mini/mini.nvim',
  gh 'tpope/vim-sleuth',
  { src = gh 'nvim-treesitter/nvim-treesitter', version = 'main' },
  gh 'neovim/nvim-lspconfig',
  gh 'mason-org/mason.nvim',
  gh 'mason-org/mason-lspconfig.nvim',
  gh 'folke/lazydev.nvim',
  { src = gh 'saghen/blink.cmp', version = vim.version.range '1.*' },
  gh 'stevearc/conform.nvim',
}

require 'plugins.ui'
require 'plugins.editor'
require 'plugins.treesitter'
require 'plugins.completion'
require 'plugins.lsp'
require 'plugins.format'
