return {
  -- Github Copilot, currently setup to use <Ctrl-TAB> to accept the suggestion (tab works if no lsp suggestions are presented)
  'github/copilot.vim',
  config = function()
    vim.keymap.set('i', '<C-TAB>', 'copilot#Accept("\\<CR>")', {
      expr = true,
      replace_keycodes = false
    })
    vim.g.copilot_no_tab_map = true
  end
}
