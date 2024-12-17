return {
  "folke/which-key.nvim",
  dependencies = {
    "echasnovski/mini.nvim",
  },
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500

    local wk = require("which-key")

    wk.add({ "<leader>t", group = "Tabs|Terminal" })
    wk.add({ "<leader>b", group = "Buffers" })
    wk.add({ "<leader>f", group = "Telescope" })
    wk.add({ "<leader>s", group = "Window" })
    wk.add({ "<leader>x", group = "Trouble" })
    wk.add({ "<leader>r", group = "Rename|Restart" })
    wk.add({ "<leader>q", group = "Quit" })
    wk.add({ "<leader>c", group = "CodeActions|Copilot" })
    wk.add({ "<leader>h", group = "Testing"})
    wk.add({ "<leader>g", group = "Git"})
    wk.add({ "<leader>d", group = "Debug"})
  end,
}
