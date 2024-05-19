return {
  -- a plugin for easy commenting. Currently mapped to gcc to comment a line and gc to comment a visual selection
  "echasnovski/mini.comment",
  event = "VeryLazy",
  config = function()
    require("mini.comment").setup()
  end,
}
