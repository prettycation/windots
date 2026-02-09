return {
  {
    "rainzm/flash-zh.nvim",
    dependencies = { "folke/flash.nvim" },
    event = "VeryLazy",
    keys = {
      {
        "f",
        mode = { "n", "x", "o" },
        function()
          local Flash = require("flash")

          -- 定义双字符标签样式
          local function format_two_char(opts)
            return {
              { opts.match.label1, "FlashMatch" },
              { opts.match.label2, "FlashLabel" },
            }
          end

          require("flash-zh").jump({
            chinese_only = false,

            -- 允许先输入一个字符
            search = {
              -- 允许输入，默认配置
            },

            -- 禁大写
            label = {
              uppercase = false,
              exclude = "",
            },

            labeler = function(matches, state)
              -- 只有 18 个键。如果匹配数 > 18，就会自动进入双字符模式
              local labels = vim.split("fgrtvbdecjhuynmki;", "")

              -- A. 匹配少 (<= 18) -> 单字符
              if #matches <= #labels then
                for m, match in ipairs(matches) do
                  match.label = labels[m]
                end

              -- B. 匹配多 (> 18) -> 双字符
              else
                for m, match in ipairs(matches) do
                  -- 计算逻辑自动适配 labels 长度 (18)
                  -- 第一位标签优先使用 f, g, r... 这些好按的键
                  local idx1 = math.floor((m - 1) / #labels) + 1
                  local idx2 = (m - 1) % #labels + 1

                  -- 边界保护
                  if idx1 > #labels then
                    idx1 = #labels
                  end

                  match.label1 = labels[idx1]
                  match.label2 = labels[idx2]

                  -- 初始显示第一位
                  match.label = match.label1
                end

                -- 使用 vim.schedule 修改，避免在渲染循环中直接修改导致的状态竞争
                vim.schedule(function()
                  -- 强制双字样式
                  state.opts.label.format = format_two_char
                  -- 劫持 Action
                  state.opts.action = function(match, inner_state)
                    inner_state:hide()
                    Flash.jump({
                      search = { max_length = 0 },
                      highlight = { matches = false },
                      label = { format = format_two_char, uppercase = false },
                      matcher = function(win)
                        return vim.tbl_filter(function(m)
                          return m.label == match.label and m.win == win
                        end, inner_state.results)
                      end,
                      labeler = function(inner_matches)
                        for _, m in ipairs(inner_matches) do
                          m.label = m.label2
                        end
                      end,
                    })
                  end
                end)
              end
            end,
          })
        end,
        desc = "Flash Smart Jump",
      },
    },
  },

  {
    "folke/flash.nvim",
    keys = {
      { "s", mode = { "n", "x", "o" }, false },
      { "S", mode = { "n", "x", "o" }, false },
    },
    opts = {
      -- 同步更新，虽然 flash-zh 覆盖了
      labels = "fgrtvbdecjhuynmki;",
      label = { uppercase = false },
      modes = { char = { enabled = false } },
      -- 唯一匹配自动跳转
      jump = {
        autojump = true,
      },
    },
  },
}
