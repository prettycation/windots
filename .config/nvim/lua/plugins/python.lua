return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- 启用 basedpyright
        basedpyright = {
          settings = {
            basedpyright = {
              analysis = {
                typeCheckingMode = "basic", -- 可选: "off", "basic", "standard", "strict"
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
              },
            },
          },
        },
      },
      -- 确保 Mason 安装它
      setup = {
        basedpyright = function()
          -- 这里可以添加特定于 basedpyright 的初始化逻辑
        end,
      },
    },
  },

  -- 让 Mason 自动下载二进制文件
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "basedpyright" })
    end,
  },
}
