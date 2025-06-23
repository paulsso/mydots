-- ~/.config/nvim/init.lua

-- Bootstrap lazy.nvim if not installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")

-- General settings
vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = false
vim.o.mouse = "a"
vim.o.termguicolors = true

-- Set Python host program
vim.g.python3_host_prog = os.getenv("HOME") .. "/.venvs/default/bin/python"

vim.keymap.set("n", "<C-S-F>", [[:%s///gc<Left><Left><Left>]], { noremap = true, silent = false })

vim.opt.clipboard = "unnamedplus"

-- Load Telescope
local telescope = require("telescope")
local builtin = require("telescope.builtin")
local live_grep_args = require("telescope").extensions.live_grep_args

-- CTRL+SHIFT+F → Live Grep with args (Search + Replace)
vim.keymap.set("n", "<C-S-F>", function()
  live_grep_args.live_grep_args()
end, { noremap = true, silent = true })
