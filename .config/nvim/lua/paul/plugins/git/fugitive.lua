return {
  "tpope/vim-fugitive",
  cmd = { "Git", "Gstatus", "Gblame", "Gpush", "Gpull", "Gdiff", "Gcommit" },
  keys = {
  },
  config = function()
    -- Configure vim-fugitive settings if needed
    vim.g.fugitive_summary_format = "%s (%an %ad)"
  end,
}
