return { -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  opts = {
    ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'vim', 'vimdoc' },
    -- Autoinstall languages that are not installed
    auto_install = true,
    highlight = {
      enable = true,
      -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
      --  If you are experiencing weird indenting issues, add the language to
      --  the list of additional_vim_regex_highlighting and disabled languages for indent.
      additional_vim_regex_highlighting = { 'ruby' },
    },
    indent = { enable = true, disable = { 'ruby' } },
  },
  config = function(_, opts)
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

    -- Prefer git instead of curl in order to improve connectivity in some environments
    require('nvim-treesitter.install').prefer_git = true
    ---@diagnostic disable-next-line: missing-fields
    require('nvim-treesitter.configs').setup(opts)

    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  end,
}
-- {
--   {
--     -- This plugin is used for syntax highlighting. Use :TSInstall to install new parsers (e.g. <:TSInstall typescript> to get typescript syntax highlighting)
--     'nvim-treesitter/nvim-treesitter',
--     build = ':TSUpdate',
--     dependencies = {
--       "nushell/tree-sitter-nu"
--     },
--     config = function()
--       vim.filetype.add({
--         extension = {
--           hurl = "hurl"
--         }
--       })
--       require('nvim-treesitter.configs').setup({
--         -- A list of parser names, or "all" (the five listed parsers should always be installed)
--         ensure_installed = { "vue", "yaml", "json", "json5", "html", "javascript", "typescript", "c", "lua", "vim", "vimdoc", "query", "nu", "hurl" },

--         -- Install parsers synchronously (only applied to `ensure_installed`)
--         sync_install = false,

--         -- Automatically install missing parsers when entering buffer
--         -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
--         auto_install = true,

--         -- List of parsers to ignore installing (or "all")

--         ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
--         -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

--         highlight = {
--           enable = true,

--           -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
--           -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
--           -- the name of the parser)
--           -- list of language that will be disabled
--           --
--           -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files

--           -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
--           -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
--           -- Using this option may slow down your editor, and you may see some duplicate highlights.
--           -- Instead of true it can also be a list of languages
--           additional_vim_regex_highlighting = false,
--         },
--         indent = { enable = true }
--       })
--     end,
--   },
--   'nvim-treesitter/playground' -- This can be used to visulize how Treesitter does it's highlighting, not really useful for development but can be interesting
-- }
