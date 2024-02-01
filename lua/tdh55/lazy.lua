 --TODO: file to replace packer.lua
 --NOTE: bootstrapping lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- NOTE: set mapleader before lazy so mappings are correct
vim.g.mapleader = " "
--TODO: reoganize
require('lazy').setup({
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    config = function()
      vim.cmd('colorscheme rose-pine')
    end
  },

  {
    'nvim-telescope/telescope.nvim',
    version = "0.1.5", -- TODO: why is this pinned?
    dependencies = {
      'nvim-lua/plenary.nvim'
    }
  },

  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate'
  },

  'nvim-treesitter/playground',
  'theprimeagen/harpoon',
  'mbbill/undotree',
  'tpope/vim-fugitive',
  
  -- TODO: look into if this is still the best setup
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    dependencies = {
      -- LSP support
      'neovim/nvim-lspconfig',
      -- Autocompletion
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',
    }
  },

  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  'neovim/nvim-lspconfig',
  'github/copilot.vim',
  'lvimuser/lsp-inlayhints.nvim',
  'preservim/nerdcommenter',
  'nvim-tree/nvim-tree.lua',
  'nvim-tree/nvim-web-devicons',
  'tpope/vim-surround',
  'm4xshen/autoclose.nvim',
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require('dashboard').setup()
    end,
    dependencies = {
      'nvim-web-devicons'
    }
  },
  {
    'folke/todo-comments.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim'
    }
  },

  'ggandor/leap.nvim',
  'smoka7/multicursors.nvim',
  'smoka7/hydra.nvim'
})
