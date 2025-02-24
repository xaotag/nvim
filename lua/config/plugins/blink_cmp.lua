return {
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		build = "make install_jsregexp",
		dependencies = "rafamadriz/friendly-snippets",
		config = function()
			local luasnip = require("luasnip")
			luasnip.filetype_extend("typescript", { "javascript" })
			luasnip.filetype_extend("typescriptreact", { "javascript" })
			luasnip.filetype_extend("typescriptreact", { "javascript", "html" })
			luasnip.filetype_extend("python", { "python" })
			require("luasnip/loaders/from_vscode").load({ include = { "javascript", "html" } })
			require("luasnip/loaders/from_vscode").lazy_load()
		end,
	},
	{
		"saghen/blink.cmp",
		event = { "InsertEnter", "CmdlineEnter" },
		build = "cargo build --release" or nil,
		config = function()
			require("blink-cmp").setup({
				appearance = {
					nerd_font_variant = "normal",
					use_nvim_cmp_as_default = true,
				},
				completion = {

					ghost_text = {
						enabled = true,
						show_with_menu = true,
					},
					list = {
						selection = {
							preselect = true,
							auto_insert = false,
						},
					},
					menu = {
						auto_show = false,
						draw = {
							treesitter = { "lsp" },
							components = {
								kind_icon = {
									ellipsis = false,
									text = function(ctx)
										if ctx.item.kind_name == "llm" then
											return "🪄"
										else
											return ctx.kind_icon
										end
									end,

									-- Optionally, you may also use the highlights from mini.icons
									highlight = function(ctx)
										if ctx.item.kind_name == "llm" then
											return "BlinkCmpKindSnippet"
										else
											return ctx.kind_hl
										end
									end,
								},
							},
						},
					},
					trigger = {
						show_on_keyword = true, -- 输入关键字时自动触发
						prefetch_on_insert = true, -- 预加载补全项
					},
					documentation = {
						auto_show = true, -- 选中项时自动显示文档
						auto_show_delay_ms = 100, -- 避免频繁刷新
					},
				},
				keymap = {
					preset = "none",
					["<C-e>"] = { "show", "show_documentation", "hide_documentation" },
					["<CR>"] = { "accept", "fallback" },
					["<Tab>"] = { "show", "select_next", "snippet_forward", "fallback" },
					["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
					["<C-b>"] = { "scroll_documentation_up", "fallback" },
					["<C-f>"] = { "scroll_documentation_down", "fallback" },
					["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
				},
				snippets = {
					preset = "luasnip",
				},
				sources = {
					default = { "lazydev", "lsp", "path", "snippets", "snippets", "buffer", "llm" },
					providers = {
						llm = {
							name = "llm",
							module = "llm.common.completion.frontends.blink",
							timeout_ms = 10000,
							score_offset = 100,
							async = true,
						},
						lazydev = {
							name = "LazyDev",
							module = "lazydev.integrations.blink",
							-- make lazydev completions top priority (see `:h blink.cmp`)
							score_offset = 100,
						},
					},
				},
			})
		end,
	},
}
