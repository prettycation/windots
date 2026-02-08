return {
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
      "mfussenegger/nvim-dap-python",
    },
    lazy = false,
    ft = "python",

    keys = {
      { "<leader>cv", "<cmd>VenvSelect<cr>", desc = "Select VirtualEnv" },
    },

    opts = {
      options = {
        debug = false,
        notify_user_on_venv_activation = true,
        on_telescope_result_callback = function(filename)
          return vim.fn.fnamemodify(filename, ":h:t")
        end,
      },

      search = {
        my_envs = {
          -- -F: 固定字符串
          command = "fd -u -F python.exe E:\\anaconda\\envs --full-path --color never -E Lib",
          type = "anaconda",
        },
        my_base = {
          command = "fd -u -F python.exe E:\\anaconda --max-depth 1 --full-path --color never -E Lib",
          type = "anaconda",
        },
      },
    },
  },
}
