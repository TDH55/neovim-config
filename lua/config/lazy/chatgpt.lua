return {
  -- a plugin to access chat gpt in neovim, it uses an api key and can be configured to use different models and have different gpt related settings
  -- open with <:ChatGPT>
  "jackMort/ChatGPT.nvim",
  event = "VeryLazy",
  config = function()
    require("chatgpt").setup({
      api_key_cmd = "op read op://private/OpenAI/credential --no-newline",
    })
  end,
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "folke/trouble.nvim",
    "nvim-telescope/telescope.nvim"
  }
}
