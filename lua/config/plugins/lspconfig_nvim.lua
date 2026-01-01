return {
	"neovim/nvim-lspconfig",
	config = function()
		vim.lsp.config("*", {
			capabilities = require("blink.cmp").get_lsp_capabilities(),
		})
		-- LSP, 启动!
		vim.lsp.enable("emmylua_ls")
		vim.lsp.enable("vtsls")
		vim.lsp.enable("html")
		vim.lsp.enable("emmet_language_server")
		vim.lsp.enable("gopls")
		vim.lsp.enable("pyright")
		vim.lsp.enable("clangd")
		vim.lsp.enable("rust_analyzer")

		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*.ts,*.tsx",
			-- 调用 vtsls 提供的专有命令（比 code_action 更快更直接）
			callback = function()
				vim.lsp.buf.execute_command({
					command = "typescript.organizeImports",
					arguments = { vim.api.nvim_buf_get_name(0) },
				})
			end,
		})
		-- Define LSP-related keymaps
		--
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
			callback = function(event)
				local bufnr = event.buf
				local client = vim.lsp.get_client_by_id(event.data.client_id)

				-- 通用键位（buffer-local）
				local map = function(mode, lhs, rhs, desc)
					vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
				end

				map("n", "gd", vim.lsp.buf.definition, "Goto Definition")
				map("n", "gr", vim.lsp.buf.references, "References")
				map("n", "gi", vim.lsp.buf.implementation, "Implementation")
				map("n", "gD", vim.lsp.buf.declaration, "Declaration")
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
