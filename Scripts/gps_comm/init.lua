tmr.create():alarm(3000, tmr.ALARM_SINGLE, function()
	dofile("log.lua").debug("started")
	dofile("led.lua").do_initialization_blink()
	file.close("led.lua")

	dofile("test_button.lua")
	file.close("test_button.lua")

	tmr.create():alarm(3000, tmr.ALARM_SINGLE, function()
		print("continue?:", continue_execution)
		if continue_execution then
			dofile("uart_0.lua")
			file.close("uart_0.lua")
		end
	end)
end)