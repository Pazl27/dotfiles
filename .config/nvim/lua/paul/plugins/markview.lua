return {
  "OXY2DEV/markview.nvim",
  lazy = false, -- Recommended

  dependencies = {
    --mini
    "nvim-tree/nvim-web-devicons",
  },

  config = function()
    local preset = require("markview.presets");

    require("markview").setup({
      markdown = {
        headings = preset.headings.slanted,
        horizontal_rules = preset.horizontal_rules.dotted,
        tables = preset.tables.rounded,
      },
      preview = {
        icon_provider = "devicons",
        enabled = true,
        enable_hybrid_mode = true,
        -- modes = { "n", "no", "c" },
        hybrid_modes = { "n" },
        linewise_hybrid_mode = true,
        filetypes = { "markdown", "quarto", "rmd", "typst"}
      },
    })
  end
}
