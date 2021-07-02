local function offset_to_spain()
	--print("offset_to_spain")
	sec, _, _ = rtctime.get()
	sec = sec + 7200
	rtctime.set(sec)
	--print(rtctime.get())
	dofile("jlvg_ap.lua")
	file.close("jlvg_ap.lua")
end

--print("jlvg_sntp.lua")
local server_ip = nil
local err_callback = nil
local autorepeat = nil
sntp.sync(server_ip, offset_to_spain, err_callback, autorepeat)