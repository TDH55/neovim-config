return {
  -- Can be used to show a list of lsp diagnostics.
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  config = function ()
    local trouble = require("trouble")

    require('trouble').setup()
    vim.keymap.set("n", "<leader>tt", function() trouble.toggle() end)
    vim.keymap.set("n", "<leader>tw", function() trouble.toggle("workspace_diagnostics") end)
    vim.keymap.set("n", "<leader>td", function() trouble.toggle("document_diagnostics") end)
    vim.keymap.set("n", "<leader>tq", function() trouble.toggle("quickfix") end)
    vim.keymap.set("n", "<leader>tl", function() trouble.toggle("loclist") end)
    vim.keymap.set("n", "gr", function() trouble.toggle("lsp_references") end)
  end
}
