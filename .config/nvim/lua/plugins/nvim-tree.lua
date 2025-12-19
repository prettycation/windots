-- 文件路径: ~/AppData/Local/nvim/lua/plugins/nvim-tree.lua

return {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("nvim-tree").setup({

            view = {
                width = 30,
            },
            renderer = {
                group_empty = true,
            },
        })

        -- 打开/关闭文件树
        vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>", {
            noremap = true,
            silent = true,
        })
    end,
}