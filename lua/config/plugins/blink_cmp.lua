return {
	{
		"saghen/blink.cmp",
		dependencies = {
			"rafamadriz/friendly-snippets",
			"echasnovski/mini.snippets", -- 新增这个
		},
		event = { "InsertEnter", "CmdlineEnter" },
		version = "1.*",
		config = function()
			require("mini.snippets").setup({
				visual = {
					enabled = false,
				},
				snippets = {
					require("mini.snippets").gen_loader.from_lang(),
				},
			})
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
						auto_show = true,
						draw = {
							treesitter = { "lsp" },
							components = {
								kind_icon = {
									ellipsis = false,
									text = function(ctx)
										return ctx.kind_icon
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
						show_in_snippet = false,
					},
					documentation = {
						auto_show = true, -- 选中项时自动显示文档
						auto_show_delay_ms = 100, -- 避免频繁刷新
					},
				},
				keymap = {
					preset = "enter",
					["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
					["<CR>"] = { "accept", "fallback" },
					["<Tab>"] = {
						"select_next",
						"snippet_forward",
						"fallback",
					},
					["<S-Tab>"] = {
						"select_prev",
						"snippet_backward",
						"fallback",
					},
					["<C-b>"] = { "scroll_documentation_up", "fallback" },
					["<C-f>"] = { "scroll_documentation_down", "fallback" },
					["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
				},
				snippets = {
					preset = "mini_snippets",
				},
				sources = {
					default = { "lazydev", "lsp", "path", "snippets", "snippets", "buffer" },
					providers = {
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
