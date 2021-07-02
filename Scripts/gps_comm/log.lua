local function log(data, position)
    local function listap(info)
        file.open("data.txt", "a+")
        file.writeline(string.sub(data, position[1]))
        for k, v in pairs(info) do
            file.writeline(k .. "," .. v)
        end
        file.close()
    end

    scan_config = {
        show_hidden = 1
    }
    wifi.setmode(wifi.STATION)
    wifi.sta.getap(scan_config, 1, listap)
end

local function debug(message)
    file.open("data.txt", "a+")
    file.writeline(message)
    file.close()
end

return {
    log = log,
    debug = debug
}
