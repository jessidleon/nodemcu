print("about to start comm in 5 secs")
mytimer = tmr.create()
mytimer:register(3000, tmr.ALARM_SINGLE, function()
	dofile("test_button.lua")
	file.close("test_button.lua")
end)
mytimer:start()