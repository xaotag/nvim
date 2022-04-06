require "nvim-treesitter.configs".setup {
  ensure_installed = "all",
  sync_install = false,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true
  },
	ignore_install = { "phpdoc" },
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil
  },
  autotag = {
    enable = true
  }
}
