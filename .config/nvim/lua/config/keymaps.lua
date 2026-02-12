-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("i", "jk", "<Esc>", { desc = "退出插入模式", silent = true })

vim.keymap.set("c", "jk", "<Esc>", { desc = "退出命令模式", silent = true })

-- 禁用原生 diffget (do)
vim.keymap.set("n", "do", "<Nop>", { noremap = true, silent = true })
-- diffput (dp)
vim.keymap.set("n", "dp", "<Nop>", { noremap = true, silent = true })
