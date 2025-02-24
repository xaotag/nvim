return {
	"Kurama622/llm.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
	cmd = { "LLMSessionToggle", "LLMSelectedTextHandler", "LLMAppHandler" },
	config = function()
		require("llm").setup({
			app_handler = {
				Completion = {
					handler = require("llm.tools").completion_handler,
					opts = {
						url = "https://api.siliconflow.cn/v1/completions",
						model = "Qwen/Qwen2.5-Coder-32B-Instruct",
						api_type = "openai",
						fetch_key = function()
							return os.getenv("LLM_KEY")
						end,
						n_completions = 3,
						context_window = 512,
						max_tokens = 512,
						default_filetype_enabled = true,
						auto_trigger = true,
						only_trigger_by_keywords = true,
						style = "blink.cmp", -- nvim-cmp or blink.cmp
						timeout = 10, -- max request time
						throttle = 1000,
						debounce = 400,
					},
				},
			},
		})
	end,
}
