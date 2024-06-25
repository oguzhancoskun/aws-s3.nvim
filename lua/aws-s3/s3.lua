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

local function s3_create_bucket(bucket_name, profile)
  local command = string.format("aws s3api create-bucket --bucket %s --profile %s > /dev/null 2>&1 ; echo $?",
 bucket_name, profile)
  local success = os.execute(command)
  if success then
    send_notification("Bucket successfully created: " .. bucket_name, vim.log.levels.INFO)
  else
    send_notification("Failed to create bucket: " .. bucket_name, vim.log.levels.ERROR)
  end
end

local function s3_check_bucket_exists(bucket_name, profile)
  local command = string.format("aws s3api head-bucket --bucket %s --profile %s > /dev/null 2>&1 ; echo $?",
 bucket_name, profile)
  local success = os.execute(command)
  return success
end

local function s3_create(remote_path, profile)

  local bucket_name = remote_path:match("([^/]+)")

  if not s3_check_bucket_exists(bucket_name, profile) then
    vim.ui.input({prompt = 'Bucket does not exist. Do you want to create it? (y/n): '}, function(response)
      if response == 'y' then
        s3_create_bucket(bucket_name, profile)
      else
        send_notification("Bucket does not exist. Aborting upload.", vim.log.levels.ERROR)
        return
      end
    end)

  local file_path = get_active_file_path()
  local command = string.format("aws s3 cp %s s3://%s --profile %s"
  file_path, remote_path, profile)
  local success = os.execute(command)
  if success then
    send_notification("File successfully uploaded to S3: " .. remote_path, vim.log.levels.INFO)
  else
    send_notification("Failed to upload file to S3: " .. remote_path, vim.log.levels.ERROR)
  end
end

local function create()
  vim.ui.input({prompt = 'Enter Remote Path: '}, function(remote_path)
    if not remote_path or remote_path == '' then
      send_notification("Remote path is required.", vim.log.levels.ERROR)
      return
    end

    vim.ui.input({prompt = 'Enter Profile: '}, function(profile)
      if not profile or profile == '' then
        send_notification("Profile is required.", vim.log.levels.ERROR)
        return
      end

      s3_create(remote_path, profile)
    end)
  end)
end

M.create = create

return M

