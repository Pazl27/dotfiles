return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  dependencies = {
    "OXY2DEV/markview.nvim",
  },
  build = ":TSUpdate",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local config = require("nvim-treesitter.configs")
    config.setup({
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },

      ensure_installed = {
        "bash",
        "css",
        "dockerfile",
        "go",
        "html",
        "javascript",
        "json",
        "lua",
        "python",
        "rust",
        "yaml",
        "cmake",
        "cpp",
        "c",
        "java",
        "make",
        "markdown",
        "markdown_inline",
        "toml",
        "yaml"
      }
    })
  end
}
