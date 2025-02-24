return {
	servers = {
		gopls = {},
		pyright = {},
		emmet_language_server = {},
		cssmodules_ls = {},
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
						implementationsCodeLens = {
							enable = true,
						},
						referencesCodeLens = {
							enable = true,
							showOnAllFunctions = false,
						},
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
}
