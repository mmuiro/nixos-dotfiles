vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.mouse = "a"
vim.opt.hidden = true
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir= os.getenv("HOME") .. "/.vim/undo-dir"
vim.opt.undofile = true
-- vim.opt.colorcolumn = "80"
vim.opt.scrolloff = 8

vim.g.mapleader = " "

-- lazy.nvim setup
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")
require('remap')
