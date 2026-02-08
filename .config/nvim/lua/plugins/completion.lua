return {
  -- Windsurf / Codeium
  {
    "Exafunction/windsurf.nvim",
    name = "windsurf.nvim",
    event = "InsertEnter",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "saghen/blink.cmp",
    },
    config = function()
      require("codeium").setup({
        enable_cmp_source = false,

        virtual_text = {
          enabled = true,
          key_bindings = {
            accept = "<A-a>",
            next = "<A-n>",
            prev = "<A-p>",
          },
        },
      })

      -- setup 后执行，覆盖默认的彩色高亮
      vim.api.nvim_set_hl(0, "CodeiumSuggestion", { link = "Comment", force = true })
    end,
  },

  -- Blink.cmp
  {
    "saghen/blink.cmp",
    dependencies = {
      "windsurf.nvim",
    },
    opts = {
      completion = {
        -- LSP 不显示行内灰字
        ghost_text = { enabled = false },
      },

      sources = {
        default = { "lsp", "path", "snippets", "buffer", "codeium" },

        providers = {
          codeium = {
            name = "Codeium",
            module = "codeium.blink",
            async = true,
          },
        },
      },
    },
  },
}
