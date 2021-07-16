local function do_initialization_blink()
	local led_pin = 4
	gpio.write(led_pin, gpio.HIGH)
	gpio.mode(led_pin, gpio.OUTPUT)

	for i = 1, 10 do
		gpio.write(led_pin, gpio.LOW)
		tmr.delay(50000)
		gpio.write(led_pin, gpio.HIGH)
		tmr.delay(50000)
	end
end

local function blink(msec)
	local led_pin = 4
	gpio.write(led_pin, gpio.LOW)
	tmr.create():alarm(msec, tmr.ALARM_SINGLE, function()
		gpio.write(led_pin, gpio.HIGH)
	end)
end

local function loop_blink(msec)
	tmr.create():alarm(2* msec, tmr.ALARM_AUTO, function()
		blink(msec)
	end)
end

return {
	do_initialization_blink = do_initialization_blink,
	blink = blink,
	loop_blink = loop_blink
}
