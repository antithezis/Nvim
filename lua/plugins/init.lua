local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself

  use {
    'windwp/nvim-autopairs',
    config = require "plugins.configs.autopairs"
  }
  use {
    "nvim-telescope/telescope.nvim",
    requires = {
      {'nvim-lua/popup.nvim'},
      {'nvim-lua/plenary.nvim'},
      {'nvim-telescope/telescope-fzf-native.nvim', run="make"},
      {'nvim-telescope/telescope-symbols.nvim'},
      { "nvim-telescope/telescope-file-browser.nvim" },
    },
    config = require "plugins.configs.telescope",
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    requires = {
      "windwp/nvim-ts-autotag",
      "p00f/nvim-ts-rainbow",
    },
    run = ':TSUpdate',
    config = require "plugins.configs.treesitter"
  }

  use {
    "williamboman/nvim-lsp-installer",
    requires = {
      "neovim/nvim-lspconfig",
      "jose-elias-alvarez/typescript.nvim",
    },
    config = require "plugins.configs.lsp"
  }

  use { 'ibhagwan/fzf-lua',
    -- optional for icon support
    requires = { 'kyazdani42/nvim-web-devicons' }
  }

  -- UI

  use { "rmehri01/onenord.nvim" }
  use { "goolord/alpha-nvim", config = require "plugins.configs.alpha" }
  use { "kyazdani42/nvim-web-devicons", config = require "plugins.configs.icons" }
  use {
    "nvim-lualine/lualine.nvim",
    config = require "plugins.configs.lualine",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
  }

  use {
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp-document-symbol",
      "hrsh7th/cmp-vsnip",
      "hrsh7th/vim-vsnip",
      "hrsh7th/cmp-nvim-lsp-signature-help",
    },
    config = require "plugins.configs.cmp",
  }

  use {
    "L3MON4D3/LuaSnip",
    config = require "plugins.configs.luasnip"
  }

  use {"saadparwaiz1/cmp_luasnip"}

  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    },
    config = require "plugins.configs.nvim-tree",
    tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }

  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
    -- tag = 'release' -- To use the latest release
  }

  use 'tpope/vim-fugitive'
  use 'turbio/bracey.vim'
  use 'sheerun/vim-polyglot'
  use 'alvan/vim-closetag'
  use 'tpope/vim-commentary'
  use 'mattn/emmet-vim'
  use 'christoomey/vim-tmux-navigator'
  use 'turbio/bracey.vim'


  -- React
  use {'neoclide/coc.nvim', branch = 'release'}
  use 'ianks/vim-tsx'
  use 'mxw/vim-jsx'
  use 'maxmellon/vim-jsx-pretty'
  use 'pangloss/vim-javascript'
  use 'alampros/vim-styled-jsx'
  use {'styled-components/vim-styled-components',  branch = 'main' }
  use 'fleischie/vim-styled-components'
  -- use 'leafgarkabd/typescript-vim'

  use 'github/copilot.vim'

  use {
    'prettier/vim-prettier',
    run = 'yarn install',
    ft = {'javascript', 'typescript', 'css', 'html', 'scss', 'graphql', 'markdown', 'react'}
  }

  use {
    "NTBBloodbath/rest.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = require "plugins.configs.rest"
  }

  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
