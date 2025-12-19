return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000, -- 确保主题在其他插件 (如 lualine, nvim-tree) 之前加载

    config = function()
        require("catppuccin").setup({
            flavour = "mocha", 
            
            -- 如果你希望 nvim 背景透明，让终端的毛玻璃效果透出来，请设置为 true
            transparent_background = false, 
            
            -- 为常用插件启用颜色集成，确保界面统一
            integrations = {
                cmp = true,
                gitsigns = true,
                nvimtree = true,
                telescope = true,
                lsp_trouble = true,
                which_key = true,
                flash = true,
            },
        })

        -- 设置主题
        vim.cmd.colorscheme "catppuccin"
    end,
}
