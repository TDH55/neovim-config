return {
  -- This plugin provides a visual tree of undos and redos. Can be opened with <leader>u and used to manage undos and redos
  'mbbill/undotree',
  config = function()
    vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
  end,
  event = "VeryLazy"
}
