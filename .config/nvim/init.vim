set nocompatible " Required by polygot

" Plugins (using vim-plug: https://github.com/junegunn/vim-plug)
call plug#begin()

Plug 'olimorris/onedarkpro.nvim' " Theme
Plug 'vim-airline/vim-airline' " Status bar
Plug 'vim-airline/vim-airline-themes'
Plug 'sheerun/vim-polyglot' " Language packs

" Plug 'neoclide/coc.nvim', {'branch': 'release'} " Code completion

" LSP stuff
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'

Plug 'simrat39/rust-tools.nvim'

Plug 'hrsh7th/vim-vsnip'

" File explorer (https://github.com/kyazdani42/nvim-tree.lua) Plug 'kyazdani42/nvim-web-devicons' Plug 'kyazdani42/nvim-tree.lua'
Plug 'preservim/nerdtree'

" IDK
Plug 'folke/lsp-colors.nvim'
Plug 'folke/trouble.nvim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " Syntax highlighting
Plug 'ixru/nvim-markdown'
Plug 'ntpeters/vim-better-whitespace'

" Telescope (file opener)
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'github/copilot.vim' " GitHub Copilot
" TODO: Learn https://github.com/tpope/vim-surround

call plug#end()

" Theme
colorscheme onedarkpro
let g:airline_theme='onedark'

" General
set number
set wrap " Line wraping
set noshowmode " Redundant because of custom status bar

set autoindent smartindent
set clipboard+=unnamedplus

" Tabs
set shiftwidth=4
set softtabstop=4
set expandtab

" Copy/paste
set autoindent smartindent
set clipboard+=unnamedplus

" Keybinds
let mapleader = ","
" Escape ternimal
tnoremap <Esc> <C-\><C-n>

nnoremap <leader>f <cmd>Telescope find_files<cr>

" Nerd Tree keybinds
nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" Terminal
nnoremap <leader>a :belowright split \| resize 20 \| term<CR>i
" Auto insert mode when terminal
autocmd BufWinEnter,WinEnter term://* startinsert

" Set completeopt to have a better completion experience
" :help completeopt
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect

" Avoid showing extra messages when using completion
set shortmess+=c

" Configure LSP through rust-tools.nvim plugin.
" rust-tools will configure and enable certain LSP features for us.
" See https://github.com/simrat39/rust-tools.nvim#configuration
lua <<EOF
local nvim_lsp = require'lspconfig'

local opts = {
    tools = { -- rust-tools options
        autoSetHints = true,
        hover_with_actions = true,
        inlay_hints = {
            show_parameter_hints = false,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
        },
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
    server = {
        -- on_attach is a callback called when the language server attachs to the buffer
        -- on_attach = on_attach,
        settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
                -- enable clippy on save
                checkOnSave = {
                    command = "clippy"
                },
            }
        }
    },
}

require('rust-tools').setup(opts)
EOF

" Setup Completion
" See https://github.com/hrsh7th/nvim-cmp#basic-configuration
lua <<EOF
local cmp = require'cmp'
cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },

  -- Installed sources
  sources = {
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'path' },
    { name = 'buffer' },
  },
})
EOF

