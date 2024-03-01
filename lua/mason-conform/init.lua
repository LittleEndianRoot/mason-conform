local platform = require("mason-core.platform")
local settings = require("mason-conform.settings")

local M = {}

local function check_and_notify_bad_setup_order()
  local mason_ok, mason = pcall(require, "mason")
  local conform_ok, conform = pcall(require, "conform")
  local is_bad_order = not mason_ok or mason.has_setup == false or not conform_ok
  local impacts_functionality = not mason_ok or #settings.current.ensure_installed > 0

  if is_bad_order and impacts_functionality and not settings.current.quiet_mode then
    vim.notify(
      "mason.nvim has not been set up. Make sure to set up 'mason' and 'conform' before 'mason-conform'. :h mason-conform-quickstart",
      vim.log.levels.WARN
    )
  end
end

---@param config MasonNvimConfromSettings | nil
function M.setup(config)
  if config then
    settings.set(config)
  end

  check_and_notify_bad_setup_order()

  if not platform.is_headless and #settings.current.ensure_installed > 0 then
    require("mason-conform.ensure_install")()
  end

  if settings.current.automatic_installation then
    require("mason-conform.auto_install")()
  end
end

return M
