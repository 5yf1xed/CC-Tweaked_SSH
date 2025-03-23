local function downloadFile(URL,dest)
  local response = http.get(url)
  local success = shell.run("wget", url, dest)
end
downloadFile("https://github.com/5yf1xed/CC-Tweaked_SSH/raw/refs/heads/main/default/users.dat",".")
