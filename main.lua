local function downloadAndInstallList(url)
  -- Download the list file using wget
  print("Fetching file list from: " .. url)
  local listFile = "temp.txt"
  local success = shell.run("wget", url, listFile)

  if not success then
    print("Failed to download the file list.")
    return
  end

  -- Read the file containing URL:FilePath pairs
  local file = fs.open(listFile, "r")
  if not file then
    print("Failed to open the file list.")
    return
  end

  print("Processing file list...")
  while true do
    local line = file.readLine()
    if not line then break end

    -- Parse URL and file path
    local sourceUrl, destinationPath = line:match("(.-):(.+)")
    if not sourceUrl or not destinationPath then
      print("Invalid line format: " .. (line or "nil"))
    else
      print("Downloading from: " .. sourceUrl)

      -- Ensure the directory exists
      fs.makeDir(fs.getDir(destinationPath))

      -- Download the file using wget
      local result = shell.run("wget", sourceUrl, destinationPath)

      if result then
        print("Successfully installed to: " .. destinationPath)
      else
        print("Failed to download: " .. sourceUrl)
      end
    end
  end

  file.close()
  fs.delete(listFile) -- Clean up
end

-- Example usage
local fileListUrl = "https://github.com/5yf1xed/CC-Tweaked_SSH/raw/refs/heads/main/default-files"
downloadAndInstallList(fileListUrl)
