return {
	"xzbdmw/colorful-menu.nvim",
	config = function()
		require("colorful-menu").setup({
			ls = {
				lua_ls = {
					arguments_hl = "@comment",
				},
				gopls = {
					align_type_to_right = true,
					add_colon_before_type = false,
				},
				ts_ls = {
					extra_info_hl = "@comment",
				},
				vtsls = {
					extra_info_hl = "@comment",
				},
				["rust-analyzer"] = {
					extra_info_hl = "@comment",
					align_type_to_right = true,
				},
				clangd = {
					extra_info_hl = "@comment",
					align_type_to_right = true,
					import_dot_hl = "@comment",
				},
				zls = {
					align_type_to_right = true,
				},
				roslyn = {
					extra_info_hl = "@comment",
				},
				basedpyright = {
					extra_info_hl = "@comment",
				},
				fallback = true,
			},
			fallback_highlight = "@variable",
			max_width = 60,
		})
	end,
}
