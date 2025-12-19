-- 文件路径: ~/AppData/Local/nvim/lua/plugins/gitsigns.lua

return {
    "lewis6991/gitsigns.nvim",
    config = function()
        require("gitsigns").setup()
    end,
}