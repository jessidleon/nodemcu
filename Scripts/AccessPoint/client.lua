---[[
sta_cfg = {
    ssid = "vodafoneBA2776",
    pwd = "Put0sG0b3rn@nt3s",
    auto = true,
    save = false,
}
wifi.setmode(wifi.STATION)
wifi.sta.config(sta_cfg)

wifi.eventmon.register(wifi.eventmon.STA_GOT_IP, function(T)
  print("\n\tSTA - GOT IP".."\n\tStation IP: "..T.IP.."\n\tSubnet mask: "..
  T.netmask.."\n\tGateway IP: "..T.gateway)
end)

--]]

--[[
socket = net.createConnection()
socket = tls.createConnection()
socket:connect(80,"192.168.0.14")
socket:on("connection", function (sck,c)
socket:send("ledbi=ON")
end)
socket:on("disconnection", function(sck,c)
    print("disconnected")
end
)
]]


--socket:send("ledbi=Blink")
