return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    signs = {
      add = { text = "│" },
      change = { text = "│" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "│" },
      untracked = { text = "┆" },
    },

    numhl = false, -- 关闭行号高亮
    linehl = false, -- 关闭背景色
    on_attach = function(bufnr)
      local gitsigns = require("gitsigns")
      -- 注册 Group 名称 (Git Signs)
      -- 使用 pcall 防止未安装 which-key 时报错
      pcall(function()
        local wk = require("which-key")
        wk.add({
          { "<leader>h", group = "Git History" },
          { "<leader>t", group = "Toggle" }, -- 为 tb/tw 注册 Toggle 组
        })
      end)
      -- 辅助函数：支持传入 opts 用于设置 desc
      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end
      -- Navigation (跳转)
      map("n", "]c", function()
        if vim.wo.diff then
          vim.cmd.normal({ "]c", bang = true })
        else
          gitsigns.nav_hunk("next")
        end
      end, { desc = "Next Hunk" })
      map("n", "[c", function()
        if vim.wo.diff then
          vim.cmd.normal({ "[c", bang = true })
        else
          gitsigns.nav_hunk("prev")
        end
      end, { desc = "Prev Hunk" })
      -- Hunk Actions (块操作)
      map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Preview Hunk" })
      map("n", "<leader>hi", gitsigns.preview_hunk_inline, { desc = "Preview Hunk Inline" })
      map("n", "<leader>hb", function()
        gitsigns.blame_line({ full = true })
      end, { desc = "Blame Line" })
      map("n", "<leader>hd", gitsigns.diffthis, { desc = "Diff This" })
      map("n", "<leader>hD", function()
        gitsigns.diffthis("~")
      end, { desc = "Diff This ~" })
      map("n", "<leader>hQ", function()
        gitsigns.setqflist("all")
      end, { desc = "Set qflist (all)" })

      map("n", "<leader>hq", gitsigns.setqflist, { desc = "Set qflist" })
      -- Toggles (开关)
      map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "Toggle Line Blame" })
      map("n", "<leader>tw", gitsigns.toggle_word_diff, { desc = "Toggle Word Diff" })
      -- Text object (文本对象)
      map({ "o", "x" }, "ih", gitsigns.select_hunk, { desc = "Select Hunk" })
    end,
  },
}
