-- return {
--   -- Adds git status to teh gutter, also has other features such as line blame that can be configured or activated with a command such as <:Gitsigns toggle_current_line_blame>
--   "lewis6991/gitsigns.nvim",
--   event = "VeryLazy",
--   opts = {},
--   config = true
-- }

-- Here is a more advanced example where we pass configuration
-- options to `gitsigns.nvim`. This is equivalent to the following Lua:
--    require('gitsigns').setup({ ... })
--
-- See `:help gitsigns` to understand what the configuration keys do
return { -- Adds git related signs to the gutter, as well as utilities for managing changes
  'lewis6991/gitsigns.nvim',
  opts = {
    signs = {
      add = { text = '+' },
      change = { text = '~' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
    },
  },
}
