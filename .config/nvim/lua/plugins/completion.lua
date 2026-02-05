return {
  -- 1. 配置 Windsurf (Codeium)
  {
    "Exafunction/windsurf.nvim",
    cmd = "Codeium", -- 延迟加载
    event = "InsertEnter",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require("codeium").setup({
        -- 我们将通过 cmp 来显示补全，所以这里可以关闭虚拟文字，或者两者都开
        enable_cmp_source = true,
        virtual_text = {
          enabled = true,
          key_bindings = {
            accept = "<A-a>", -- Alt + a 接受虚拟文字建议
          },
        },
      })
    end,
  },

  -- 2. 增强 LazyVim 自带的 nvim-cmp
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "Exafunction/windsurf.nvim",
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")
      -- 将 codeium (windsurf) 插入到补全源列表的最前面
      table.insert(opts.sources, 1, {
        name = "codeium",
        group_index = 1,
        priority = 100,
      })

      -- 自定义快捷键：Tab 键确认补全
      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
      })
    end,
  },
}
