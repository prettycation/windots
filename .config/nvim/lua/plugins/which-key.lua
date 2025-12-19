-- 文件路径: ~/AppData/Local/nvim/lua/plugins/which-key.lua

return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
        -- 按键超时
        vim.o.timeoutlen = 300

        require("which-key").setup({
            -- 使用 col 和 row 参数来精确定位
            win = {
                border = "rounded", -- 使用圆角边框
                col = -1,  
                row = -1,  
                width = { min = 30, max = 60 },  
                height = { min = 4, max = 0.75 },  
            },
            layout = {
                align = "left",
            },
        })
    end,
}