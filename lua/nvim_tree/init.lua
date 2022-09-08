local function custom_callback(callback_name)
  return string.format(":lua require('nvim_tree.treeutils').%s()<CR>",
                       callback_name)
end
require'nvim-tree'.setup { -- BEGIN_DEFAULT_OPTS
  --  renderer = {icons = {glyphs = {git = {untracked = ""}}}},
  view = {
    mappings = {
      list = {
        {key = "<c-f>", cb = custom_callback "launch_find_files"},
        {key = "<c-g>", cb = custom_callback "launch_live_grep"}
      }
    }
  },
  update_focused_file = {enable = true, update_root = true, ignore_list = {}}
} -- END_DEFAULT_OPTS
