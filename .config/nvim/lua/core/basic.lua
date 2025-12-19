vim.opt.number = true         -- 显示行号
vim.opt.relativenumber = true -- 显示相对行号
vim.opt.tabstop = 4           -- Tab 宽度为 4 个空格

vim.opt.cursorline = true
vim.opt.colorcolumn = "80"

vim.opt.shiftwidth = 0        -- 自动缩进的宽度
vim.opt.expandtab = true      -- 使用空格替代 Tab
-- vim.opt.smartindent = true    -- 智能缩进

vim.opt.autoread = true

vim.opt.termguicolors = true  -- 启用真彩色，为将来的主题做准备

-- --- 搜索设置 ---
vim.opt.hlsearch = true       -- 高亮所有搜索匹配项
vim.opt.incsearch = true      -- 在你输入时就实时开始搜索和高亮
vim.opt.ignorecase = true     -- 搜索时忽略大小写...
vim.opt.smartcase = true      -- ...但是，如果你输入的搜索词中包含大写字母，则自动切换为大小写敏感搜索

-- --- 剪贴板设置 ---
-- 将默认的 "unnamed" 和 "unnamedplus" 寄存器都设置为使用系统剪贴板。
-- "unnamedplus" 是与外部应用交互的标准。
vim.opt.clipboard = 'unnamed,unnamedplus'
