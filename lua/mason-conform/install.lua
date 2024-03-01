local registry = require("mason-registry")
local settings = require("mason-conform.settings")

local M = {}

---@param mason_formatter_name string[]
local function resolve_package(mason_formatter_name)
  local Optional = require("mason-core.optional")
  local ok, pkg = pcall(registry.get_package, mason_formatter_name)

  if ok then
    return Optional.of_nilable(pkg)
  end
end

---@param pkg Package
---@param version string?
---@return InstallHandle
local function install_package(pkg, version)
  local formatter_name = pkg.name

  vim.notify(("[mason-conform] installing %s"):format(formatter_name))

  return pkg:install({ version = version }):
    once(
      "closed",
      vim.schedule_wrap(
        function()
          if pkg:is_installed() then
            vim.notify(("[mason-conform] %s was successfully installed"):format(formatter_name))
          else
            vim.notify(
              ("[mason-conform] failed to install %s. Installation logs are available in :Mason and :MasonLog")
              :format(
                formatter_name
              ),
              vim.log.levels.ERROR
            )
          end
      end
      )
    )
end

function M.try_install(mason_formatter_identifier)
  local Package = require("mason-core.package")
  local package_name, version = Package.Parse(mason_formatter_identifier)

  resolve_package(package_name)
    :if_present(
      function(pkg)
        if not pkg:is_installed() then
          install_package(pkg, version)
        end
      end
    )
    :if_not_present(
      function()
        if not settings.current.quiet_mode then
          vim.notify(
            ("[mason-conform] Formatter %q is not a valid entry in ensure_installed. Make sure to only provide valid formatter names.")
            :format(
              package_name
            ),
            vim.log.levels.WARN
          )
        end
      end
    )
end

return M
