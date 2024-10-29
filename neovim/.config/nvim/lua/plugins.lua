local custom_header = {
  [[]],
  [[]],
  [[]],
  [[ ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗]],
  [[ ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║]],
  [[ ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║]],
  [[ ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║]],
  [[ ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║]],
  [[ ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝]],
  [[]],
  [[]],
  [[]],
}

local custom_footer = {
  [[]],
  [[]],
  'https://github.com/michaelpesa'
}

return {
  { "folke/neodev.nvim", opts = {} },
  'tpope/vim-sleuth',
  'tpope/vim-surround',
  'voldikss/vim-floaterm',
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'palenight',
        }
      }
    end
  },
  {
    'willothy/nvim-cokeline',
    dependencies = {
      'nvim-lua/plenary.nvim',        -- Required for v0.4.0+
      'nvim-tree/nvim-web-devicons', -- If you want devicons
      'stevearc/resession.nvim'       -- Optional, for persistent history
    },
    config = true
  },
  {
    'nvim-tree/nvim-tree.lua',
    version = "*",
    lazy = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require("nvim-tree").setup {}
    end
  },
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require('dashboard').setup {
        theme = 'hyper',
        config = {
          header = custom_header,
          footer = custom_footer,
          shortcut = {
            {
              desc = '[  Github]',
              group = 'DashboardShortCut'
            }
          }
        },
        hide = {
          statusline = true,    -- hide statusline default is true
          tabline = true,    -- hide the tabline
          winbar = true      -- hide winbar
        }
      }
    end,
    dependencies = { {'nvim-tree/nvim-web-devicons'} }
  },
  {
    "j-hui/fidget.nvim",
    tag = "legacy",
    event = "LspAttach",
    opts = {
      -- options
    },
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      'j-hui/fidget.nvim',

      -- Clojure/lisp LSP
      'Olical/conjure'
    },
  },
  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
  },
  -- Fuzzy Finder (files, lsp, etc)
  { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = { 'nvim-lua/plenary.nvim' } },
  {
    "NoahTheDuke/vim-just",
    ft = { "just" },
  },
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    opts = {},
  }
}
