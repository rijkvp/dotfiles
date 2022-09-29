vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'lewis6991/impatient.nvim' -- Faster startup

    -- Telescope navigation
    use 'nvim-telescope/telescope.nvim'

    -- LSP
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'
    use 'neovim/nvim-lspconfig'

    use 'simrat39/rust-tools.nvim'

    -- Code completion
    use 'hrsh7th/nvim-cmp'  -- Completion framework:
    use 'hrsh7th/cmp-nvim-lsp' -- LSP completions
    use 'hrsh7th/cmp-nvim-lua'
    use 'hrsh7th/cmp-nvim-lsp-signature-help'
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/vim-vsnip'

    use {
      "folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require("trouble").setup {
        }
      end
    }
    use 'folke/lsp-colors.nvim'

    -- Code formatting
    use 'sbdchd/neoformat'
    -- Whitespace
    use 'ntpeters/vim-better-whitespace'
    -- MD
    use 'ixru/nvim-markdown'
    -- LaTeX
    use 'lervag/vimtex'

    -- Treesitter
    use("nvim-treesitter/nvim-treesitter", {
        run = ":TSUpdate"
    })
    use 'nvim-treesitter/nvim-treesitter-context'
    use 'ap/vim-css-color'

    -- Color Schemes
    use 'navarasu/onedark.nvim'
end)
