local map = function(mode, lhs, rhs, desc)
  if type(desc) == 'string' then
    desc = { desc = desc }
  end
  vim.keymap.set(mode, lhs, rhs, desc)
end
local mapn = function(lhs, rhs, desc)
  map('n', lhs, rhs, desc)
end

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

vim.o.number = true
vim.o.mouse = 'a'
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.showmode = false

vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

vim.o.breakindent = true
vim.o.undofile = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.updatetime = 250
vim.o.timeoutlen = 300

vim.o.cursorline = true
vim.o.scrolloff = 5

-- insert lines
mapn('<Enter>', function()
  if vim.bo.modifiable then
    return "o<Esc>"
  else
    return "<Enter>"
  end
end, { expr = true, desc = "Insert line below" })

mapn('<leader><Enter>', function()
  if vim.bo.modifiable then
    return "O<Esc>"
  else
    return "<Enter>"
  end
end, { expr = true, desc = "Insert line below" })

-- window mappings
mapn('<leader>wj', '<C-w>1w', 'nav to window 1')
mapn('<leader>wk', '<C-w>2w', 'nav to window 2')
mapn('<leader>wl', '<C-w>3w', 'nav to window 3')
mapn('<leader>w;', '<C-w>4w', 'nav to window 4')
mapn('<leader>wq', '<C-w>c', 'close cur window')
mapn('<leader>wo', '<C-w>o', 'close other windows')
mapn('<leader>ws', '<C-w>s', 'horizontal split')
mapn('<leader>wv', '<C-w>v', 'vertical split')

mapn('<Esc>', '<cmd>nohlsearch<CR>')

-- tabs
mapn('<leader>tj', '<cmd>tabnext<CR>', 'next tab')
mapn('<leader>tk', '<cmd>tabprevious<CR>', 'previous tab')
mapn('<leader>tq', '<cmd>tabclose<CR>', 'close tab')

-- vim.diagnostic.get_prev()

-- lsp mappings
mapn('gd', vim.lsp.buf.definition, 'go to def')
mapn('<leader>D', vim.lsp.buf.type_definition, 'go to type def')
mapn('g[', function ()
  local d = vim.diagnostic.get_prev()
  if d then
    vim.diagnostic.jump({ diagnostic = d })
  end
end, 'go to next diagnostic')
mapn('g]', function ()
  local d = vim.diagnostic.get_next()
  if d then
    vim.diagnostic.jump({ diagnostic = d })
  end
end, 'go to next diagnostic')
-- mapn('g[', vim.diagnostic.goto_prev, 'go to next diagnostic')
-- mapn('g]', vim.diagnostic.goto_next, 'go to prev diagnostic')
mapn('ga', vim.lsp.buf.code_action, 'code actions')
mapn('<leader>rn', vim.lsp.buf.rename, 'rename symbol')
mapn('K', vim.lsp.buf.hover, 'show hover info')
mapn('<leader>e', vim.diagnostic.open_float, 'expand diagnostic')
map({'n', 'i'}, '<C-K>', vim.lsp.buf.signature_help, 'show sig help')

-- toggleterm
map({'n', 'i'}, '<C-t>', ':ToggleTerm direction=float<CR>', 'open floating terminal')
map('t', '<C-t>', '<C-\\><C-n>:ToggleTerm<CR>','close terminal')
map('t', '<Esc>', '<C-\\><C-n>','enter normal mode')

map({'n', 't'}, '<c-l>', (function ()
  local lazygit = nil
  return function ()
    if not lazygit then
      local Terminal = require('toggleterm.terminal').Terminal
      lazygit = Terminal:new({
        cmd = 'lazygit',
        hidden = true,
        direction = 'float',
        dir = 'git_dir',
        on_exit = function ()
          lazygit = nil
        end
      })
    end
    lazygit:toggle()
  end
end)(), 'run lazy git in toggleterm')

