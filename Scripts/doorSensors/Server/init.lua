print("3 seconds before wifi config applied")
local function initialize()
	jlvg_wifi = require("jlvg_wifi")
	jlvg_wifi.register_STA_events()
	jlvg_wifi.initialize_as_STA()
	jlvg_wifi = nil
end

tmr.create():alarm(3000, tmr.ALARM_SINGLE, initialize)
