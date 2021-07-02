tmr.create():alarm(10000, tmr.ALARM_SINGLE, function()
    dofile("log.lua").debug("started")
    dofile("led.lua").do_initialization_blink()
    file.close("led.lua")
		
    dofile("test_button.lua")
    file.close("test_button.lua")

    dofile("uart_0.lua")
    file.close("uart_0.lua")
end)
