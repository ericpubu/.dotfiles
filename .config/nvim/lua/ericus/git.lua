-- DIFFWIEW
local cb = require('diffview.config').diffview_callback

require('diffview').setup {
  diff_binaries = false,    -- Show diffs for binaries
  file_panel = {
    width = 35,
    use_icons = true        -- Requires nvim-web-devicons
  },
  key_bindings = {
    -- The `view` bindings are active in the diff buffers, only when the current
    -- tabpage is a Diffview.
    view = {
      ["<tab>"]     = cb("select_next_entry"),  -- Open the diff for the next file 
      ["<s-tab>"]   = cb("select_prev_entry"),  -- Open the diff for the previous file
      ["<leader>e"] = cb("focus_files"),        -- Bring focus to the files panel
      ["<leader>b"] = cb("toggle_files"),       -- Toggle the files panel.
    },
    file_panel = {
      ["j"]         = cb("next_entry"),         -- Bring the cursor to the next file entry
      ["<down>"]    = cb("next_entry"),
      ["k"]         = cb("prev_entry"),         -- Bring the cursor to the previous file entry.
      ["<up>"]      = cb("prev_entry"),
      ["<cr>"]      = cb("select_entry"),       -- Open the diff for the selected entry.
      ["o"]         = cb("select_entry"),
      ["R"]         = cb("refresh_files"),      -- Update stats and entries in the file list.
      ["<tab>"]     = cb("select_next_entry"),
      ["<s-tab>"]   = cb("select_prev_entry"),
      ["<leader>e"] = cb("focus_files"),
      ["<leader>b"] = cb("toggle_files"),
    }
  }
}

-- Keymaps
local map = require('ericus.vim-utils').mapper

map('n', '<leader>gs', 'G', {noremap = true})
map('n', '<leader>gg', 'Telescope git_status', {noremap = true})
map('n', '<leader>gb', 'Telescope git_branches', {noremap = true})
map('n', '<leader>gd', 'DiffviewOpen', {noremap = true})
map('n', '<leader>gc', 'Git commit', {noremap = true})
map('n', '<leader>ga', 'Git commit --ammend', {noremap = true})