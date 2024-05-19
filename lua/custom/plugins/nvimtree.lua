return {
  {
    -- A file tree plugin. The tree can be toggled with <leader>nt
    'nvim-tree/nvim-tree.lua',
    enabled = true,
    config = function()
      -- disable netrw at the very start of your init.lua
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
      require('nvim-tree').setup()
      vim.keymap.set('n', '<leader>nt', ':NvimTreeToggle<CR>') -- <leader>nt to toggle the file tree
    end
  },

  'nvim-tree/nvim-web-devicons', -- icons for the file tree
}
