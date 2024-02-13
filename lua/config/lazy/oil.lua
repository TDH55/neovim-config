return {
  -- Another file management plugin. This is presented on launch and can be used to open files, rename, delete, etc. It allows managing files as a buffer so names can be changed and files can be deleted as you would manage any other text
  'stevearc/oil.nvim',
  enabled = true,
  opts = {},
  config = function()
    require('oil').setup()
    vim.keymap.set('n', '<leader>to', '<cmd>Oil --float ./<cr>')   -- <leader>to to open oil
  end,
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" },
}
