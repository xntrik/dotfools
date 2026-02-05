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
  "jeetsukumaran/vim-buffergator",
  "ibhagwan/fzf-lua",
  "nvim-lua/plenary.nvim",
  "sindrets/diffview.nvim",
  "NeogitOrg/neogit",
  "nvim-tree/nvim-web-devicons",
  "nvim-treesitter/nvim-treesitter",
  "MeanderingProgrammer/render-markdown.nvim",

  -- completions
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-vsnip",
  "hrsh7th/vim-vsnip",
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

-- Neogit keymap
local neogit = require('neogit')
vim.keymap.set(
  "n",
  "<leader>g",
  function() neogit.open({kind = "split"}) end,
  { desc = "Open Neogit UI" }
)

-- The following is for airline
vim.g.airline_powerline_fonts = "1"
vim.g["airline#extensions#branch#enabled"] = "1"
vim.g["airline#extensions#whitespace#enabled"] = "1"
vim.g["airline_theme"] = "base16"

vim.lsp.config('*', {
  capabilities = {
    textDocument = {
      semanticTokens = {
        multilineTokenSupport = true,
      }
    }
  }
})

vim.lsp.enable('gopls')
vim.lsp.enable('svelte')
vim.lsp.enable('ts_ls')

--- from https://github.com/hrsh7th/nvim-cmp/wiki/Language-Server-Specific-Samples
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

local cmp = require('cmp')
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    end,
  },
  mapping = {
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif vim.fn["vsnip#available"](1) == 1 then
        feedkey("<Plug>(vsnip-expand-or-jump)", "")
      elseif has_words_before() then
        cmp.complete()
      else
        fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      elseif vim.fn["vsnip#jumpable"](-1) == 1 then
        feedkey("<Plug>(vsnip-jump-prev)", "")
      end
    end, { "i", "s" }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For vsnip users.
  }, {
    { name = 'buffer' },
  })
})
local capabilities = require('cmp_nvim_lsp').default_capabilities() --nvim-cmp

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
end

vim.api.nvim_create_autocmd("FileType", {
    callback = function()
      pcall(vim.treesitter.start)
    end
  })
