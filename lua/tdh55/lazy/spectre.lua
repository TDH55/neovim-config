return {
  -- Another way to search all files but this supports search and replace. Use <leader>ss to open the search and replace
  "nvim-pack/nvim-spectre",
  build = false,
  cmd = "Spectre",
  opts = { open_cmd = "noswapfile vnew" },
  -- stylua: ignore
  keys = {
    { "<leader>ss", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
  },
}
