return {
	{
		"neovim/nvim-lspconfig",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason").setup()
			local lspconfig = require("lspconfig")
			-- LSP 通用配置
			local on_attach = function(client, bufnr)
				-- 快捷键绑定
				local opts = { noremap = true, silent = true, buffer = bufnr }
				vim.keymap.set("n", "<leader>k", vim.lsp.buf.hover, opts) -- 显示文档
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts) -- 代码操作
				vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, opts) -- 显示错误浮窗
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
				vim.keymap.set("n", "]e", vim.diagnostic.goto_next)
				vim.keymap.set("n", "[e", vim.diagnostic.goto_prev)
			end
			for server, config in pairs(require("lsp").servers) do
				config.capabilities = require("blink.cmp").get_lsp_capabilities()
				config.on_attach = on_attach
				lspconfig[server].setup(config)
			end
		end,
	},
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		build = "make install_jsregexp",
		dependencies = "rafamadriz/friendly-snippets",
		config = function()
			local luasnip = require("luasnip")
			luasnip.filetype_extend("typescript", { "javascript" })
			luasnip.filetype_extend("typescriptreact", { "javascript" })
			require("luasnip/loaders/from_vscode").load({ include = { "javascript" } })
			require("luasnip/loaders/from_vscode").lazy_load()
		end,
	},
	{
		"saghen/blink.cmp",
		--		version = "*",
		build = "cargo +nightly build --release",
		opts = {
			appearance = {
				nerd_font_variant = "normal",
				use_nvim_cmp_as_default = true,
			},
			completion = {
				trigger = { prefetch_on_insert = false, show_on_blocked_trigger_characters = {} },
				documentation = { auto_show = true, auto_show_delay_ms = 0 },
				ghost_text = { enabled = true },
			},
			keymap = {
				preset = "none",
				["<C-e>"] = { "hide" },
				["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
				["<CR>"] = { "select_and_accept", "fallback" },
				["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
				["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
				["<C-b>"] = { "scroll_documentation_up", "fallback" },
				["<C-f>"] = { "scroll_documentation_down", "fallback" },
				["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
			},
			snippets = {
				preset = "luasnip",
			},
			sources = {
				default = { "lazydev", "snippets", "llm", "lsp", "path", "snippets", "buffer" },
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						-- make lazydev completions top priority (see `:h blink.cmp`)
						score_offset = 100,
					},
					llm = {
						name = "llm",
						module = "llm.common.completion.frontends.blink",
						timeout_ms = 10000,
						score_offset = 100,
						async = true,
					},
				},
			},
		},
	},
}
