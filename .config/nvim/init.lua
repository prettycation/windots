
-- -------------------------------------------------------------------
-- [ 快捷键绑定 ]
-- 我们可以在这里为你已经安装的 lazygit 添加一个快捷键。
-- -------------------------------------------------------------------

-- <leader>g 打开 Lazygit (g for git)
-- 关键修正：我们不再使用阻塞的 system() 调用。
-- 而是使用 Neovim 内置的 :terminal 命令，在一个新的终端缓冲区中打开 lazygit。
-- 这才是与 TUI 程序交互的正确方式。
-- vim.keymap.set('n', '<leader>g', ':terminal lazygit<CR>', { noremap = true, silent = true, desc = "Open Lazygit" })

-- -------------------------------------------------------------------
-- [ 加载自定义模块 ]
-- -------------------------------------------------------------------
require('core.mappings').setup()
require('core.basic')
require('core.lazy_config')
