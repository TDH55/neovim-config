return {
  -- Git integration. Open with <:Neogit> and then you can manage branches, commits, etc.
  -- Allows you to stage and unstage changes, commit, push, pull, etc.
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",    -- required
    "sindrets/diffview.nvim",   -- optional - Diff integration

    -- Only one of these is needed, not both.
    "nvim-telescope/telescope.nvim",   -- optional
    "ibhagwan/fzf-lua",                -- optional
  },
  config = true,
  event = "VeryLazy",
}
