local opt = vim.opt

opt.number = true
opt.relativenumber = true

opt.mouse = 'a'

opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true

opt.wrap = false

opt.hlsearch = false
opt.incsearch = true

opt.ignorecase = true
opt.smartcase = true

opt.cursorline = true

opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

opt.scrolloff = 5

opt.backspace = "indent,eol,start"

opt.clipboard:append("unnamedplus")

opt.splitright = true
opt.splitbelow = true

opt.iskeyword:append("-")

opt.laststatus = 3

opt.shortmess:append("I")

opt.showmode = false
opt.showcmd = false
opt.cmdheight = 1

opt.hidden = true
