--TODO: file to replace packer.lua
--NOTE: bootstrapping lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- NOTE: set mapleader before lazy so mappings are correct
vim.g.mapleader = " "
--TODO: reoganize
require('lazy').setup({
  {
    -- THEME
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    init = function()
      vim.cmd('colorscheme tokyonight-night')
    end,
  },
  {
    -- This plugin highlights colors in the code (such as css colors) when activated (:ColorizerToggle)
    'norcalli/nvim-colorizer.lua',
    config = true
  },
  {
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
  },

  {
    -- This plugin is used for syntax highlighting. Use :TSInstall to install new parsers (e.g. <:TSInstall typescript> to get typescript syntax highlighting)
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = {
      "nushell/tree-sitter-nu"
    },
    config = function()
      require('nvim-treesitter.configs').setup({
        -- A list of parser names, or "all" (the five listed parsers should always be installed)
        ensure_installed = { "vue", "yaml", "json", "json5", "html", "javascript", "typescript", "c", "lua", "vim", "vimdoc", "query", "nu" },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
        auto_install = true,

        -- List of parsers to ignore installing (or "all")

        ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
        -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

        highlight = {
          enable = true,

          -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
          -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
          -- the name of the parser)
          -- list of language that will be disabled
          --
          -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files

          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        },
      })
    end,
  },
  'nvim-treesitter/playground', -- This can be used to visulize how Treesitter does it's highlighting, not really useful for development but can be interesting
  {
    -- This plugin provides a visual tree of undos and redos. Can be opened with <leader>u and used to manage undos and redos
    'mbbill/undotree',
    config = function()
      vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
    end,
    event = "VeryLazy"
  },
  -- TODO: look into if this is still the best setup
  {
    -- This plugin manages lsp stuff (e.g. autocompletion, diagnostics, etc.). I haven't looked into other setups but it seems to work very well and is popular and supported
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    dependencies = {
      -- LSP support
      'neovim/nvim-lspconfig',
      -- Autocompletion
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',
    }
  },
  -- These are used to manage LSPs, use the command <:Mason> to get a ui where lsp's can be installed and uninstalled
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  'neovim/nvim-lspconfig',
  {
    -- Github Copilot, currently setup to use <Ctrl-TAB> to accept the suggestion (tab works if no lsp suggestions are presented)
    'github/copilot.vim',
    config = function()
      vim.keymap.set('i', '<C-TAB>', 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false
      })
      vim.g.copilot_no_tab_map = true
    end
  },
  -- inlay hints from the lsp
  'lvimuser/lsp-inlayhints.nvim',
  {
    -- A file tree plugin. The tree can be toggled with <leader>nt
    'nvim-tree/nvim-tree.lua',
    enabled = true,
    config = function()
      -- disable netrw at the very start of your init.lua
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
      require('nvim-tree').setup()
      vim.keymap.set('n', '<leader>nt', ':NvimTreeToggle<CR>') -- <leader>nt to toggle the file tree
    end
  },
  {
    -- Another file management plugin. This is presented on launch and can be used to open files, rename, delete, etc. It allows managing files as a buffer so names can be changed and files can be deleted as you would manage any other text
    'stevearc/oil.nvim',
    enabled = true,
    opts = {},
    config = function()
      require('oil').setup()
      vim.keymap.set('n', '<leader>to', '<cmd>Oil --float ./<cr>') -- <leader>to to open oil
    end,
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  'nvim-tree/nvim-web-devicons', -- icons for the file tree
  {
    -- A dashboard if nvim is opened without any file/path arguments
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require('dashboard').setup()
    end,
    dependencies = {
      'nvim-web-devicons'
    }
  },
  {
    -- highlights comments such as todos, fixmes, etc.
    -- eg.:
    -- TODO: this is a todo
    -- FIXME: this is a fixme
    -- FIX: this is a fix
    -- BUG: this is a bug
    -- HACK: this is a hack
    -- NOTE: this is a note
    -- PERF: this is a perf
    -- OPTIMIZE: this is an optimize
    -- WARN:: this is a warn
    -- WARNING: this is a warning
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    event = "VeryLazy",
  },
  {
    -- a plugin to allow multiple cursors, use <leader>m to start selecting multiple cursors
    "smoka7/multicursors.nvim",
    event = "VeryLazy",
    dependencies = {
      'smoka7/hydra.nvim',
    },
    opts = {},
    cmd = { 'MCstart', 'MCvisual', 'MCclear', 'MCpattern', 'MCvisualPattern', 'MCunderCursor' },
    keys = {
      {
        mode = { 'v', 'n' },
        '<Leader>m',
        '<cmd>MCstart<cr>',
        desc = 'Create a selection for selected text or word under the cursor',
      },
    },
  },
  'smoka7/hydra.nvim',
  {
    -- a plugin for easy manipulation of surrounding characters (e.g. quotes, brackets, etc.)
    -- example: use <leader>sr'" to replace the surrounding singgle quotes with double quotes
    'echasnovski/mini.surround',
    event = "VeryLazy",
    config = true,
    opts = {
      mappings = {
        add = '<leader>sa',            -- Add surrounding in Normal and Visual modes
        delete = '<leader>sd',         -- Delete surrounding
        find = '<leader>sf',           -- Find surrounding (to the right)
        find_left = '<leader>sF',      -- Find surrounding (to the left)
        highlight = '<leader>sh',      -- Highlight surrounding
        replace = '<leader>sr',        -- Replace surrounding
        update_n_lines = '<leader>sn', -- Update `n_lines`

        suffix_last = 'l',             -- Suffix to search with "prev" method
        suffix_next = 'n',             -- Suffix to search with "next" method
      },
    },
  },
  {
    -- A plugin to autoclose pairs of characters (e.g. quotes, brackets, etc.)
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "<leader>up",
        function()
          local Util = require("lazy.core.util")
          vim.g.minipairs_disable = not vim.g.minipairs_disable
          if vim.g.minipairs_disable then
            Util.warn("Disabled auto pairs", { title = "Option" })
          else
            Util.info("Enabled auto pairs", { title = "Option" })
          end
        end,
        desc = "Toggle auto pairs",
      },
    },
  },
  {
    -- a plugin for easy commenting. Currently mapped to gcc to comment a line and gc to comment a visual selection
    "echasnovski/mini.comment",
    event = "VeryLazy",
    version = "*",
    config = function()
      require("mini.comment").setup()
    end,
  },
  {
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
      { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
  },
  {
    -- This plugin handles the status bar at the bottom (where the git status, filename, etc. is displayed)
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {}
  },
  {
    -- indent lines
    "lukas-reineke/indent-blankline.nvim",
    event = "VeryLazy",
    opts = {
      indent = {
        char = "│",
        tab_char = "│",
      },
      scope = { enabled = false },
      exclude = {
        filetypes = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
      },
    },
    main = "ibl",
  },
  {
    -- also indent line related
    "echasnovski/mini.indentscope",
    -- version = false, -- wait till new 0.7.0 release to put it back on semver
    event = "VeryLazy",
    opts = {
      -- symbol = "▏",
      symbol = "│",
      options = { try_as_border = true },
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },
  {
    -- This needs to be cleaned up but it's a plugin that allows you to search through symbols (e.g. functions, variables, etc.) in a file
    -- mapped to <leader>o
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "SmiteshP/nvim-navbuddy",
        dependencies = {
          "SmiteshP/nvim-navic",
          "MunifTanjim/nui.nvim"
        },
        opts = { lsp = { auto_attach = true } },
        keys = {
          { '<leader>o', function() require('nvim-navbuddy').open() end, desc = "Open NavBuddy" },
        }
      }
    },
    -- your lsp config or other stuff
  },
  {
    -- Git integration. Open with <:Neogit> and then you can manage branches, commits, etc.
    -- Allows you to stage and unstage changes, commit, push, pull, etc.
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",  -- required
      "sindrets/diffview.nvim", -- optional - Diff integration

      -- Only one of these is needed, not both.
      "nvim-telescope/telescope.nvim", -- optional
      "ibhagwan/fzf-lua",              -- optional
    },
    config = true,
    event = "VeryLazy",
  },
  {
    -- This gives some helpful hints of possible keybindings that can be used after typing a partial command
    -- ex. type <leader> and then it will show possible next keys and what they do (if they trigger an action they will show the action, if they are followed by more keys they will show an arrow and then possible bindings once typed)
    "folke/which-key.nvim",
    enabled = true,
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },
  {
    -- Can be used to show a list of lsp diagnostics.
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
  {
    -- Another way to search all files but this supports search and replace. Use <leader>ss to open the search and replace
    "nvim-pack/nvim-spectre",
    build = false,
    cmd = "Spectre",
    opts = { open_cmd = "noswapfile vnew" },
    -- stylua: ignore
    keys = {
      { "<leader>ss", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
    },
  },
  {
    -- Adds git status to teh gutter, also has other features such as line blame that can be configured or activated with a command such as <:Gitsigns toggle_current_line_blame>
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    opts = {},
    config = true
  },
  {
    -- Can be configured to have tabs like a gui editor. Currently not enabled
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>",            desc = "Toggle pin" },
      { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
      { "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>",          desc = "Delete other buffers" },
      { "<leader>br", "<Cmd>BufferLineCloseRight<CR>",           desc = "Delete buffers to the right" },
      { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>",            desc = "Delete buffers to the left" },
      { "<S-h>",      "<cmd>BufferLineCyclePrev<cr>",            desc = "Prev buffer" },
      { "<S-l>",      "<cmd>BufferLineCycleNext<cr>",            desc = "Next buffer" },
      { "[b",         "<cmd>BufferLineCyclePrev<cr>",            desc = "Prev buffer" },
      { "]b",         "<cmd>BufferLineCycleNext<cr>",            desc = "Next buffer" },
    },
    opts = {
      options = {
        -- stylua: ignore
        close_command = function(n) require("mini.bufremove").delete(n, false) end,
        -- stylua: ignore
        right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,
        diagnostics = "nvim_lsp",
        always_show_bufferline = false,
        diagnostics_indicator = function(_, _, diag)
          local icons = require("lazyvim.config").icons.diagnostics
          local ret = (diag.error and icons.Error .. diag.error .. " " or "")
              .. (diag.warning and icons.Warn .. diag.warning or "")
          return vim.trim(ret)
        end,
        offsets = {
          {
            filetype = "neo-tree",
            text = "Neo-tree",
            highlight = "Directory",
            text_align = "left",
          },
        },
      },
    },
    config = function(_, opts)
      require("bufferline").setup(opts)
      -- Fix bufferline when restoring a session
      vim.api.nvim_create_autocmd("BufAdd", {
        callback = function()
          vim.schedule(function()
            pcall(nvim_bufferline)
          end)
        end,
      })
    end,
    enabled = false
  },
  -- lazy.nvim
  {
    -- Some ui enhancements such as moving the command line to look like the vscode command prompt, borders on lsp diagnostics, etc.
    -- Also has some graphical improvments on notifications
    "folke/noice.nvim",
    enabled = true,
    -- event = "VeryLazy",
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
    config = function()
      require("noice").setup({
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true,         -- use a classic bottom cmdline for search
          command_palette = true,       -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false,           -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = true,        -- add a border to hover docs and signature help
        },
        routes = {
          {
            filter = {
              event = "msg_show",
              -- kind = "",
              find = "written",
            },
            opts = { skip = false },
          },
        }
      })
    end
  },
  {
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
          lsp_fallback = true,
        },
      })
    end,
  },
  {
    -- Makes folding code easier. Use  zc to close a function unbder the cursor, zo to open a function under the cursor
    -- type z to see more options (presented by the which key plugin)
    'kevinhwang91/nvim-ufo',
    dependencies = {
      'kevinhwang91/promise-async'
    },
    config = function()
      vim.o.foldcolumn = '1' -- '0' is not bad
      vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
      vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
      vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true
      }
      local language_servers = require("lspconfig").util.available_servers() -- or list servers manually like {'gopls', 'clangd'}
      for _, ls in ipairs(language_servers) do
        require('lspconfig')[ls].setup({
          capabilities = capabilities
          -- you can add other fields for setting up lsp server in this table
        })
      end
      require('ufo').setup()
    end
  },
  {
    -- Can be used to view a diff without leaving vim. open a diff with <leader>gdo and close with <leader>gdc
    'sindrets/diffview.nvim',
    event = "VeryLazy",
    config = function()
      require('diffview').setup()
      vim.keymap.set('n', '<leader>gdo', '<cmd>DiffviewOpen<cr>')
      vim.keymap.set('n', '<leader>gdc', '<cmd>DiffviewClose<cr>')
    end
  },
  {
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
  },
  {
    -- a plugin for working with markdown
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
  }
})
