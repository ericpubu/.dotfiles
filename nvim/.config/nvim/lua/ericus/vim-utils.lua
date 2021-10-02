-- Useful functions for vim commands
local M = {}

function M.buffer_lua_mapper(mode, key, result)
  vim.api.nvim_buf_set_keymap(0, mode, key, "<cmd>lua " .. result .. "<CR>", { noremap = true, silent = true })
end

function M.buffer_mapper(mode, key, result)
  vim.api.nvim_buf_set_keymap(0, mode, key, "<cmd>" .. result .. "<CR>", { noremap = true, silent = true })
end

function M.lua_mapper(mode, key, result)
  vim.api.nvim_set_keymap(mode, key, "<cmd>lua " .. result .. "<CR>", { noremap = true, silent = true })
end

function M.mapper(mode, key, result)
  vim.api.nvim_set_keymap(mode, key, "<cmd>" .. result .. "<CR>", { noremap = true, silent = true })
end

function M.nvim_exec(txt)
  vim.api.nvim_exec(txt, false)
end

function M.feedkey(key)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), "n", true)
end

function M.delete_buf(bufnr)
  if bufnr ~= nil then
    vim.api.nvim_buf_delete(bufnr, { force = true })
  end
end

function M.split(vertical, bufnr)
  local cmd = vertical and "vsplit" or "split"

  vim.cmd(cmd)
  local win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_buf(win, bufnr)
end

function M.resize(vertical, amount)
  local cmd = vertical and "vertical resize " or "resize"
  cmd = cmd .. amount

  vim.cmd(cmd)
end

return M
