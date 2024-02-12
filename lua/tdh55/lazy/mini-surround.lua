return {
  -- a plugin for easy manipulation of surrounding characters (e.g. quotes, brackets, etc.)
  -- example: use <leader>sr'" to replace the surrounding singgle quotes with double quotes
  'echasnovski/mini.surround',
  event = "VeryLazy",
  config = true,
  opts = {
    mappings = {
      add = '<leader>sa',              -- Add surrounding in Normal and Visual modes
      delete = '<leader>sd',           -- Delete surrounding
      find = '<leader>sf',             -- Find surrounding (to the right)
      find_left = '<leader>sF',        -- Find surrounding (to the left)
      highlight = '<leader>sh',        -- Highlight surrounding
      replace = '<leader>sr',          -- Replace surrounding
      update_n_lines = '<leader>sn',   -- Update `n_lines`

      suffix_last = 'l',               -- Suffix to search with "prev" method
      suffix_next = 'n',               -- Suffix to search with "next" method
    },
  },
}
