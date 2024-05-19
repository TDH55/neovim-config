return {
  -- a plugin for easy manipulation of surrounding characters (e.g. quotes, brackets, etc.)
  -- example: use <leader>sr'" to replace the surrounding singgle quotes with double quotes
  'echasnovski/mini.surround',
  event = "VeryLazy",
  config = true,
  opts = {
    mappings = {
      add = '<leader>as',            -- [A]dd [s]urrounding in Normal and Visual modes
      delete = '<leader>ds',         -- [D]elete [s]urrounding
      find = '<leader>fs',           -- [F]ind [s]urrounding (to the right)
      find_left = '<leader>Fs',      -- [F]ind [s]urrounding (to the left)
      highlight = '<leader>hs',      -- [H]ighlight [s]urrounding
      replace = '<leader>rs',        -- [R]eplace [s]urrounding
      update_n_lines = '<leader>sn', -- Update `n_lines`

      suffix_last = 'l',             -- Suffix to search with "prev" method
      suffix_next = 'n',             -- Suffix to search with "next" method
    },
  },
}
