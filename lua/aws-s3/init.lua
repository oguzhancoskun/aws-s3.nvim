-- init.lua
local s3 = require('aws-s3.s3')

local M = {}

function M.setup(options)
  s3.setup(options)

  vim.api.nvim_create_user_command(
    'S3Create',
    function()
      s3.create()
    end,
    { nargs = 0 }
  )

  vim.api.nvim_create_user_command(
    'S3Update',
    function()
      s3.update()
    end,
    { nargs = 0 }
  )

end

return M

