vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    -- Telescope navigation
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'

    -- LSP
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-nvim-lsp'

    -- ???
    -- use ("neoclide/coc.nvim", {
    --    "branch" = "release"
    -- })

    use 'folke/lsp-colors.nvim'
    use 'folke/trouble.nvim'
    -- Code formatting
    use 'sbdchd/neoformat'
    -- Whitespace
    use 'ntpeters/vim-better-whitespace'
    -- MD
    use 'ixru/nvim-markdown'

    -- Treesitter
    use("nvim-treesitter/nvim-treesitter", {
        run = ":TSUpdate"
    })
    use 'nvim-treesitter/nvim-treesitter-context'
    use 'ap/vim-css-color'

    -- Color Schemes
    use 'folke/tokyonight.nvim'
    use { "EdenEast/nightfox.nvim", tag = "v1.0.0" }
end)
