-- CC:Tweaked Lua script to parse and download files
local http = require("http")

local function downloadAndInstall(url)
  -- Parse the URL for the actual file link and the destination path
  local sourceUrl, destinationPath = url:match("(.-):(.+)")

  if not sourceUrl or not destinationPath then
    print("Invalid URL format.")
    return
  end

  -- Fetch the file from the URL
  print("Downloading from: " .. sourceUrl)
  local response = http.get(sourceUrl)

  if not response then
    print("Failed to download file.")
    return
  end

  -- Extract filename from the URL
  local filename = sourceUrl:match(".*/(.*)")
  if not filename then
    print("Failed to extract filename.")
    return
  end

  -- Create the target directory if it doesn't exist
  fs.makeDir(destinationPath)

  local filePath = fs.combine(destinationPath, filename)
  local file = fs.open(filePath, "w")
  file.write(response.readAll())
  file.close()
  response.close()

  print("File installed at: " .. filePath)
end

-- Example URL
local exampleUrl = "https://raw.githubusercontent.com/5yf1xed/CC-Tweaked_SSH/refs/heads/main/default/users:/server/config"
downloadAndInstall(exampleUrl)
