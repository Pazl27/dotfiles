return {
  {
    "sainnhe/gruvbox-material",
    enabled = true,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_transparent_background = 0
      vim.g.gruvbox_material_foreground = "original" -- mix, material, original
      vim.g.gruvbox_material_background = "hard"     -- soft, medium, hard
      vim.g.gruvbox_material_ui_contrast = "high"   -- The contrast of line numbers, indent lines, etc.
      vim.g.gruvbox_material_float_style = "dim"  -- Background of floating windows (dim, bright)
      vim.g.gruvbox_material_diagnostic_line_highlight = 1
      vim.g.gruvbox_material_diagnostic_virtual_text = "highlighted"
      -- vim.g.gruvbox_material_dim_inactive_windows = 1
      vim.g.gruvbox_material_better_performance = 0

      vim.cmd.colorscheme("gruvbox-material")

      -- Make cursorline more visible with a lighter background
      vim.api.nvim_set_hl(0, 'CursorLine', { bg = '#3c3836' })  -- visible highlight
      vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#d8a657', bg = '#3c3836', bold = true })
    end,
  },
}
