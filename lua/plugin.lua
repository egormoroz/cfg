local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use 'morhetz/gruvbox'
    use 'ryanoasis/vim-devicons'

    use {'akinsho/toggleterm.nvim', tag = '*'}
    use 'preservim/nerdtree'

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

    use {
        'nvim-telescope/telescope.nvim',
        requires = {{ 'nvim-lua/plenary.nvim' }}
    }

    use {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
    }

    use 'tpope/vim-commentary'
    use 'lukas-reineke/indent-blankline.nvim'

    use {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'neovim/nvim-lspconfig'
    }
    use  {
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-nvim-lsp-signature-help',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
    }

    use 'L3MON4D3/LuaSnip'

    use 'Vimjas/vim-python-pep8-indent'

    use {
      "kndndrj/nvim-dbee",
      requires = {
        "MunifTanjim/nui.nvim",
      },
      run = function()
        -- Install tries to automatically detect the install method.
        -- if it fails, try calling it with one of these parameters:
        --    "curl", "wget", "bitsadmin", "go"
        require("dbee").install()
      end,
      config = function()
        require("dbee").setup(--[[optional config]])
      end
    }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
      require('packer').sync()
    end
end)

local shell = nil
if jit.os == 'Windows' then
    shell = 'powershell'
end


require('toggleterm').setup {
    shell = shell,
    size = function(term)
        if term.direction == 'vertical' then
            return vim.o.columns * 0.5
        elseif term.direction == 'horizontal' then
            return vim.o.lines * 0.5
        end
    end
}

require('nvim-treesitter.configs').setup {
    highlight = { 
        enable = true,
        additional_vim_regex_highlighting = { "python" },
    },
    ensure_installed = { 'c', 'lua', 'cpp', 'python', 'go', 'vim', 'vimdoc' },
}

require('telescope').load_extension('fzf')

require("mason").setup()
require("mason-lspconfig").setup {
    ensure_installed = { 'lua_ls', 'clangd', 'basedpyright', },
}

require("ibl").setup()

require('dbee').setup()
