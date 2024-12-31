return {
  'mrcjkb/rustaceanvim',
  version = '^5', -- Recommended
  lazy = false,   -- This plugin is already lazy
  ft = "rust",
  [ "rust-analyser" ] = {
    cargo = {
      allFeatures = true,
    }
  },
  config = function()
    local mason_registry = require('mason-registry')
    local codelldb = mason_registry.get_package("codelldb")
    local extension_path = codelldb:get_install_path() .. "/extension/"
    local codelldb_path = extension_path .. "adapter/codelldb"
    -- local liblldb_path = extension_path.. "lldb/lib/liblldb.dylib"
    -- If you are on Linux, replace the line above with the line below:
    local liblldb_path = extension_path .. "lldb/lib/liblldb.so"
    local cfg = require('rustaceanvim.config')


    -- KEYMAPS
    vim.keymap.set("n", "<leader>ra", "<cmd>:RustLsp codeAction<CR>", { desc = "Rust Code action" })
    vim.keymap.set("n", "<leader>rd", "<cmd>:RustLsp renderDiagnostic current<CR>", { desc = "Line diagnostic"})
    vim.keymap.set("n", "<leader>rD", "<cmd>:RustLsp explainError current<CR>", { desc = "Explain error"})
    vim.keymap.set("n", "<leader>rO", "<cmd>:RustLsp openDocs<CR>", { desc = "Open documentation in browser"})
    vim.keymap.set("n", "K",  -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
      function()
        vim.cmd.RustLsp({'hover', 'actions'})
      end,
      { silent = true, buffer = bufnr }
    )
    -- rustaceanvim
    vim.keymap.set("n", "<Leader>rt", "<cmd>lua vim.cmd('RustLsp testables')<CR>", { desc = "Debugger testables" })
    vim.keymap.set("n", "<leader>rf", "<cmd>:RustFmt<CR>", { desc = "Format Rust buffer" })

    vim.g.rustaceanvim = {
      dap = {
        adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
      },
    }
  end
}
