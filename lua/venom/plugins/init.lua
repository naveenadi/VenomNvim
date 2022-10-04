local fn = vim.fn
local api = vim.api
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
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

return packer.startup({function(use)
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
    config = [[vim.cmd('colorscheme minimal-base16')]],
    -- config = [[vim.cmd('colorscheme minimal')]],
  }
  
  -- Starter
  use {
    'goolord/alpha-nvim',
    config = function ()
      require'alpha'.setup(require'alpha.themes.theta'.config)
      -- require("venom.plugins.config.alpha_nvim")
    end
  }
  
  -- Statusline
  use {
    'feline-nvim/feline.nvim',
    config = function ()
      -- require('feline').winbar.setup()
      require('feline').setup()
    end
  }

  -- Tabline
  use {
    'akinsho/bufferline.nvim', 
    tag = "v2.*", 
    requires = 'kyazdani42/nvim-web-devicons',
    config = function () 
      require("bufferline").setup{}
    end
  }

  -- Comment
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }

  -- Surround
  use {
    "kylechui/nvim-surround",
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
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
