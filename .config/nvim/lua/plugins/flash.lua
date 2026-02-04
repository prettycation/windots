return {
  "folke/flash.nvim",

  opts = {
    modes = {
      char = {
        enabled = false, -- 禁用 flash.nvim 的字符搜索模式
      },
    },
  },

  keys = {
    -- 禁用默认的 's' 键
    { "s", mode = { "n", "x", "o" }, false },
    { "S", mode = { "n", "x", "o" }, false },

    -- 将 'f' 映射到 jump 功能
    {
      "f",
      mode = { "n", "x", "o" },
      function()
        require("flash").jump()
      end,
      desc = "Flash Jump",
    },
  },
}
