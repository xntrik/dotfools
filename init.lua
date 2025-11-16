require("paq")({
  "savq/paq-nvim",
  "neovim/nvim-lspconfig",
  "stevearc/conform.nvim",
  "junegunn/fzf",
  "junegunn/fzf.vim",
  "preservim/nerdtree",
  "tpope/vim-surround",
  "tpope/vim-fugitive",
  "kien/ctrlp.vim",
  "dhruvasagar/vim-zoom",
  "ellisonleao/gruvbox.nvim",
  "easymotion/vim-easymotion",
  "vim-airline/vim-airline",
  "vim-airline/vim-airline-themes",
  "fatih/vim-go",
  "jeetsukumaran/vim-buffergator"
})

function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.smartindent = true
vim.opt.colorcolumn = "80"
vim.opt.incsearch = true
vim.opt.hls = true
vim.opt.cursorline = true
vim.opt.ruler = true
vim.opt.hidden = true
vim.opt.expandtab = true
vim.opt.softtabstop = 2
vim.opt.splitbelow = true
vim.opt.splitright = true

-- use gruvbox theme
vim.cmd([[colorscheme gruvbox]])

vim.g.mapleader = " " -- leader key is space
map('i', 'jk', '<ESC>') -- a quick jk to hit ESC
map('n', '<leader>f', ':Files!<CR>') -- fuzzy file search
map('n', '<leader>g', 'RG!<CR>') -- fuzzy file grep
map('n', '<C-n>', ':NERDTreeToggle<CR>') -- show nerdtree
vim.g.NERDTreeShowHidden = "1" -- show hidden files
map('n', '<C-j>', '<C-w>j') -- ctrl movement around splits
map('n', '<C-k>', '<C-w>k') -- ctrl movement around splits
map('n', '<C-h>', '<C-w>h') -- ctrl movement around splits
map('n', '<C-l>', '<C-w>l') -- ctrl movement around splits
map('n', '<leader>p', ':CtrlPBuffer<CR>') -- open CtrolP buffer
map('n', '<leader>r', ':set inrelativenumber<CR>') -- toggle relative number
map('n', '<leader>h', ':noh<CR>') -- toggle highlight

-- close NERDTree then use vim-zoom to zoom current split
map('n', '<leader>m', ':NERDTreeClose<CR> <bar> :call zoom#toggle()<CR>')

-- Buffergator cycling
map('n', '<leader>v', ':BuffergatorMruCyclePrev<CR>')
map('n', '<leader>n', ':BuffergatorMruCycleNext<CR>')

-- The following is for airline
vim.g.airline_powerline_fonts = "1"
vim.g["airline#extensions#branch#enabled"] = "1"
vim.g["airline#extensions#whitespace#enabled"] = "1"
vim.g["airline_theme"] = "base16"

