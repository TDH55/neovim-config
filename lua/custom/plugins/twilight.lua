-- This plugin can be used to dim inactive portions of the buffer. (e.g. if your cursor is in an if block, code outside the if block will be dimmed)
return {
  "folke/twilight.nvim",
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  event = "VeryLazy"
}
