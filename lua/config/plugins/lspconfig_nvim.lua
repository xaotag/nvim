return {
  "neovim/nvim-lspconfig",
  config = function()
    local lsp_attach_group = vim.api.nvim_create_augroup("lsp-attach", { clear = true })
    local lsp_inlay_group = vim.api.nvim_create_augroup("lsp-inlay-hints", { clear = true })
    local ts_organize_group = vim.api.nvim_create_augroup("ts-organize-imports", { clear = true })

    vim.api.nvim_create_autocmd("LspAttach", {
      group = lsp_inlay_group,
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client.server_capabilities.inlayHintProvider then
          vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
        end
      end,
    })

    vim.lsp.config("*", {
      capabilities = require("blink.cmp").get_lsp_capabilities(),
    })
    -- LSP, 启动!
    for _, server in ipairs({ "emmylua_ls", "vtsls", "html", "emmet_language_server", "gopls", "pyright", "clangd", "jsonls" }) do
      vim.lsp.enable(server)
    end

    vim.lsp.config.jsonls = {
      settings = {
        json = {
          validate = { enable = true },
          format = { enable = true },
          schemas = {
            { fileMatch = { "*.json", "*.jsonc" }, url = "https://json.schemastore.org/package.json" },
            { fileMatch = { "tsconfig*.json" }, url = "https://json.schemastore.org/tsconfig.json" },
            { fileMatch = { ".eslintrc.json" }, url = "https://json.schemastore.org/eslintrc.json" },
            { fileMatch = { ".prettierrc", "prettier.config.*" }, url = "https://json.schemastore.org/prettierrc.json" },
            { fileMatch = { "*.code-workspace" }, url = "https://json.schemastore.org/workspace.json" },
          },
        },
      },
    }
    -- rust-analyzer 由 rustaceanvim 管理，无需手动启用

    vim.api.nvim_create_autocmd("BufWritePre", {
      group = ts_organize_group,
      pattern = { "*.ts", "*.tsx" },
      -- 调用 vtsls 提供的专有命令（比 code_action 更快更直接）
      callback = function(args)
        vim.lsp.buf.execute_command({
          command = "typescript.organizeImports",
          arguments = { vim.api.nvim_buf_get_name(args.buf) },
        })
      end,
    })
    -- Define LSP-related keymaps
    --
    vim.api.nvim_create_autocmd("LspAttach", {
      group = lsp_attach_group,
      callback = function(event)
        local bufnr = event.buf
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if not client then
          return
        end

        -- 通用键位（buffer-local）
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end

        -- 以下跳转键由 Snacks Picker 提供
        -- map("n", "gd", vim.lsp.buf.definition, "Goto Definition")
        -- map("n", "gr", vim.lsp.buf.references, "References")
        -- map("n", "gi", vim.lsp.buf.implementation, "Implementation")
        -- map("n", "gD", vim.lsp.buf.declaration, "Declaration")
        map("n", "<leader>k", vim.lsp.buf.hover, "Hover")
        map("n", "<leader>la", vim.lsp.buf.code_action, "Code Action")
        map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")

        -- Diagnostics
        map("n", "[e", vim.diagnostic.goto_prev, "Prev Diagnostic")
        map("n", "]e", vim.diagnostic.goto_next, "Next Diagnostic")
        map("n", "<leader>ld", function()
          vim.diagnostic.open_float({ source = true })
        end, "Show Diagnostic")

        -- Toggle diagnostics
        local diag_status = true
        map("n", "<leader>td", function()
          diag_status = not diag_status
          vim.diagnostic.config({
            underline = diag_status,
            virtual_text = diag_status,
            signs = diag_status,
            update_in_insert = diag_status,
          })
        end, "Toggle Diagnostics")

        -- Inlay hints toggle
        if client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
          map("n", "<leader>th", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }))
          end, "Toggle Inlay Hints")
        end

        -- Document highlight（光标下词高亮）
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

        -- Folding（可选，性能敏感项目慎用）
        if client.supports_method("textDocument/foldingRange") then
          vim.wo.foldexpr = "v:lua.vim.lsp.foldexpr()"
          vim.wo.foldmethod = "expr"
          vim.wo.foldlevel = 99 -- 默认展开
        end
      end,
    })
  end,
}
