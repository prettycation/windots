-- 文件路径: ~/AppData/Local/nvim/lua/plugins/cmp.lua

return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp", -- LSP 补全源
        "hrsh7th/cmp-buffer",   -- 缓冲区文本补全源
        "hrsh7th/cmp-path",     -- 文件路径补全源
        "L3MON4D3/LuaSnip",     -- Snippet 引擎
        "saadparwaiz1/cmp_luasnip", -- Snippet 补全源
    },

    config = function()
        local cmp = require("cmp")

        cmp.setup({
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },
            
            mapping = {
                -- 上下选择候选项
                ["<C-k>"] = cmp.mapping.select_prev_item(),
                ["<C-j>"] = cmp.mapping.select_next_item(),

                -- 让 Tab 和 Enter 都用于确认补全
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
                ["<Tab>"] = cmp.mapping.confirm({ select = true }),
            },
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" },
            }, {
                { name = "buffer" },
                { name = "path" },
            }),
        })
    end,
}