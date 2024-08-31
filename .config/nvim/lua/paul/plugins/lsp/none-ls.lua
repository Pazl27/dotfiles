return {
  "nvimtools/none-ls.nvim", -- configure formatters & linters
  lazy = true,
  -- event = { "BufReadPre", "BufNewFile" }, -- to enable uncomment this
  dependencies = {
    "jay-babu/mason-null-ls.nvim",
  },
  config = function()
    local mason_null_ls = require("mason-null-ls")

    local null_ls = require("null-ls")

    local null_ls_utils = require("null-ls.utils")

    mason_null_ls.setup({
      ensure_installed = {
        "prettier",     -- prettier formatter
        "stylua",       -- lua formatter
        "black",        -- python formatter
        "pylint",       -- python linter
        "eslint_d",     -- js linter
        "clang_format", -- c/c++ formatter
        "cpplint",      -- c/c++ linter
        "isort",        -- python formatter
        "goline",       -- go formatter
        "goimports",    -- go formatter
      },
    })

    -- for conciseness
    local formatting = null_ls.builtins.formatting   -- to setup formatters
    local diagnostics = null_ls.builtins.diagnostics -- to setup linters

    -- configure null_ls
    null_ls.setup({
      root_dir = null_ls_utils.root_pattern(".null-ls-root", "Makefile", ".git", "package.json"),
      -- setup formatters & linters
      sources = {

        -- js/ts fromatter
        formatting.prettier.with({
          extra_filetypes = { "svelte" },
        }),

        -- lua
        formatting.stylua,

        -- python
        formatting.isort,
        formatting.black,
        diagnostics.pylint,

        -- c/c++
        formatting.clang_format,
        diagnostics.cpplint,

        -- go
        formatting.goline,
        formatting.goimports_reviser,

        -- js/ts linter
        diagnostics.eslint_d.with({
          condition = function(utils)
            return utils.root_has_file({ ".eslintrc.js", ".eslintrc.cjs" }) -- only enable if root has .eslintrc.js or .eslintrc.cjs
          end,
        }),

      },
    })

    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
    require("null-ls").setup({
      on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.formatting_sync()
            end,
          })
        end
      end,
    })
  end,
}
