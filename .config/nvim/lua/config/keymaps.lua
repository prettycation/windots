-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("i", "jk", "<Esc>", { desc = "退出插入模式", silent = true })

vim.keymap.set("c", "jk", "<Esc>", { desc = "退出命令模式", silent = true })

vim.keymap.set("n", "<leader>ch", "<cmd>nohlsearch<CR>", { desc = "取消搜索高亮" })
