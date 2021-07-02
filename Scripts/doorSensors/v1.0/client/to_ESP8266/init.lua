local function initialize()
	dofile("jlvg_sta.lua")
	file.close("jlvg_sta.lua")
end

--print("5 seconds before wifi config applied")
tmr.create():alarm(5000, tmr.ALARM_SINGLE, initialize)
