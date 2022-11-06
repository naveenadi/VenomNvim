local fn = vim.fn
local api = vim.api
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
    install_path })
  vim.cmd [[packadd packer.nvim]]
end

-- Run PackerCompile if there are changes in this file
local packerGrp = api.nvim_create_augroup("packer_user_config", { clear = true })
api.nvim_create_autocmd(
  { "BufWritePost" },
  { pattern = "init.lua", command = "source <afile> | PackerCompile", group = packerGrp }
)


-- safely import packer
local ok, packer = pcall(require, "packer")
if not ok then return end

-- packer.nvim configuration
local conf = {
  profile = {
    enable = true,
    threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
  },

  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
}

return packer.startup({ function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use 'kyazdani42/nvim-web-devicons'
  use 'nvim-lua/plenary.nvim'
  use {
    'TimUntersberger/neogit',
    cmd = { "Neogit" },
    config = function()
      require("neogit").setup({})
    end,
  }

  -- Color Scheme
  use {
    'Yazeed1s/minimal.nvim',
    -- config = [[vim.cmd('colorscheme minimal-base16')]],
    config = [[vim.cmd('colorscheme minimal')]],
  }

  -- Starter
  use {
    'goolord/alpha-nvim',
    config = function()
      require 'alpha'.setup(require 'alpha.themes.theta'.config)
      -- require("venom.plugins.config.alpha_nvim")
    end
  }
  
  -- Tabline
  use {
    'akinsho/bufferline.nvim',
    tag = "v3.*",
    requires = 'kyazdani42/nvim-web-devicons',
    event = "BufWinEnter",
    config = function()
      require("bufferline").setup {}
    end
  }
 
  -- LSP Setup
  use {
    "neovim/nvim-lspconfig",
    event = "BufRead",
    requires = {
      { -- Companion plugin for nvim-lspconfig that allows you to seamlessly install LSP servers locally (inside :echo stdpath("data")).
        'williamboman/mason.nvim',
        requires = {
          'williamboman/mason-lspconfig.nvim'
        }, -- Extension to mason.nvim that makes it easier to use lspconfig with mason.nvim
      },
    },
    config = function()
      require("venom.plugins.config.nvim_lspconfig")
    end,
  }
   
  -- Completion
  use {
    "hrsh7th/nvim-cmp",
    event = 'InsertEnter',
    requires = {
      { -- Snippet Engine for Neovim written in Lua.
        'L3MON4D3/LuaSnip',
        module = "luasnip",
      },
      { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' }, -- nvim-cmp source for neovim builtin LSP client
      { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' }, -- nvim-cmp source for nvim lua
      { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' }, -- nvim-cmp source for buffer words.
      { 'hrsh7th/cmp-path', after = 'nvim-cmp' }, -- nvim-cmp source for filesystem paths.
      { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' }, -- luasnip completion source for nvim-cmp
      { "hrsh7th/cmp-nvim-lsp-signature-help", after = 'nvim-cmp' },
    },
    config = function()
      require("venom.plugins.config.nvim_cmp")
      -- require('luasnip')
    end
  }
  
  -- Statusline
  use {
    'feline-nvim/feline.nvim',
    config = function()
      -- require('feline').winbar.setup()
      require('feline').setup()
    end
  }

  -- Jump2d
  use {
    'phaazon/hop.nvim',
    branch = 'v2', -- optional but strongly recommended
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      require 'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
    end
  }

  -- Cursorword
  use {
    'RRethy/vim-illuminate',
    config = function()
      require('illuminate').configure()
    end
  }

  -- Indentscope
  use {
    "lukas-reineke/indent-blankline.nvim",
     config = function()
      require("venom.plugins.config.indent_blankline")
    end 
  }

  -- Surround
  use {
    "kylechui/nvim-surround",
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = 'InsertEnter',
    keys = { 'c' },
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  }

  -- Comment
  use {
    'numToStr/Comment.nvim',
    keys = { "cc", "gc", "gb" },
    config = function()
      require('Comment').setup()
    end
  }

  -- Pairs
  use {
	  "windwp/nvim-autopairs",
    after = "nvim-cmp",
    config = function() require("venom.plugins.config.nvim_autopairs") end
  }


  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    vim.notify("Restart Neovim required after installation!")
    require('packer').sync()
  end
end,

  config = conf
})
