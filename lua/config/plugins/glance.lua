return {
	"dnlhc/glance.nvim",
	config = function()
		vim.keymap.set("n", "gD", "<CMD>Glance definitions<CR>")
		vim.keymap.set("n", "gR", "<CMD>Glance references<CR>")
		vim.keymap.set("n", "gY", "<CMD>Glance type_definitions<CR>")
		vim.keymap.set("n", "gM", "<CMD>Glance implementations<CR>")
		local glance = require("glance")
		require("glance").setup({
			border = {
				enable = true, -- Show window borders. Only horizontal borders allowed
				top_char = "―",
				bottom_char = "―",
			},
			list = {
				position = "right", -- Position of the list window 'left'|'right'
				width = 0.33, -- 33% width relative to the active window, min 0.1, max 0.5
			},
			theme = { -- This feature might not work properly in nvim-0.7.2
				enable = true, -- Will generate colors for the plugin based on your current colorscheme
				mode = "auto", -- 'brighten'|'darken'|'auto', 'auto' will set mode based on the brightness of your colorscheme
			},
			--给所有的acitons前面加上 glance.	glance.glance.actions.next_location
			mappings = {
				list = {
					["j"] = glance.actions.next, -- Bring the cursor to the next item in the list
					["k"] = glance.actions.previous, -- Bring the cursor to the previous item in the list
					["<Up>"] = glance.actions.previous,
					["<Down>"] = glance.actions.next,
					["<Tab>"] = glance.actions.next_location, -- Bring the cursor to the next location skipping groups in the list
					["<S-Tab>"] = glance.actions.previous_location, -- Bring the cursor to the previous location skipping groups in the list
					["<C-u>"] = glance.actions.preview_scroll_win(5),
					["<C-d>"] = glance.actions.preview_scroll_win(-5),
					["v"] = glance.actions.jump_vsplit,
					["s"] = glance.actions.jump_split,
					["t"] = glance.actions.jump_tab,
					["<CR>"] = glance.actions.jump,
					["o"] = glance.actions.jump,
					["l"] = glance.actions.open_fold,
					["h"] = glance.actions.close_fold,
					["<leader>l"] = glance.actions.enter_win("preview"), -- Focus preview window
					["q"] = glance.actions.close,
					["Q"] = glance.actions.close,
					["<Esc>"] = glance.actions.close,
					["<C-q>"] = glance.actions.quickfix,
					-- ['<Esc>'] = false -- disable a mapping
				},
				preview = {
					["Q"] = glance.actions.close,
					["<Tab>"] = glance.actions.next_location,
					["<S-Tab>"] = glance.actions.previous_location,
					["<leader>l"] = glance.actions.enter_win("list"), -- Focus list window
				},
			},
			hooks = {},
			folds = {
				fold_closed = "",
				fold_open = "",
				folded = true, -- Automatically fold list on startup
			},
			indent_lines = {
				enable = true,
				icon = "│",
			},
			winbar = {
				enable = true, -- Available strating from nvim-0.8+
			},
			use_trouble_qf = false, -- Quickfix action will open trouble.nvim instead of built-in quickfix list window
		})
	end,
}
