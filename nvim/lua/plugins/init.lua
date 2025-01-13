return {
  -- load on startup
  {
    'ellisonleao/gruvbox.nvim',
    priority = 1000 ,
    opts = require 'plugins.configs.gruvboxcfg',
    config = function (_, opts)
      require'gruvbox'.setup(opts)
      vim.cmd.colorscheme 'gruvbox'
      vim.api.nvim_set_hl(0, 'SnippetTabstop', { link = 'None' })
      vim.api.nvim_set_hl(0, 'SnippetPlaceholder', { link = 'None' })
    end,
  },

  { 'ryanoasis/vim-devicons' },

  { 'numToStr/Comment.nvim', opts = {} },

  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {},
  },

  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'ray-x/lsp_signature.nvim'
    },
    opts = require 'plugins.configs.lualine',
  },

  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function ()
      require'plugins.configs.harpoon'
    end
  },

  -- load lazily
  { 'nvim-lua/plenary.nvim', lazy = true },

  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {},
  },

  {
    'akinsho/toggleterm.nvim',
    version = '*',
    opts = require 'plugins.configs.toggleterm',
    cmd = { 'ToggleTerm', 'TermExec ' },
  },

  {
    'preservim/nerdtree',
    cmd = { 'NERDTree', 'NERDTreeToggle', 'NERDTreeFind' },
  },

  {
    'nvim-telescope/telescope-fzf-native.nvim',
    lazy = true,
    build = 'make',
  },

  {
    'nvim-telescope/telescope.nvim',
    dependencies =  {
      'nvim-treesitter/nvim-treesitter',
      'nvim-telescope/telescope-fzf-native.nvim',
    },
    cmd = 'Telescope',
    config = function ()
      require 'plugins.configs.telescope'
    end
  },

  {
    'nvim-telescope/telescope-file-browser.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    cmd = 'Telescope file_browser',
  },

  {
    'nvim-treesitter/nvim-treesitter',
    event = { 'BufReadPost', 'BufNewFile' },
    cmd = { 'TSInstall', 'TSBufEnable', 'TSBufDisable', 'TSModuleInfo' },
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    opts = require 'plugins.configs.treesitter',
  },

  {
    'Vimjas/vim-python-pep8-indent',
    ft = 'python',
  },

  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
      delay = function (ctx)
        return ctx.plugin and 0 or 800
      end
    },
    keys = {
      {
        '<leader>?',
        function()
          require('which-key').show({ global = false })
        end,
        desc = 'Buffer Local Keymaps (which-key)',
      },
    },
  },

  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',

      'rafamadriz/friendly-snippets',
    },
    -- made opts a function cuz cmp config calls cmp module
    -- and we lazyloaded cmp so we dont want that file to be read on startup!
    opts = function()
      return require 'plugins.configs.cmp'
    end,
  },

  {
    'williamboman/mason.nvim',
    build = ':MasonUpdate',
    cmd = { 'Mason', 'MasonInstall' },
    opts = {},
  },

  {
    'williamboman/mason-lspconfig.nvim',
    lazy = true,
    opts = {
      ensure_installed = { 'lua_ls', 'gopls' },
    },
  },

  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason-lspconfig.nvim',
      'williamboman/mason.nvim',
    },
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require 'plugins.configs.lspconfig'
    end,
  },

  {
    "kndndrj/nvim-dbee",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    build = function()
      require("dbee").install()
    end,
    config = function()
      require("dbee").setup()
    end,
  },

  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {
      bind = true,
      toggle_key = '<C-\\>',
      hint_prefix = {
        above = "↙ ",
        current = "← ",
        below = "↖ "
      },
      toggle_key_flip_floatwin_setting = true,
    },
    config = function(_, opts)
      require'lsp_signature'.setup(opts)
    end,
  },

  {
    'SmiteshP/nvim-navic',
    dependencies = {
      'neovim/nvim-lspconfig',
      'nvim-lualine/lualine.nvim',
    },
    event = 'LspAttach',
    opts = { highlight = true },
  },

  {
    'windwp/nvim-ts-autotag',
    event = {'BufReadPre', 'BufNewFile'},
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {},
  },
}
