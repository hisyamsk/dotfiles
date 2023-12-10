-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself

  -- color scheme
  use('wbthomason/packer.nvim')
  use('folke/tokyonight.nvim')
  use('w0ng/vim-hybrid')
  use('drewtempelmeyer/palenight.vim')
  use('sainnhe/sonokai')
  use('sainnhe/everforest')
  use('sainnhe/gruvbox-material')
  use('rebelot/kanagawa.nvim')
  use('catppuccin/nvim')
  use({ 'bluz71/vim-nightfly-colors', as = 'nightfly' })

  -- terminal wrapper
  use('akinsho/toggleterm.nvim')
  
  -- pairs
  use('tpope/vim-surround')
  use('jiangmiao/auto-pairs')

  -- code folding
  use ({'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async'})  

  -- indent line
  use('lukas-reineke/indent-blankline.nvim')

  -- git 
  use('dinhhuy258/git.nvim')
  use('f-person/git-blame.nvim')

  -- Completion
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-cmdline")
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-path")
  use("hrsh7th/nvim-cmp")
  -- completion icons
  use("onsails/lspkind.nvim")

  -- Language server
  use("neovim/nvim-lspconfig")
  use("williamboman/nvim-lsp-installer")

  -- go.nvim
  use('ray-x/go.nvim')
  use('ray-x/guihua.lua') 

  -- Code formatter & linter
  use('jose-elias-alvarez/null-ls.nvim')

  -- Prettier
  use('MunifTanjim/prettier.nvim')

  -- Motor de snippets
  use("L3MON4D3/LuaSnip")
  use("saadparwaiz1/cmp_luasnip")

  -- Syntax parser
  use("nvim-treesitter/nvim-treesitter")

  -- Comment
  use("terrortylor/nvim-comment")

  -- Utils
  use("norcalli/nvim-colorizer.lua")
  use("lewis6991/gitsigns.nvim")

  -- Dependencies
  use("nvim-lua/plenary.nvim")
  use("kyazdani42/nvim-web-devicons")
  use("MunifTanjim/nui.nvim")

  -- File browser
  use("nvim-telescope/telescope.nvim")

  -- Interface
  use("akinsho/bufferline.nvim")
  use({
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = { 
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    }
  })
  use("nvim-lualine/lualine.nvim")

  -- lsp code preview
  use({
    'rmagatti/goto-preview',
    config = function()
      require('goto-preview').setup {}
    end
  })
end)
