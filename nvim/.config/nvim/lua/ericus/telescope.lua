local themes = require "telescope.themes"

require("telescope").setup {
  defaults = {
    -- prompt_prefix = "❯ ",
    prompt_prefix = "🔍",
    layout_strategy = "horizontal",
    layout_config = {
      width = 0.95,
      height = 0.85,
      prompt_position = "top",

      horizontal = {
        preview_width = function(_, cols, _)
          if cols > 200 then
            return math.floor(cols * 0.4)
          else
            return math.floor(cols * 0.6)
          end
        end,
      },

      vertical = {
        width = 0.9,
        height = 0.95,
        preview_height = 0.5,
      },

      flex = {
        horizontal = {
          preview_width = 0.9,
        },
      },
    },
    file_ignore_patterns = { "node_modules/", "deps/", ".git/" },
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--hidden",
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
  },
}

-- Faster fuzzy
require("telescope").load_extension "fzf"
-- DAP extension
require("telescope").load_extension "dap"
-- Sessions
require("telescope").load_extension "sessions"

-- Keymaps
local map = require("ericus.vim-utils").mapper
local lua_map = require("ericus.vim-utils").lua_mapper

lua_map("n", "<leader>fd", "require('ericus.telescope').fd()")
lua_map("n", "<leader>ff", "require('ericus.telescope').search_files()")
lua_map("n", "<leader>fi", "require('ericus.telescope').search_all_files()")
lua_map("n", "<leader>ft", "require('ericus.telescope').search_only_certain_files()")
lua_map("n", "<leader>fg", "require('ericus.telescope').live_grep()")
lua_map("n", "<leader>fw", "require('telescope.builtin').grep_string()")
lua_map("n", "<leader>f/", "require('ericus.telescope').grep_last_search()")
lua_map("n", "<leader>fp", "require('ericus.telescope').grep_prompt()")
lua_map("n", "<leader>f.", "require('ericus.telescope').file_tree()")
map("n", "<leader>fb", "Telescope buffers")
map("n", "<leader>fh", "Telescope help_tags")
map("n", "<leader>ts", "Telescope treesitter")
map("n", "<leader>fq", "Telescope quickfix")
map("n", "<leader>th", "Telescope colorscheme")
map("n", "<leader>fs", "Telescope sessions")

local M = {}

function M.fd()
  local opts = themes.get_ivy { hidden = true }
  require("telescope.builtin").fd(opts)
end

function M.search_files()
  require("telescope.builtin").find_files {
    find_command = { "rg", "--hidden", "--files" },
  }
end

function M.search_all_files()
  require("telescope.builtin").find_files {
    find_command = { "rg", "--no-ignore", "--hidden", "--files" },
  }
end

function M.search_only_certain_files()
  require("telescope.builtin").find_files {
    find_command = {
      "rg",
      "--files",
      "--hidden",
      "--type",
      vim.fn.input "Type: ",
    },
  }
end

function M.live_grep()
  require("telescope.builtin").live_grep {
    previewer = false,
    fzf_separator = "|>",
  }
end

function M.file_tree()
  local opts = themes.get_ivy { hidden = true }
  require("telescope.builtin").file_browser(opts)
end

function M.grep_last_search(opts)
  opts = opts or {}

  -- \<getreg\>\C
  -- -> Subs out the search things
  local register = vim.fn.getreg("/"):gsub("\\<", ""):gsub("\\>", ""):gsub("\\C", "")

  opts.path_display = { "shorten" }
  opts.word_match = "-w"
  opts.search = register

  require("telescope.builtin").grep_string(opts)
end

function M.grep_prompt()
  require("telescope.builtin").grep_string {
    path_display = { "shorten" },
    search = vim.fn.input "Grep String > ",
  }
end

return M