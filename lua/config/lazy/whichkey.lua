return {
  -- This gives some helpful hints of possible keybindings that can be used after typing a partial command
  -- ex. type <leader> and then it will show possible next keys and what they do (if they trigger an action they will show the action, if they are followed by more keys they will show an arrow and then possible bindings once typed)
  "folke/which-key.nvim",
  enabled = true,
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
}
