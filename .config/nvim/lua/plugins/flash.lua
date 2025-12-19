-- 文件路径: ~/AppData/Local/nvim/lua/plugins/flash.lua

return {
    "folke/flash.nvim",
    event = "VeryLazy",
    
    -- [核心修改] 通过 'keys' 选项覆盖默认快捷键
    keys = {
      -- 将 'f' 键映射为全局跳转 (原本 's' 的功能)
      { "f", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash Global Jump" },
      
      -- 为 'F' 键映射一个更强大的 Treesitter 跳转，它能识别代码结构
      { "F", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      
    },
}