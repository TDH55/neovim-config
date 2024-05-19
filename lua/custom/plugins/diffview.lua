return {
  -- Can be used to view a diff without leaving vim. open a diff with <leader>gdo and close with <leader>gdc
  'sindrets/diffview.nvim',
  event = "VeryLazy",
  config = function()
    require('diffview').setup()
    vim.keymap.set('n', '<leader>gdo', '<cmd>DiffviewOpen<cr>')
    vim.keymap.set('n', '<leader>gdc', '<cmd>DiffviewClose<cr>')
  end
}
