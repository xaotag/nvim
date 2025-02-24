return {
	"Kurama622/llm.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
	cmd = { "LLMSesionToggle", "LLMSelectedTextHandler", "LLMAppHandler" },
	lazy = false,
	config = function()
		local tools = require("llm.tools")
		vim.api.nvim_create_autocmd({ "VimEnter" }, {
			callback = function()
				vim.api.nvim_command("LLMAppHandler Completion")
			end,
		})
		require("llm").setup({
			app_handler = {
				Completion = {
					handler = tools.completion_handler,
					opts = {
						-------------------------------------------------
						---                  deepseek
						-------------------------------------------------
						url = "https://api.deepseek.com/beta/completions",
						model = "deepseek-chat",
						api_type = "deepseek",
						fetch_key = function()
							return vim.env.LLM_KEY
						end,
						------------------ end deepseek -----------------

						n_completions = 3,
						context_window = 512,
						max_tokens = 256,

						-- Whether to enable completion of not for filetypes not specifically listed above.
						default_filetype_enabled = true,

						auto_trigger = true,
						-- just trigger by { "@", ".", "(", "[", ":", " " } for `style = "nvim-cmp"`
						only_trigger_by_keywords = true,
						style = "blink.cmp", -- nvim-cmp or blink.cmp
						timeout = 10, -- max request time
						throttle = 1000,
						debounce = 100,
					},
				},
			},
		})
	end,
}
