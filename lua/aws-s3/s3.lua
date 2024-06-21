-- s3.lua
local M = {}

local use_fidget = false

function M.setup(options)
  if options and options.fidget then
    use_fidget = true
  end
end

local function send_notification(message, level)
  if use_fidget then
    local fidget = require('fidget')
    if fidget and fidget.notify then
      fidget.notify(message, level)
    else
      vim.notify(message, level)
    end
  else
    vim.notify(message, level)
  end
end

local function get_active_file_path()
  return vim.fn.expand('%:p')
end

local function s3_create(remote_path, profile)
  local file_path = get_active_file_path()
  local command = string.format("aws s3 cp %s s3://%s --profile %s", file_path, remote_path, profile)
  local success = os.execute(command)
  if success then
    send_notification("File successfully uploaded to S3: " .. remote_path, vim.log.levels.INFO)
  else
    send_notification("Failed to upload file to S3: " .. remote_path, vim.log.levels.ERROR)
  end
end

M.s3_create = s3_create

return M

