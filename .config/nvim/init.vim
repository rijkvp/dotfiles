set nocompatible " Required by polygot

" Plugins (using vim-plug: https://github.com/junegunn/vim-plug)
call plug#begin()

Plug 'olimorris/onedarkpro.nvim' " Theme
Plug 'vim-airline/vim-airline' " Status bar
Plug 'vim-airline/vim-airline-themes'
Plug 'sheerun/vim-polyglot' " Language packs
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Code completion

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
set noshowmode " Unneeded because of status bar

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

nnoremap <leader>ff <cmd>Telescope find_files<cr>

" Nerd Tree keybinds
nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
nnoremap <C-u> :belowright split \| resize 20 \| term<CR>

