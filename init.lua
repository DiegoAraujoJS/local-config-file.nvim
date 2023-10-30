function LoadLocalConfig()
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
        print(line)
        assert(loadstring(line))()
      end
    end
  end
end

-- Call the function when Neovim starts
vim.cmd("autocmd VimEnter * lua LoadLocalConfig()")
