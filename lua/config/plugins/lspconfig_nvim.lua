return {
  "neovim/nvim-lspconfig",
  config = function()
    local border = "rounded"
    local lsp_attach_group = vim.api.nvim_create_augroup("lsp-attach", { clear = true })
    local lsp_inlay_group = vim.api.nvim_create_augroup("lsp-inlay-hints", { clear = true })
    local ts_organize_group = vim.api.nvim_create_augroup("ts-organize-imports", { clear = true })

    -- Neovim 0.12: 配置 hover 和 signature help 边框 (使用 handlers)
    local function hover_handler(_, result, ctx)
      if result then
        vim.lsp.handlers.hover(_, result, ctx)
      end
    end

    local function signature_handler(_, result, ctx)
      if result then
        vim.lsp.handlers.signature_help(_, result, ctx)
      end
    end

    vim.lsp.config("*", {
      handlers = {
        ["textDocument/hover"] = hover_handler,
        ["textDocument/signatureHelp"] = signature_handler,
      },
    })

    -- Inlay hints on attach
    vim.api.nvim_create_autocmd("LspAttach", {
      group = lsp_inlay_group,
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client.server_capabilities.inlayHintProvider then
          vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
        end
      end,
    })

    -- LSP 启动
    for _, server in ipairs({
      "emmylua_ls",
      "vtsls",
      "html",
      "emmet_language_server",
      "gopls",
      "pyright",
      "clangd",
      "jsonls",
    }) do
      vim.lsp.enable(server)
    end

    -- JSON schema 配置
    vim.lsp.config.jsonls = {
      settings = {
        json = {
          validate = { enable = true },
          format = { enable = true },
          schemas = {
            { fileMatch = { "*.json", "*.jsonc" }, url = "https://json.schemastore.org/package.json" },
            { fileMatch = { "tsconfig*.json" }, url = "https://json.schemastore.org/tsconfig.json" },
            { fileMatch = { ".eslintrc.json" }, url = "https://json.schemastore.org/eslintrc.json" },
            {
              fileMatch = { ".prettierrc", "prettier.config.*" },
              url = "https://json.schemastore.org/prettierrc.json",
            },
            { fileMatch = { "*.code-workspace" }, url = "https://json.schemastore.org/workspace.json" },
          },
        },
      },
    }

    -- TypeScript 保存时自动整理 imports
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = ts_organize_group,
      pattern = { "*.ts", "*.tsx" },
      callback = function(args)
        vim.lsp.buf.execute_command({
          command = "typescript.organizeImports",
          arguments = { vim.api.nvim_buf_get_name(args.buf) },
        })
      end,
    })

    -- LspAttach 键位
    vim.api.nvim_create_autocmd("LspAttach", {
      group = lsp_attach_group,
      callback = function(event)
        local bufnr = event.buf
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if not client then
          return
        end

        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end

        -- Neovim 0.12: 内置 LSP 键位 (grt, grx)
        -- 自定义键位
        map("n", "<leader>k", vim.lsp.buf.hover, "Hover")
        map("n", "<leader>la", vim.lsp.buf.code_action, "Code Action")
        map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")

        -- Diagnostics - Neovim 0.12: 使用 vim.diagnostic.jump()
        map("n", "[e", function()
          vim.diagnostic.jump({ count = -1, float = true })
        end, "Prev Diagnostic")
        map("n", "]e", function()
          vim.diagnostic.jump({ count = 1, float = true })
        end, "Next Diagnostic")
        map("n", "<leader>ld", function()
          vim.diagnostic.open_float({ source = true })
        end, "Show Diagnostic")

        -- Toggle diagnostics
        local diag_enabled = true
        map("n", "<leader>td", function()
          diag_enabled = not diag_enabled
          if diag_enabled then
            vim.diagnostic.enable()
          else
            vim.diagnostic.disable()
          end
        end, "Toggle Diagnostics")

        -- Inlay hints toggle
        if client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
          map("n", "<leader>th", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }))
          end, "Toggle Inlay Hints")
        end

        -- Document highlight
        if client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
          local highlight_group = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = bufnr,
            group = highlight_group,
            callback = vim.lsp.buf.document_highlight,
          })
          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = bufnr,
            group = highlight_group,
            callback = vim.lsp.buf.clear_references,
          })
        end

        -- Folding
        if client.supports_method("textDocument/foldingRange") then
          vim.wo.foldexpr = "v:lua.vim.lsp.foldexpr()"
          vim.wo.foldmethod = "expr"
          vim.wo.foldlevel = 99
        end
      end,
    })
  end,
}
