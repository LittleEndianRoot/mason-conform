local registry = require("mason-registry")
local conform = require("conform")
local mapping = require("mason-conform.mapping")
local settings = require("mason-conform.settings")

--@return unknown_formatters string[]
local function auto_install()
  local unknown_formatters = {}

  for _, formatter_names in pairs(conform.formatters_by_ft) do
    for _, formatter_name in pairs(formatter_names) do
      local mason_formatter_identifier = mapping.conform_to_package[formatter_name]

      if mason_formatter_identifier then
        require("mason-conform.install").try_install(mason_formatter_identifier)
      end
        table.insert(unknown_formatters, formatter_name)
    end
  end

  if #unknown_formatters > 0 and not settings.current.quiet_mode then
    vim.notify(
      ("Formatters [%s] are absent in the mason's registry. Please install them manually and remove from configuration.")
      :format(table.concat(unknown_formatters, ", ")),
      vim.log.levels.WARN)
  end
end

if registry.refresh then
  return function()
    registry.refresh(vim.schedule_wrap(auto_install))
  end
else
  return auto_install
end
