
--dir thingies...
local default_dirs = {
    "/server",
    "/server/bin",
    "/server/data",
    "/server/logs",
    "/server/config",
    "/server/tmp",
}
for _, dir in ipairs(default_dirs) do
    fs.makeDir(dir)
end

--default files
local url = ""
local response = http.get(url)

if response then
    local body = response.readAll()
    response.close()

    for line in body:gmatch("[^]+") do
        local rawUrl, destination = line:match("([^:]+):(.+)")
        
        if rawUrl and destination then
            print("Downloading: " .. rawUrl)
            local fileResponse = http.get(rawUrl)
            
            if fileResponse then
                local fileContent = fileResponse.readAll()
                fileResponse.close()
                
                local file = fs.open(destination, "w")
                file.write(fileContent)
                file.close()
                print("Downloaded: " .. destination)
            else
                print("Failed to download: " .. rawUrl)
            end
        else
            print("Invalid format in line: " .. line)
        end
    end
else
    print("Failed to fetch URL: " .. url)
end
