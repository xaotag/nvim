require('telescope').setup {
  defaults = {file_ignore_patterns = {"node_modules", "dist"}},
  pickers = {
    find_files = {find_command = {"fd", "--type", "f", "--strip-cwd-prefix"}}
  }
}
