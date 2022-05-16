vim.api.nvim_set_keymap("n", "<space>", "<nop>", {})
vim.g.mapleader = " "

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.clipboard = "unnamedplus"
vim.opt.incsearch = true
vim.opt.inccommand = "split"

vim.opt.number = true
vim.opt.relativenumber = true

vim.cmd([[au TextYankPost * silent! lua vim.highlight.on_yank({ higroup = "Search", timeout = 500 })]])

require("my.plugins")
require("my.colors")
