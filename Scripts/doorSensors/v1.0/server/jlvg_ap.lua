local function client_connected(T)
	local msg = "[connected] " .. T.MAC .. " with AID: " .. T.AID
	--write_log(msg)
	----print(msg)
	msg = nil
end

local function client_disconnected(T)
	local msg = "[disconnected] " .. T.MAC .. " with AID: " .. T.AID
	--write_log(msg)
	----print(msg)
	msg = nil
end

local function probe_request_received(T)
	local msg = "[probe request] " .. T.MAC .. " RSSI: " .. T.RSSI
	----print(msg)
	----write_log(msg)
	msg = nil
end

wifi.eventmon.register(wifi.eventmon.AP_STACONNECTED, client_connected)
wifi.eventmon.register(wifi.eventmon.AP_STADISCONNECTED, client_disconnected)
wifi.eventmon.register(wifi.eventmon.AP_PROBEREQRECVED, probe_request_received)

wifi.setmode(wifi.SOFTAP)

local ap_config = {
	ssid = "door_server",
	pwd = "ThisIsMean!ngl3ssThere!",
	auth = wifi.WPA2_PSK,
	hidden = false,
	save = false
}
wifi.ap.config(ap_config)
ap_config = nil

dofile("server.lua")
file.close("server.lua")