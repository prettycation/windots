return {
  "NeogitOrg/neogit",
  lazy = true,
  dependencies = {
    "nvim-lua/plenary.nvim", -- required
    "sindrets/diffview.nvim", -- optional - Diff integration
    "folke/snacks.nvim", -- optional
  },
  cmd = "Neogit",
  keys = {
    { "<leader>gn", "<cmd>Neogit<cr>", desc = "Show Neogit UI" },
  },
  config = function()
    require("neogit").setup({
      use_default_keymaps = true, -- 使用 Neogit 的默认键绑定
    })
  end,
}
