local function blink()
	if off_timer ~= nil then
		return
	end

	gpio.mode(4, gpio.OUTPUT)
	gpio.write(4, gpio.LOW)
	off_timer = tmr.create()
	off_timer:register(
		5,
		tmr.ALARM_SINGLE,
		function(t)
			gpio.write(4, gpio.HIGH)
			t:unregister()
			off_timer = nil
		end
	)
	off_timer:start()
end

return {blink = blink}
