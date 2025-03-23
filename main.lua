local function downloadFile(URL, dest)
  local success = shell.run("wget", URL, dest)
  if not success then
    print("Failed to download the file.")
  else
    print("Download successful!")
  end
end

downloadFile("https://github.com/5yf1xed/CC-Tweaked_SSH/raw/refs/heads/main/default/users.dat", "users.dat")
