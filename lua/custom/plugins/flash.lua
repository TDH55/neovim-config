return {
  -- This provices some nice new motions for navigating text.
  -- E.g. s<char> will then create shortcuts after each instance fo the character that can be typed to jump to that location. Multiple characters can be typed to narrow down the search
  -- Also provides some enhancements to the f, F, t, and T motions (read more in the doccumentation for the plugin on github)
  "folke/flash.nvim",
  event = "VeryLazy",
  ---@type Flash.Config
  opts = {},
  -- stylua: ignore
  keys = {
    { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
    { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
    { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
    { "<leader>tS",     mode = { "n", "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    -- TODO: make this default to true
    { "<leader>tf", mode = { "c", "n", "x", "o" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
  },
}
