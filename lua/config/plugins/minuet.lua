return {
  "milanglacier/minuet-ai.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("minuet").setup({
      provider = "openai_fim_compatible",
      provider_options = {
        openai_fim_compatible = {
          model = "doubao-seed-2-0-lite-260215",
          end_point = "https://ark.cn-beijing.volces.com/api/v3/fim/completions",
          api_key = "VOLCENGINE_API_KEY",
          name = "VolcEngine",
          stream = true,
          transform = {},
          optional = {
            max_tokens = 256,
            stop = { "\n\n" },
          },
        },
      },
    })
  end,
}
