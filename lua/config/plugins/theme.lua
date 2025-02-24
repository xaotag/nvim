return {
	"olimorris/onedarkpro.nvim",
	priority = 1000, -- Ensure it loads first
	config = function()
		vim.cmd("colorscheme onedark")
		-- 通用透明背景设置（适用于浮动窗口、弹出菜单等）
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
		vim.api.nvim_set_hl(0, "Pmenu", { bg = "none" })
		vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none", fg = "#7aa2f7" })
		vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
	end,
}
