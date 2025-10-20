return {
  "mrcjkb/rustaceanvim",
  ft = { "rust" },
  opts = {
    server = {
      on_attach = function(_, bufnr)
        -- Use standard LSP code actions (will use Telescope via ui-select)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action", buffer = bufnr })
        vim.keymap.set("n", "<leader>dr", function()
          vim.cmd.RustLsp("debuggables")
        end, { desc = "Rust Debuggables", buffer = bufnr })
      end,
      default_settings = {
        -- rust-analyzer language server configuration
        ["rust-analyzer"] = {
          cargo = {
            allFeatures = true,
            loadOutDirsFromCheck = true,
            buildScripts = {
              enable = true,
            },
          },
          -- Add clippy lints for Rust
          checkOnSave = {
            command = "clippy",
          },
          -- Enable diagnostics
          diagnostics = {
            enable = true,
          },
          procMacro = {
            enable = true,
            ignored = {
              ["async-trait"] = { "async_trait" },
              ["napi-derive"] = { "napi" },
              ["async-recursion"] = { "async_recursion" },
            },
          },
          files = {
            excludeDirs = {
              ".direnv",
              ".git",
              ".github",
              ".gitlab",
              "bin",
              "node_modules",
              "target",
              "venv",
              ".venv",
            },
          },
        },
      },
    },
  },
  config = function(_, opts)
    -- Check if mason is available and codelldb is installed
    local mason_registry_ok, mason_registry = pcall(require, "mason-registry")
    if mason_registry_ok and mason_registry.is_installed("codelldb") then
      local codelldb = vim.fn.exepath("codelldb")
      if codelldb == "" then
        -- Fallback to mason path if not in PATH
        codelldb = vim.fn.expand("~/.local/share/nvim/mason/bin/codelldb")
      end

      local codelldb_lib_ext = vim.loop.os_uname().sysname == "Linux" and ".so" or ".dylib"
      local library_path = vim.fn.expand("~/.local/share/nvim/mason/packages/codelldb/extension/lldb/lib/liblldb" .. codelldb_lib_ext)

      -- Check if library exists, fallback to alternative path
      if vim.fn.filereadable(library_path) == 0 then
        library_path = vim.fn.expand("~/.local/share/nvim/mason/packages/codelldb/extension/adapter/codelldb")
      end

      opts.dap = {
        adapter = require("rustaceanvim.config").get_codelldb_adapter(codelldb, library_path),
      }
    else
      -- Use your existing DAP configuration from dap.lua
      -- rustaceanvim will automatically use the codelldb adapter you've already configured
      vim.notify("Using existing DAP configuration for Rust debugging", vim.log.levels.INFO, { title = "rustaceanvim" })
    end

    vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, opts or {})

    -- Check if rust-analyzer is available
    if vim.fn.executable("rust-analyzer") == 0 then
      vim.notify(
        "rust-analyzer not found in PATH, please install it.\nhttps://rust-analyzer.github.io/",
        vim.log.levels.ERROR,
        { title = "rustaceanvim" }
      )
    end
  end,
}
