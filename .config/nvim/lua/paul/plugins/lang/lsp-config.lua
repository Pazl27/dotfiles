return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    "b0o/schemastore.nvim", -- For JSON schemas
  },
  config = function()
    -- import cmp-nvim-lsp plugin for capabilities
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local keymap = vim.keymap -- for conciseness

    local opts = { noremap = true, silent = true }
    local on_attach = function(client, bufnr)
      opts.buffer = bufnr

      -- set keybinds
      opts.desc = "Show LSP references"
      keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

      opts.desc = "Go to declaration"
      keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

      opts.desc = "Show LSP definitions"
      keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

      opts.desc = "Show LSP implementations"
      keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

      opts.desc = "Show LSP type definitions"
      keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

      opts.desc = "See available code actions"
      keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

      opts.desc = "Smart rename"
      keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

      opts.desc = "Show buffer diagnostics"
      keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

      opts.desc = "Show line diagnostics"
      keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

      opts.desc = "Go to previous diagnostic"
      keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

      opts.desc = "Go to next diagnostic"
      keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

      opts.desc = "Show documentation for what is under cursor"
      keymap.set("n", "K", vim.lsp.buf.hover, opts)

      opts.desc = "Restart LSP"
      keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
    end

    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Configure diagnostic signs
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    -- Helper function to create root pattern (not needed for vim.lsp.config)
    -- vim.lsp.config uses root_markers instead

    -- Configure HTML server
    vim.lsp.config.html = {
      cmd = { "vscode-html-language-server", "--stdio" },
      filetypes = { "html" },
      root_markers = { "package.json", ".git" },
      single_file_support = true,
      capabilities = capabilities,
      on_attach = on_attach,
    }

    -- Configure TypeScript server
    vim.lsp.config.ts_ls = {
      cmd = { "typescript-language-server", "--stdio" },
      filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
      root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
      single_file_support = true,
      capabilities = capabilities,
      on_attach = on_attach,
    }

    vim.lsp.config.ast_grep = {
      cmd = { "ast-grep-languageserver", "--stdio" },
      filetypes = { "javascript" },
      root_markers = { ".git" },
      single_file_support = true,
      capabilities = capabilities,
      on_attach = on_attach,
    }

    -- Configure CSS server
    vim.lsp.config.cssls = {
      cmd = { "vscode-css-language-server", "--stdio" },
      filetypes = { "css", "scss", "less" },
      root_markers = { "package.json", ".git" },
      single_file_support = true,
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        css = {
          validate = true,
        },
        less = {
          validate = true,
        },
        scss = {
          validate = true,
        },
      },
    }

    -- Configure Vue.js server
    vim.lsp.config.vuels = {
      cmd = { "vue-language-server", "--stdio" },
      filetypes = { "vue" },
      root_markers = { "package.json", "vue.config.js", "nuxt.config.js", ".git" },
      capabilities = capabilities,
      on_attach = on_attach,
    }

    -- Configure C/C++ server
    vim.lsp.config.clangd = {
      cmd = { "clangd" },
      filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
      root_markers = { ".clangd", ".clang-tidy", ".clang-format", "compile_commands.json", "compile_flags.txt", "configure.ac", ".git" },
      single_file_support = true,
      capabilities = capabilities,
      on_attach = on_attach,
    }

    -- Configure Docker server
    vim.lsp.config.dockerls = {
      cmd = { "docker-langserver", "--stdio" },
      filetypes = { "dockerfile" },
      root_markers = { "Dockerfile", ".git" },
      single_file_support = true,
      capabilities = capabilities,
      on_attach = on_attach,
    }

    -- Configure Docker Compose server
    vim.lsp.config.docker_compose_language_service = {
      cmd = { "docker-compose-langserver", "--stdio" },
      filetypes = { "yaml.docker-compose" },
      root_markers = { "docker-compose.yaml", "docker-compose.yml", ".git" },
      single_file_support = true,
      capabilities = capabilities,
      on_attach = on_attach,
    }

    -- Configure JSON server
    vim.lsp.config.jsonls = {
      cmd = { "vscode-json-language-server", "--stdio" },
      filetypes = { "json", "jsonc" },
      root_markers = { "package.json", ".git" },
      single_file_support = true,
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        json = {
          schemas = require("schemastore").json.schemas(),
          validate = { enable = true },
        },
      },
    }

    -- Configure Bash server
    vim.lsp.config.bashls = {
      cmd = { "bash-language-server", "start" },
      filetypes = { "sh" },
      root_markers = { ".git" },
      single_file_support = true,
      capabilities = capabilities,
      on_attach = on_attach,
    }

    -- Configure Go server
    vim.lsp.config.gopls = {
      cmd = { "gopls" },
      filetypes = { "go", "gomod", "gowork", "gotmpl" },
      root_markers = { "go.work", "go.mod", ".git" },
      single_file_support = true,
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        gopls = {
          completeUnimported = true,
          usePlaceholders = true,
          analyses = {
            unusedparams = true,
          },
          staticcheck = true,
          gofumpt = true,
        },
      },
    }

    -- Configure Lua server (with special settings)
    vim.lsp.config.lua_ls = {
      cmd = { "lua-language-server" },
      filetypes = { "lua" },
      root_markers = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", "selene.toml", "selene.yml", ".git" },
      single_file_support = true,
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        Lua = {
          -- make the language server recognize "vim" global
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            -- make language server aware of runtime files
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
            },
          },
          telemetry = {
            enable = false,
          },
        },
      },
    }
  end,
}
            
