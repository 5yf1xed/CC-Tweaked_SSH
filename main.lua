local function downloadFile(URL, dest)
  if not http then
    print("HTTP API is not enabled.")
    return
  end

  print("Starting download from: " .. URL)
  local request = http.request(URL)

  while true do
    local event, url, response = os.pullEvent()
    
    if event == "http_success" and url == URL then
      local file = fs.open(dest, "w")
      file.write(response.readAll())
      file.close()
      response.close()
      print("Download successful! Saved as: " .. dest)
      break

    elseif event == "http_failure" and url == URL then
      print("Failed to download the file.")
      break
    end
  end
end

downloadFile("https://github.com/5yf1xed/CC-Tweaked_SSH/raw/refs/heads/main/default/users.dat", "users.dat")
