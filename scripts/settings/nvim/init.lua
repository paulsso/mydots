-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins
require("lazy").setup("plugins")

-- Set <leader> key to Space
vim.g.mapleader = " "

-- General settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false
vim.opt.mouse = "a"
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus" -- enable system clipboard

-- Python host program
vim.g.python3_host_prog = vim.fn.expand("~/.venvs/default/bin/python")

-- === Keymaps ===

-- Save with Ctrl+S
vim.keymap.set("n", "<C-s>", ":w<CR>", { noremap = true, silent = true })

-- Jump ahead N lines with <leader>N
vim.keymap.set("n", "<leader>//", "5j", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>..", "10j", { noremap = true, silent = true })

-- Jump back N lines with <S-leader>N (Shift+leader)
vim.keymap.set("n", "<leader>??", "5k", { noremap = true, silent = true })

-- Move lines with Alt+J / Alt+K
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { noremap = true, silent = true })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { noremap = true, silent = true })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

-- Tab to indent in Visual mode
vim.keymap.set("v", "<Tab>", ">gv", { noremap = true, silent = true })
vim.keymap.set("v", "<S-Tab>", "<gv", { noremap = true, silent = true })

-- Telescope keymaps
local ok, builtin = pcall(require, "telescope.builtin")
if ok then
  vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
  vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
end

-- NvimTree keymap
vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

-- Spectre keymap
local ok_spectre, spectre = pcall(require, "spectre")
if ok_spectre then
  vim.keymap.set("n", "<C-S-F>", function()
    spectre.toggle()
  end, { desc = "Toggle Spectre (Search & Replace)", noremap = true, silent = true })
end
