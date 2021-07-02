ap_cfg = {
	ssid = "FirstAccessPoint",
	pwd = "thisisthepassword",
	auth = wifi.WPA2_PSK,
	hidden = false,
	save = false
}

sta_cfg = {
	ssid = "vodafoneBA2776",
	pwd = "Put0sG0b3rn@nt3s",
	auto = true,
	save = false,
}

wifi.eventmon.register(wifi.eventmon.STA_GOT_IP, function(T)
  print("\n\tSTA - GOT IP".."\n\tStation IP: "..T.IP.."\n\tSubnet mask: "..
  T.netmask.."\n\tGateway IP: "..T.gateway)
end)
--[[
wifi.setmode(wifi.SOFTAP)
wifi.ap.config(ap_cfg)
--]]

---[[
wifi.setmode(wifi.STATION)
wifi.sta.config(sta_cfg)
--]]

--[[
srv = net.createServer(net.TCP)
srv:listen(
	80,
	function(conn)
		conn:on(
			"receive",
			function(conn, payload)
				print(payload)
				conn:send("<h1>This is a simple webserver</h1>")
				conn:send("<h2>Hello</h2>")
				conn:send("Hello, Lolin NodeMCU V3.")
			end
		)
	end
)
--]]
