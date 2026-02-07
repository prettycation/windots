return {
  -- Snacks 快捷键禁用
  {
    "folke/snacks.nvim",
    lazy = false,
    keys = {
      { "<leader>gd", false },
    },
  },

  -- CodeDiff 配置
  {
    "esmuellert/codediff.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
    },
    cmd = "CodeDiff",
    opts = {
      -- 高亮自动适配
      highlights = {
        line_insert = nil,
        line_delete = nil,
        char_insert = nil,
        char_delete = nil,
        char_brightness = nil,
      },
      -- VSCode 风格侧边栏
      explorer = {
        position = "left",
        width = 30,
        view_mode = "tree",
        icons = { folder_closed = "", folder_open = "" },
      },
      diff = {
        disable_inlay_hints = true,
        original_position = "left",
      },
      -- 内部快捷键
      keymaps = {
        view = { quit = "q", next_hunk = "]c", prev_hunk = "[c", diff_get = "do", toggle_stage = "-" },
      },
    },

    -- ⚡️ 终极强制覆盖 (Double Deferred) ⚡️
    init = function()
      -- 定义一个函数来设置键位，方便复用
      local function set_keymaps()
        vim.keymap.set("n", "<leader>gd", "<cmd>CodeDiff<cr>", {
          desc = "Diff Explorer (CodeDiff)",
          noremap = true,
          silent = true,
        })
        vim.keymap.set("n", "<leader>gf", "<cmd>CodeDiff file HEAD<cr>", {
          desc = "Diff File vs HEAD",
          noremap = true,
          silent = true,
        })
        vim.keymap.set("n", "<leader>gh", "<cmd>CodeDiff history<cr>", {
          desc = "File History (CodeDiff)",
          noremap = true,
          silent = true,
        })
      end

      -- 在 VeryLazy 事件触发时设置
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          -- 使用 schedule 再次推迟到当前事件循环结束
          vim.schedule(set_keymaps)
        end,
      })
    end,
  },
}
