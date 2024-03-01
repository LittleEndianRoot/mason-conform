local M = {}

---@class MasonConformSettings
local DEFAULT_SETTINGS = {
  -- a list of formatters to automatically install if they're not already installed. example: { "asmfmt", "ast-grep" }
  -- this setting has no relation with the `automatic_installation` setting.
  -- names of formatters should be taken from mason's registry.
  ---@type string[]
  ensure_installed = {},

  -- whether formaters are set up (via conform) should be automatically installed if they're not installed already.
  -- it tries to find the specified formatters in mason's registry to proceed with installation.
  -- this setting has no relation with `ensure_installed` setting.
  ---@type boolean
  automatic_installation = true,

  -- disables warning notifications about misconfigurations such as invalid formatter entries and incorrect plugin load order.
  quiet_mode = false,
}

M._DEFAULT_SETTINS = DEFAULT_SETTINGS
M.current = M._DEFAULT_SETTINS

---@param opts MasonConformSettings
function M.set(opts)
  M.current = vim.tbl_deep_extend("force", M.current, opts)
end

return M
