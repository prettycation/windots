return {
  -- 1. 增强 LazyVim 自带的 nvim-cmp
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")

      opts.sources = cmp.config.sources(vim.list_extend(opts.sources or {}, {
        { name = "codeium", priority = 100, group_index = 1 },
      }))

      -- 快捷键
      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
      })
    end,
  },

  -- 2. 配置 Windsurf (Codeium)
  {
    "Exafunction/windsurf.nvim",
    cmd = "Codeium",
    event = "InsertEnter",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      -- 确保 cmp 模块在路径中
      local has_cmp, _ = pcall(require, "cmp")
      if not has_cmp then
        return
      end

      require("codeium").setup({
        enable_cmp_source = true,
        virtual_text = {
          enabled = true,
          key_bindings = {
            accept = "<A-a>",
          },
        },
      })
    end,
  },
}
