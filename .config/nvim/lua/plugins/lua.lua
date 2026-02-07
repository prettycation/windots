return {
  -- 1. Lua 开发环境 (LazyDev)
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        -- 加载 luvit 类型
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },

        -- 预加载核心框架和常用插件
        "LazyVim",
        { path = "nvim-lspconfig", words = { "lspconfig" } },
        { path = "nvim-cmp", words = { "cmp" } },
        { path = "blink.cmp", words = { "blink" } },
      },
      -- 显式启用集成
      integrations = {
        lspconfig = true,
        cmp = true,
      },
    },
  },

  -- 2. Lua 语言服务器的具体设置
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        lua_ls = {
          -- 这里不需要 mason = false，因为 lua_ls 还是建议用 mason 管理，
          -- 除非你也用 scoop 安装了 lua-language-server
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false, -- 推荐关闭
                -- 必须清空 ignoreDir，否则插件内的 /lua 目录会被跳过
                ignoreDir = {},
                -- 允许更深入的库搜索
                pathStrict = false,
              },
              completion = {
                callSnippet = "Replace",
              },
              -- 诊断设置
              diagnostics = {
                -- 忽略一些在模板文件中常见的、由于跨插件引用导致的注解警告
                disable = { "undefined-doc-name", "undefined-field" },
              },
            },
          },
        },
      },
    },
  },

  -- 3. 格式化配置 (Conform)
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        -- 指定 lua 使用 stylua
        -- 由于你是 Scoop 安装的，conform 会自动在 Path 环境变量中找到它
        lua = { "stylua" },
      },
    },
  },

  -- 4. 确保 Mason 不会自动安装 stylua (对应 "mason = false" 的需求)
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      -- 过滤掉 stylua，防止 Mason 自动安装导致与 Scoop 版本冲突
      opts.ensure_installed = vim.tbl_filter(function(name)
        return name ~= "stylua"
      end, opts.ensure_installed)
    end,
  },
}
