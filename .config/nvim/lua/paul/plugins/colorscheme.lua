return {
  {
    "sainnhe/gruvbox-material",
    enabled = true,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_transparent_background = 0
      vim.g.gruvbox_material_foreground = "medium"  -- mix, material, original
      vim.g.gruvbox_material_background = "medium"  -- soft, medium, hard
      vim.g.gruvbox_material_ui_contrast = "high"   -- The contrast of line numbers, indent lines, etc.
      vim.g.gruvbox_material_float_style = "bright" -- Background of floating windows
      vim.g.gruvbox_material_statusline_style = "original"
      vim.g.gruvbox_material_cursor = "auto"

      -- vim.g.gruvbox_material_colors_override = { bg0 = '#000000' } -- #0e1010
      -- vim.g.gruvbox_material_colors_override = { bg0 = "#121212" }
      vim.g.gruvbox_material_better_performance = 0

      -- vim.cmd.colorscheme("gruvbox-material")
    end,
  },
  {
    "ellisonleao/gruvbox.nvim",
    name = "gruvbox",
    priority = 1000,
    opts = {
      alpha = true,
    },
    config = function()
      require("gruvbox").setup({
        terminal_colors = true,
      })
      -- vim.cmd("colorscheme gruvbox")
    end,
  },
  {
    "ajmwagar/vim-deus",
    priority = 1000,
    config = function()
      -- vim.cmd("colorscheme deus")
    end,
  }

}
