local M = {}

M.setup = function()
  local handle = io.popen("git rev-parse --show-toplevel 2>/dev/null")
  if handle == nil then
    return nil
  end
  local git_root = handle:read("*a"):gsub("\n", "")
  handle:close()

  if git_root == "" then
    return
  end

  local config_path = git_root .. "/.vimInit.lua"

  local f = io.open(config_path, "r")
  if f then
    local content = f:read("*all")
    f:close()

    local lines = vim.fn.split(content, "\n")
    for _, line in ipairs(lines) do
      if line:match("^vim%.opt%.") then
        assert(loadstring(line))()
      end
    end
  end
  print("loaded configuration from .vimInit.lua")
end

return M
