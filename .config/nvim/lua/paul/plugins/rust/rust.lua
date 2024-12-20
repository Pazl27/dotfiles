return {
  'rust-lang/rust.vim',
  ft = "rust",
  init = function()
    -- vim.g.rustfmt_autosave = 1
    vim.keymap.set("n", "<leader>xf", "<cmd>:RustFmt<CR>", { desc = "Format Rust buffer" })
  end
}
