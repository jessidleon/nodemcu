print("3 seconds before wifi config applied")
local function initialize()
	dofile("jlvg_sta.lua")
	file.close()
end

tmr.create():alarm(3000, tmr.ALARM_SINGLE, initialize)
