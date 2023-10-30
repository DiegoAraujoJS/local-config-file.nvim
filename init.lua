local M = {}

M.setup = function()
  require("my-plugin.nvim.main").load_local_config()
end

return M
