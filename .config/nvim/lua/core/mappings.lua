-- ===================================================================
-- Key Mappings (core/mappings.lua)
-- ===================================================================

vim.g.mapleader = ' '         -- 将 <leader> 键设置为空格

local M = {} -- M 代表 "Module"，这是 Lua 模块的标准写法

function M.setup()
  -- 将 'jj' 映射为 'Escape' 键 (在插入模式中)
  vim.keymap.set({"i", "c"}, 'jj', '<Esc>', { noremap = true, silent = true, desc = "Exit Insert Mode" })

end

return M
