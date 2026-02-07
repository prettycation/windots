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

    init = function()
      -- 定义一个函数来设置键位
      local function set_keymaps()
        -- 1. 界面启动快捷键
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

        -- 2. 【修复】使用 Gitsigns 来实现“还原块” (替代失效的 do)
        -- 只有在 CodeDiff 界面或普通编辑界面，只要是 Git 仓库文件，这个键都能用
        vim.keymap.set("n", "<leader>do", function()
          -- 使用 LazyVim 内置的 gitsigns 插件重置当前块
          -- 这比 CodeDiff 内部 API 更稳定，效果完全一样（撤销修改）
          require("gitsigns").reset_hunk()
        end, {
          desc = "Diff Obtain (Reset Hunk)",
          noremap = true,
          silent = true,
        })
      end

      -- 在 VeryLazy 事件触发时设置
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          vim.schedule(set_keymaps)
        end,
      })
    end,
  },
}
