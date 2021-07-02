print("jlvg_wifi.lua")
local function write_log(msg)
	local write_logger = require "logger"
	sec, usec, _ = rtctime.get()
	if usec == 0 then
		time = tmr.now()
	else
		tm = rtctime.epoch2cal(sec,usec)
		time = string.format("%02d/%02d/%02d %02d:%02d:%02d", tm["day"], tm["mon"], tm["year"], tm["hour"], tm["min"], tm["sec"])
	end
	write_logger.log("[" .. time .. "]" .. msg)
	write_logger = nil
	msg = nil

	local jlvg_gpio = require "jlvg_gpio"
	jlvg_gpio.blink()
	jlvg_gpio = nil
end

local function client_connected(T)
	local msg = "[connected] " .. T.MAC .. " with AID: " .. T.AID
	write_log(msg)
	msg = nil
end

local function client_disconnected(T)
	local msg = "[disconnected] " .. T.MAC .. " with AID: " .. T.AID
	write_log(msg)
	msg = nil
end

local function probe_request_received(T)
	local msg = "[probe request] " .. T.MAC .. " RSSI: " .. T.RSSI
	write_log(msg)
	msg = nil
end

local function register_AP_events()
	wifi.eventmon.register(wifi.eventmon.AP_STACONNECTED, client_connected)
	wifi.eventmon.register(wifi.eventmon.AP_STADISCONNECTED, client_disconnected)
	wifi.eventmon.register(wifi.eventmon.AP_PROBEREQRECVED, probe_request_received)
end

local function initialize_as_AP()
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
end

local function connected_to_AP()
	print("connected to AP")
end

local function configure_as_AP()
	wifi.sta.clearconfig()
	wifi.eventmon.register(wifi.eventmon.STA_CONNECTED, connected_to_AP)
	wifi.eventmon.register(wifi.eventmon.STA_DISCONNECTED, disconnected_from_AP)
	wifi.eventmon.register(wifi.eventmon.STA_AUTHMODE_CHANGE, auth_mode_changed)
	wifi.eventmon.register(wifi.eventmon.STA_GOT_IP, got_ip)
	wifi.eventmon.register(wifi.eventmon.STA_DHCP_TIMEOUT, dhcp_timed_out)
	register_AP_events()
	initialize_as_AP()

	print("heap: ", node.heap())
	dofile("server.lua")
	file.close("server.lua")
end

local disconnections_counter = 0
local function disconnected_from_AP()
	disconnections_counter = disconnections_counter + 1
	print("disconnections_counter: ", disconnections_counter)
	if (disconnections_counter >= 2) then
		configure_as_AP()
	end
	print("disconnected from server")
end

local function auth_mode_changed()
	print("auth mode changed")
end

local function offset_to_spain()
	print("offset_to_spain")
	sec, _, _ = rtctime.get()
	sec = sec + 7200
	rtctime.set(sec)
	write_log("Started")
	msg = nil
	configure_as_AP()
end

local function got_ip()
	print("got ip")
	local server_ip = nil
	local err_callback = nil
	local autorepeat = nil
	sntp.sync(server_ip, offset_to_spain, err_callback, autorepeat)
end

local function dhcp_timed_out()
	print("dhcp timed out")
end

local function register_STA_events()
	wifi.eventmon.register(wifi.eventmon.STA_CONNECTED, connected_to_AP)
	wifi.eventmon.register(wifi.eventmon.STA_DISCONNECTED, disconnected_from_AP)
	wifi.eventmon.register(wifi.eventmon.STA_AUTHMODE_CHANGE, auth_mode_changed)
	wifi.eventmon.register(wifi.eventmon.STA_GOT_IP, got_ip)
	wifi.eventmon.register(wifi.eventmon.STA_DHCP_TIMEOUT, dhcp_timed_out)
end

local function initialize_as_STA()
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
end

return {
	register_STA_events = register_STA_events,
	initialize_as_STA = initialize_as_STA,
	register_AP_events = register_AP_events,
	initialize_as_AP = initialize_as_AP
}
