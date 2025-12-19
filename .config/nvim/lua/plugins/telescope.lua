-- 文件路径: ~/AppData/Local/nvim/lua/plugins/telescope.lua

return {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local builtin = require("telescope.builtin")
        
        -- 设置快捷键来搜索文件和在文件中搜索文本
        vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
        vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
    end,
}