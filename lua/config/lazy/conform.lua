return {
  -- Used for formatting and linting. Currently setup to use biome but can also be configured for eslint, prettier, etc.
  'stevearc/conform.nvim',
  opts = {},
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        -- Use a sub-list to run only the first available formatter
        javascript = { { "biome", "prettierd", "prettier" } },
        typescript = { { "biome" } },
      },

      format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_fallback = false, -- set to false because lsp format can be performed with <leader>fl
      },
    })
  end,
}
