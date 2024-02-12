return {
  {
    -- This plugin manages lsp stuff (e.g. autocompletion, diagnostics, etc.). I haven't looked into other setups but it seems to work very well and is popular and supported
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
  -- TODO: look into if this is still the best setup
  -- These are used to manage LSPs, use the command <:Mason> to get a ui where lsp's can be installed and uninstalled
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  {
    -- This needs to be cleaned up but it's a plugin that allows you to search through symbols (e.g. functions, variables, etc.) in a file
    -- mapped to <leader>o
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "SmiteshP/nvim-navbuddy",
        dependencies = {
          "SmiteshP/nvim-navic",
          "MunifTanjim/nui.nvim"
        },
        opts = { lsp = { auto_attach = true } },
        keys = {
          { '<leader>o', function() require('nvim-navbuddy').open() end, desc = "Open NavBuddy" },
        }
      }
    },
    -- your lsp config or other stuff
  },
  -- inlay hints from the lsp
  'lvimuser/lsp-inlayhints.nvim',
}
