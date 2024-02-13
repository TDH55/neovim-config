return {
  -- highlights comments such as todos, fixmes, etc.
  -- eg.:
  -- TODO: this is a todo
  -- FIXME: this is a fixme
  -- FIX: this is a fix
  -- BUG: this is a bug
  -- HACK: this is a hack
  -- NOTE: this is a note
  -- PERF: this is a perf
  -- OPTIMIZE: this is an optimize
  -- WARN:: this is a warn
  -- WARNING: this is a warning
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  event = "VeryLazy",
}
