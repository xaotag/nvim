return {
	servers = {
		cssmodules_ls = {},
		css_variables = {
			cssVariables = {
				lookupFile = {
					"astro",
					"svelte",
					"vue",
					"vue-html",
					"vue-postcss",
					"scss",
					"postcss",
					"less",
					"css",
					"html",
					"javascript",
					"javascriptreact",
					"typescript",
					"typescriptreact",
					"source.css.styled",
				},
			},
		},
		cssls = {},
		html = {},
		ts_ls = {
			init_options = {
				plugins = {},
			},
			settings = {
				typescript = {
					tsserver = {
						useSyntaxServer = false,
					},
					inlayHints = {
						includeInlayParameterNameHints = "all",
						includeInlayParameterNameHintsWhenArgumentMatchesName = true,
						includeInlayFunctionParameterTypeHints = true,
						includeInlayVariableTypeHints = false,
						includeInlayVariableTypeHintsWhenTypeMatchesName = false,
						includeInlayPropertyDeclarationTypeHints = false,
						includeInlayFunctionLikeReturnTypeHints = false,
						includeInlayEnumMemberValueHints = false,
					},
				},
			},
		},
		lua_ls = {
			settings = {
				Lua = {
					hint = {
						enable = true,
						arrayIndex = "Enable",
					},
				},
			},
		},
	},
	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
		callback = function(event)
			local map = function(keys, func, desc)
				vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
			end

			map("gd", function()
				local builtin = require("telescope.builtin")
				local params = vim.lsp.util.make_position_params()
				vim.lsp.buf_request(params.bufnr, "textDocument/definition", params, function(_, result, _, _)
					if not result or vim.tbl_isempty(result) then
						vim.notify("No definition found", vim.log.levels.INFO)
					else
						-- vim.lsp.buf.definition()
						builtin.lsp_definitions()
					end
				end)
			end, "Goto Definition")
			map("gD", vim.lsp.buf.declaration, "Goto Declaration")
			map("gi", require("telescope.builtin").lsp_implementations, "Code implementation on telescope")
			map("gr", require("telescope.builtin").lsp_references, "Goto References")
			map("<leader>la", vim.lsp.buf.code_action, "Lsp Action")
			map("<leader>rn", vim.lsp.buf.rename, "Lsp Rename")
			map("<leader>k", vim.lsp.buf.hover, "Lsp Rename")
			map("<leader>le", require("telescope.builtin").diagnostics, "error list on telescope")

			-- Diagnostics
			map("<leader>ld", function()
				vim.diagnostic.open_float({ source = true })
			end, "LSP Open Diagnostic")

			local client = vim.lsp.get_client_by_id(event.data.client_id)

			-- Highlight words under cursor
			if
				client
				and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight)
				and vim.bo.filetype ~= "bigfile"
			then
				local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
				vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
					buffer = event.buf,
					group = highlight_augroup,
					callback = vim.lsp.buf.document_highlight,
				})

				vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
					buffer = event.buf,
					group = highlight_augroup,
					callback = vim.lsp.buf.clear_references,
				})

				vim.api.nvim_create_autocmd("LspDetach", {
					group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
					callback = function(event2)
						vim.lsp.buf.clear_references()
						vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
					end,
				})
			end
		end,
	}),
}
