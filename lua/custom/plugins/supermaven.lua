return {
  'supermaven-inc/supermaven-nvim',
  enabled = true,
  config = function()
    local supermaven = require 'supermaven-nvim'
    supermaven.setup {}

    -- vim.keymap.set("n", "<S-Tab>", supermaven.accept_suggestion, {})
    -- vim.keymap.set("n", "<Tab>", supermaven.accept_suggestion, {})
    vim.keymap.set('n', '<S-Tab>', function()
      supermaven.accept_suggestion()
    end, {})
    vim.keymap.set('n', '<Tab>', function()
      supermaven.accept_suggestion()
    end, {})
  end,
}