mapn('<leader>w\\', function()
  local save_cursor = vim.fn.getpos(".")
  local old_query = vim.fn.getreg('/')
  local had_hl = vim.v.hlsearch == 1
  vim.cmd([[:%s/\s\+$//e]])
  if had_hl then
    vim.fn.setreg('/', old_query)
  else
    vim.cmd 'nohl'
  end
  vim.fn.setpos('.', save_cursor)
end, {
  desc = 'rem trailing whitespace',
  silent = true,
  noremap = true,
})

-- diffview
mapn('<leader>gdd', '<cmd>DiffviewOpen<CR>', 'diffview')
mapn('<leader>gdm', '<cmd>DiffviewOpen master..HEAD<CR>', 'diffview')

-- gofmt + goimports
mapn('<leader>fL',function ()
  vim.cmd("silent !go fmt %")
  vim.cmd("silent !goimports -w %")
end, { desc = 'gofmt & gomiports buffer' })

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end


local rtp = vim.opt.rtp
rtp:prepend(lazypath)

require('lazy').setup({
  {
    'NMAC427/guess-indent.nvim',
    config = true,
  },
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000 ,
    config = true,
    opts = {
      italic = {
        strings = false,
        emphasis = false,
        comments = false,
        operators = false,
        folds = false,
      },
    },
  },

  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',

        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      local actions = require('telescope.actions')
      require('telescope').setup {
        defaults = {
          mappings = {
            i = {
              ['<C-j>'] = actions.move_selection_next,
              ['<C-k>'] = actions.move_selection_previous,
              ['<C-p>'] = actions.delete_buffer,
              ['<C-d>'] = actions.preview_scrolling_down,
              ['<C-u>'] = actions.preview_scrolling_up,
              ['<C-[>'] = actions.preview_scrolling_left,
              ['<C-]>'] = actions.preview_scrolling_right,

              -- ['<C-l>'] = actions.results_scrolling_right,
              -- ['<C-h>'] = actions.results_scrolling_left,
            }
          }
        },
      }

      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')


      local bi = require 'telescope.builtin'
      local fb = require('telescope').extensions.file_browser
      local bufdir = function() return vim.fn.expand('%:p:h') end

      mapn('<leader>sk', bi.keymaps, '[S]earch [K]eymaps')
      mapn('<leader>sr', bi.resume, '[S]earch [R]esume')
      mapn('<leader>sd', bi.diagnostics, '[S]earch [D]iagnostics')

      mapn('fg', bi.live_grep, 'telescope live grep')
      mapn('<leader>fG', bi.live_grep, 'telescope live grep')
      mapn('<leader>fg', function()
        bi.live_grep { cwd = bufdir() }
      end, 'telescope bufdir live grep')

      mapn('<leader>fd', bi.find_files, 'telescope find files')
      mapn('<leader>ff', function()
        bi.find_files { cwd = bufdir() }
      end, 'telescope bufdir find files')

      mapn('<leader>fD', function()
        bi.find_files { cwd = vim.fn.stdpath('config') }
      end, 'telescope findfiles config')

      mapn('<leader>fB', function()
        bi.buffers { only_cwd = true }
      end, 'telescope find buffers in cwd')
      mapn('<leader>fb', bi.buffers, 'telescope find buffers')

      mapn('<leader>f?', bi.oldfiles, 'telescope find oldfiles')
      mapn('<leader>fs', bi.current_buffer_fuzzy_find, 'telescope search buffer')

      mapn('<leader>n', function()
        fb.file_browser { no_ignore = true }
      end, 'telescope file browser')
      mapn('<leader>m', function ()
        fb.file_browser { path = bufdir(), no_ignore = true }
      end, 'telescope bufdir file browser')
    end,
  },
  {
    'nvim-telescope/telescope-file-browser.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    cmd = 'Telescope file_browser',
  },
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'master',
    lazy = false,
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    opts = {
      ensure_installed = {
        'c', 'lua', 'cpp', 'python', 'go', 'vim', 'vimdoc', 'sql', 'proto', 'zig'
      },

      highlight = {
        enable = true,
        disable = { 'html' },
        -- additional_vim_regex_highlighting = { "python" },
      },
      indent = {
        enable = true,
        disable = { 'proto', 'go', 'zig' },
      },
    },
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      max_lines = 2,
      multiline_threshold = 1,
      trim_scope = 'inner',
    },
  },
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {},
  },
  {
    'sindrets/diffview.nvim',
    dependencies =  {
      'nvim-treesitter/nvim-treesitter',
    },
    cmd = { 'DiffviewOpen' },
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function ()
      local harpoon = require("harpoon")
      harpoon:setup()

      mapn("<leader>a", function() harpoon:list():add() end, 'harpoon add')
      mapn("<leader>A", function() harpoon:list():prepend() end, 'harpoon prepend')

      mapn("<leader>j", function() harpoon:list():select(1) end)
      mapn("<leader>k", function() harpoon:list():select(2) end)
      mapn("<leader>l", function() harpoon:list():select(3) end)
      mapn("<leader>;", function() harpoon:list():select(4) end)

      -- Toggle previous & next buffers stored within Harpoon list
      mapn("<C-J>", function() harpoon:list():prev() end)
      mapn("<C-K>", function() harpoon:list():next() end)

      local function toggle_telescope(harpoon_list)
        local conf = require("telescope.config").values
        local actions = require("telescope.actions")

        local make_finder = function ()
          local paths = {}
          for _, item in ipairs(harpoon_list.items) do
            table.insert(paths, item.value)
          end
          return require('telescope.finders').new_table({
            results = paths,
          })
        end

        require("telescope.pickers").new({}, {
          prompt_title = "Harpoon",
          finder = make_finder(),
          previewer = conf.file_previewer({}),
          sorter = conf.generic_sorter({}),
          attach_mappings = function (bufnr, _)
            ---@diagnostic disable-next-line: undefined-field
            actions.delete_buffer:replace(function ()
              local state = require("telescope.actions.state")
              local selected_entry = state.get_selected_entry()
              local current_picker = state.get_current_picker(bufnr)

              table.remove(harpoon_list.items, selected_entry.index)
              current_picker:refresh(make_finder())
            end)
            return true
          end
        }):find()
      end

      mapn("<leader>fe", function() toggle_telescope(harpoon:list()) end, "Open harpoon window")
    end
  },

  {
    'akinsho/toggleterm.nvim',
    version = '*',
    cmd = { 'ToggleTerm', 'TermExec ' },
    opts = {
      shell = (jit.os == 'Windows' and 'powershell') or nil,
      size = function(term)
        if term.direction == 'vertical' then
          return vim.o.columns * 0.5
        elseif term.direction == 'horizontal' then
          return vim.o.lines * 0.5
        end
      end
    },
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    opts = {
      theme = 'gruvbox',
      sections = {
        lualine_a = {'branch'},
        lualine_b = {'diff', 'diagnostics'},
        lualine_c = {'filename'},
        lualine_x = {},
        lualine_y = {},
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {},
        lualine_y = {},
      },
    },
  },
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true
  },

  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'mason-org/mason.nvim', opts = {} },
      'mason-org/mason-lspconfig.nvim',

      { 'j-hui/fidget.nvim', opts = {} },

      'saghen/blink.cmp',
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local lspmap = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          local bi = require('telescope.builtin')
          lspmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
          lspmap('ga', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
          lspmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
          lspmap('g.', bi.lsp_references, '[G]oto [R]eferences')
          lspmap('gi', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
          lspmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          lspmap('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')
          lspmap('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')
          lspmap('gt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')

          -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
          ---@param client vim.lsp.Client
          ---@param method vim.lsp.protocol.Method
          ---@param bufnr? integer some lsp support methods only in specific files
          ---@return boolean
          local function client_supports_method(client, method, bufnr)
            if vim.fn.has 'nvim-0.11' == 1 then
              return client:supports_method(method, bufnr)
            else
              return client.supports_method(method, { bufnr = bufnr })
            end
          end

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            lspmap('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        } or {},
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
      }

      local capabilities = require('blink.cmp').get_lsp_capabilities()

      local servers = {
        basedpyright = {},
        zls = {
          settings = {
            zls = {
              enable_snippets = false,
            },
          },
        },
        gopls = {
          settings = {
            gopls = {
              hints = {
                constantValues = true,
              },
              staticcheck = true,
              analyses = {
                ST1000 = false,
                ST1003 = false,
              },
            },
          },
        },
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              telemetry = {
                enable = false,
              },
            },
          },
        },
      }

      for server_name, server_config in pairs(servers) do
        local config = vim.tbl_deep_extend('force', {
          capabilities = capabilities,
        }, server_config)
        vim.lsp.config(server_name, config)
      end

      require('mason-lspconfig').setup {
        ensure_installed = vim.tbl_keys(servers),
        automatic_installation = true,
      }
    end,
  },

  {
    'saghen/blink.cmp',
    event = 'VimEnter',
    version = '1.*',
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        version = '2.*',
        build = (function()
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {},
        opts = {},
      },
      'folke/lazydev.nvim',
    },
    --- @module 'blink.cmp'
    --- @type blink.cmp.Config
    opts = {
      keymap = {
        preset = 'none',

        ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-e>'] = { 'hide' },
        ['<C-y>'] = { 'select_and_accept' },

        ['<C-k>'] = { 'select_prev', 'fallback' },
        ['<C-j>'] = { 'select_next', 'fallback' },

        ['<C-p>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-n>'] = { 'scroll_documentation_down', 'fallback' },

        ['<M-l>'] = { 'snippet_forward', 'fallback' },
        ['<M-h>'] = { 'snippet_backward', 'fallback' },

        ['<M-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
      },

      appearance = {
        nerd_font_variant = 'mono',
      },

      completion = {
        documentation = { auto_show = false, auto_show_delay_ms = 500 },
      },

      sources = {
        default = { 'lsp', 'path', 'snippets', 'lazydev', 'buffer' },
        providers = {
          lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
        },
      },

      snippets = { preset = 'luasnip' },

      signature = { enabled = true },
    },
  }
})

vim.cmd([[colorscheme gruvbox]])
