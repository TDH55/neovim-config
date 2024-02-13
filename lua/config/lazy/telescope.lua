return {
  -- This plugin is used for fuzzy searching
  'nvim-telescope/telescope.nvim',
  version = "0.1.5", -- TODO: why is this pinned?
  dependencies = {
    'nvim-lua/plenary.nvim'
  },
  config = function()
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>pf', builtin.find_files, {})                         -- <leader>pf to search all files
    vim.keymap.set('n', '<C-p>', builtin.git_files, {})                               -- <Ctrl-p> to search git files
    vim.keymap.set('n', '<leader>fb', '<cmd>Telescope current_buffer_fuzzy_find<CR>') -- <leader>fb to search in current buffer (similar to <Cmd-f>)
    vim.keymap.set('n', '<leader>fa', '<cmd>Telescope live_grep<CR>')                 -- <leader>fa to search in all files (similar to <Cmd-Shift-f>)
    vim.keymap.set('n', '<leader>fr', builtin.lsp_references, {})                     -- <leader>fr When the cursor is on a symbol, search the references of the symbol
    vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols, {})               -- <leader>fs to search for the highlighted symbol in the current document
    vim.keymap.set('n', '<leader>fp', builtin.diagnostics, {})                        -- <leader>fp to search for diagnostics (e.g. errors, warnings, etc.)
    vim.keymap.set('n', '<leader>fc', builtin.commands, {})                           -- <leader>fc to search for vim commands
    vim.keymap.set('n', '<leader>ps',
      function()                                                                      -- <leader>ps also similar to <Cmd-Shift-f>
        builtin.grep_string({ search = vim.fn.input("Grep > ") });
      end)
  end
}
