-- print AP list in old format (format not defined)
function listap(t)
    for k,v in pairs(t) do
        print(k.." : "..v)
    end
end
wifi.sta.getap(listap)

-- Print AP list that is easier to read
function listap(t) -- (SSID : Authmode, RSSI, BSSID, Channel)
    print("\n"..string.format("%32s","SSID").."\tBSSID\t\t\t\t  RSSI\t\tAUTHMODE\tCHANNEL")
    for ssid,v in pairs(t) do
        local authmode, rssi, bssid, channel = string.match(v, "([^,]+),([^,]+),([^,]+),([^,]+)")
        print(string.format("%32s",ssid).."\t"..bssid.."\t  "..rssi.."\t\t"..authmode.."\t\t\t"..channel)
    end
end
wifi.sta.getap(listap)

-- print AP list in new format
function listap(t)
    for k,v in pairs(t) do
        print(k.." : "..v)
    end
end
wifi.sta.getap(1, listap)

-- Print AP list that is easier to read
function listap(t) -- (SSID : Authmode, RSSI, BSSID, Channel)
    print("\n\t\t\tSSID\t\t\t\t\tBSSID\t\t\t  RSSI\t\tAUTHMODE\t\tCHANNEL")
    for bssid,v in pairs(t) do
        local ssid, rssi, authmode, channel = string.match(v, "([^,]+),([^,]+),([^,]+),([^,]*)")
        print(string.format("%32s",ssid).."\t"..bssid.."\t  "..rssi.."\t\t"..authmode.."\t\t\t"..channel)
    end
end
wifi.sta.getap(1, listap)

--check for specific AP
function listap(t)
    print("\n\t\t\tSSID\t\t\t\t\tBSSID\t\t\t  RSSI\t\tAUTHMODE\t\tCHANNEL")
    for bssid,v in pairs(t) do
        local ssid, rssi, authmode, channel = string.match(v, "([^,]+),([^,]+),([^,]+),([^,]*)")
        print(string.format("%32s",ssid).."\t"..bssid.."\t  "..rssi.."\t\t"..authmode.."\t\t\t"..channel)
    end
end
scan_cfg = {}
scan_cfg.ssid = "myssid"
scan_cfg.bssid = "AA:AA:AA:AA:AA:AA"
scan_cfg.channel = 0
scan_cfg.show_hidden = 1
wifi.sta.getap(scan_cfg, 1, listap)

--get RSSI for currently configured AP
function listap(t)
    for bssid,v in pairs(t) do
        local ssid, rssi, authmode, channel = string.match(v, "([^,]+),([^,]+),([^,]+),([^,]*)")
        print("CURRENT RSSI IS: "..rssi)
    end
end
ssid, tmp, bssid_set, bssid=wifi.sta.getconfig()

scan_cfg = {}
scan_cfg.ssid = ssid
if bssid_set == 1 then scan_cfg.bssid = bssid else scan_cfg.bssid = nil end
scan_cfg.channel = wifi.getchannel()
scan_cfg.show_hidden = 0
ssid, tmp, bssid_set, bssid=nil, nil, nil, nil
wifi.sta.getap(scan_cfg, 1, listap)
