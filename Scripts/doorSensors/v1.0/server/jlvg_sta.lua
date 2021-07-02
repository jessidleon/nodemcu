local function connected_to_AP()
	--print("connected to AP")
end

local function disconnected_from_AP(T)
	--print("disconnected from AP")
	if T.reason == 201 then
		local msg = string.format("AP %s not found", T.SSID)
		dofile("jlvg_sta.lua")
		file.close("jlvg_sta.lua")
	end
end

local function auth_mode_changed(T)
	--print("auth mode changed")
	--print("previous mode: " .. T.old_auth_mode .. " current mode: " .. T.new_auth_mode)
end

local function got_ip(T)
	--print(string.format("got ip: %s", T.IP))
	dofile("jlvg_sntp.lua")
	file.close("jlvg_sntp.lua")
end

local function dhcp_timed_out()
	--print("dhcp timed out")
end

wifi.eventmon.register(wifi.eventmon.STA_CONNECTED, connected_to_AP)
wifi.eventmon.register(wifi.eventmon.STA_DISCONNECTED, disconnected_from_AP)
wifi.eventmon.register(wifi.eventmon.STA_AUTHMODE_CHANGE, auth_mode_changed)
wifi.eventmon.register(wifi.eventmon.STA_GOT_IP, got_ip)
wifi.eventmon.register(wifi.eventmon.STA_DHCP_TIMEOUT, dhcp_timed_out)

wifi.setmode(wifi.STATION)

local sta_config = {
	ssid = "vodafoneBA2776",
	pwd = "Put0sG0b3rn@nt3s",
	auto = false,
	save = false
}
wifi.sta.config(sta_config)
wifi.sta.connect()
sta_config = nil