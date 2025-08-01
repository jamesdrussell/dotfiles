local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ' '

vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.wrap = false
vim.opt.mouse = 'a'
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.autoindent = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.background = 'dark'
vim.opt.signcolumn = 'yes'
vim.opt.scrolloff = 5
vim.opt.backspace = 'indent,eol,start'
vim.opt.clipboard:append('unnamedplus')
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.iskeyword:append('-')
vim.opt.laststatus = 3
vim.opt.shortmess:append('I')
vim.opt.showmode = false
vim.opt.showcmd = false
vim.opt.cmdheight = 1
vim.opt.hidden = true
vim.opt.fillchars = {eob = ' '}
vim.diagnostic.config({
  virtual_text = false
})

vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldcolumn = '0'
vim.opt.foldtext = ''
vim.opt.foldnestmax = 1
vim.opt.foldlevelstart = 1

vim.keymap.set("n", "x", '"_x')
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>")
vim.keymap.set("n", "<leader>q", "<cmd>q<cr>")
vim.keymap.set("n", "<leader>Q", "<cmd>q!<cr>")
vim.keymap.set("n", "<leader>v", "<C-w>v")
vim.keymap.set("n", "<leader>h", "<C-w>s")
vim.keymap.set("n", "<leader>=", "<C-w>=")
vim.keymap.set("n", "<leader>m", "<cmd>MaximizerToggle<cr>")
vim.keymap.set("n", "<leader>x", "<cmd>close<cr>")
vim.keymap.set("n", "<leader>u", "<cmd>Lazy update<cr>")
vim.keymap.set("i", "<C-h>", "<Left>")
vim.keymap.set("i", "<C-j>", "<Down>")
vim.keymap.set("i", "<C-k>", "<Up>")
vim.keymap.set("i", "<C-l>", "<Right>")
vim.keymap.set("n", "U", "<C-r>")

require('lazy').setup({
  spec = {
    {
      'catppuccin/nvim',
      name = 'catppuccin',
      lazy = false,
      priority = 1000,
      config = function()
        vim.cmd([[colorscheme catppuccin-macchiato]])
      end
    },
    {
      'nvim-treesitter/nvim-treesitter',
      lazy = false,
      build = ':TSUpdate',
      dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects'
      },
      config = function()
        require('nvim-treesitter.configs').setup({
          ensure_installed = {
            'bash', 'c', 'cmake', 'cpp', 'json', 'lua', 'markdown', 'markdown_inline', 'python', 'vim', 'vimdoc'
          },
          sync_install = false,
          auto_install = true,
          highlight = { enable = true },
          indent = { enable = true },
          incremental_selection = {
            enable = true,
            keymaps = {
              init_selection = 'gnn',
              node_incremental = 'grn',
              scope_incremental = 'grc',
              node_decremental = 'grm'
            }
          },
          textobjects = {
            select = {
              enable = true,
              lookahead = true,
              keymaps = {
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.inner'
              }
            }
          }
        })
      end
    },
    {
      'ibhagwan/fzf-lua',
      keys = {
        {
          '<leader>f',
          function()
            require('fzf-lua').files()
          end
        },
        {
          '<leader>b',
          function()
            require('fzf-lua').buffers()
          end
        }
      },
      opts = {
        winopts = {
          height = 0.25,
          preview = { hidden = 'hidden' }
        },
        files = {
          winopts = {
            title_flags = false
          },
          file_icons = false
        },
        buffers = {
          no_header = true
        }
      }
    },
    {
      'windwp/nvim-autopairs',
      config = function()
        require('nvim-autopairs').setup({
          check_ts = true,
          ts_config = {
            lua = { 'string' }
          }
        })
      end
    },
    {
      'lewis6991/gitsigns.nvim',
      config = function()
        require('gitsigns').setup()
      end
    },
    {
      'nvim-lualine/lualine.nvim',
      dependencies = {
        'nvim-tree/nvim-web-devicons'
      },
      config = function()
        require('lualine').setup()
      end
    },
    {
      'numToStr/Comment.nvim',
      config = function()
        require('Comment').setup()
      end
    },
    {
      'kylechui/nvim-surround',
      config = function()
        require('nvim-surround').setup()
      end
    }
  },
  install = { colorscheme = { 'catppuccin-macchiato' } },
  checker = { enabled = true }
})
