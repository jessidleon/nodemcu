local function connected_to_AP(T)
	local msg = "[" .. tmr.now() .. "] [connected to AP] " .. T.SSID .. " " .. T.BSSID .. " " .. T.channel
	--print(msg)
	--write_log(msg)
	msg = nil
end

local function disconnected_from_AP(T)
	local msg = "[" .. tmr.now() .. "] [disconnected from AP] " .. T.SSID .. " " .. T.BSSID .. " " .. T.reason
	--write_log(msg)
	--print(msg)
	msg = nil
	wifi.sta.connect()
end

local function auth_mode_changed(T)
	local msg = "[" .. tmr.now() .. "] [auth mode changed] " .. T.old_auth_mode .. " " .. T.new_auth_mode
	--print(msg)
	--write_log(msg)
	msg = nil
end

local function ip_obtained(T)
	local msg = "[" .. tmr.now() .. "] [IP obtained] " .. T.IP .. " " .. T.netmask .. " " .. T.gateway
	--write_log(msg)
	--print(msg)
	msg = nil

	dofile("jlvg_socket.lua")
	file.close("jlvg_socket.lua")
end

local function dhcp_timed_out()
	local msg = "[" .. tmr.now() .. "] [DHCP] timed out"
	--print(msg)
	--write_log(msg)
	msg = nil
end

wifi.eventmon.register(wifi.eventmon.STA_CONNECTED, connected_to_AP)
wifi.eventmon.register(wifi.eventmon.STA_DISCONNECTED, disconnected_from_AP)
wifi.eventmon.register(wifi.eventmon.STA_AUTHMODE_CHANGE, auth_mode_changed)
wifi.eventmon.register(wifi.eventmon.STA_GOT_IP, ip_obtained)
wifi.eventmon.register(wifi.eventmon.STA_DHCP_TIMEOUT, dhcp_timed_out)

wifi.setmode(wifi.STATION)
local sta_config = {
	ssid = "door_server",
	pwd = "ThisIsMean!ngl3ssThere!",
	auto = true,
	save = false
}
wifi.sta.config(sta_config)
