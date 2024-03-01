local registry = require("mason-registry")
local settings = require("mason-conform.settings")

local function ensure_installed()
  for _, mason_formatter_identifier in ipairs(settings.current.ensure_installed) do
    require("mason-conform.install").try_install(mason_formatter_identifier)
  end
end

if registry.refresh then
  return function()
    registry.refresh(vim.schedule_wrap(ensure_installed))
  end
else
  return ensure_installed
end
