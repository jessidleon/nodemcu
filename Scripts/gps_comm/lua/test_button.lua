local delete_pin = 3
local do_not_execute_pin = 5
local led_pin = 4
continue_execution = true
local function setup_pins()
	gpio.mode(delete_pin, gpio.INPUT)
	gpio.mode(do_not_execute_pin, gpio.INPUT)
	gpio.mode(led_pin, gpio.OUTPUT)
	gpio.write(led_pin, gpio.HIGH)
end

local function test_pin(pin_to_test)
	local pushed = true
	local released = false
	local value = gpio.read(pin_to_test)
	if value == gpio.LOW then
		return pushed
	end
	return released
end

local function do_job()
	local is_pushed = test_pin(delete_pin)
	if is_pushed then
		tmr.create():alarm(2000, tmr.ALARM_SINGLE, function()
			is_pushed = test_pin(delete_pin)
			if is_pushed then
				print("delete_pin is pushed")
				gpio.write(led_pin, gpio.LOW)
				local file_to_remove = "data.txt"
				file.remove(file_to_remove)
				print("removed " .. file_to_remove)
				continue_execution = false
			end
		end)
	else
		print("delete_pin is released")
	end

	is_pushed = test_pin(do_not_execute_pin)
	if is_pushed then
		tmr.create():alarm(1000, tmr.ALARM_SINGLE, function()
			is_pushed = test_pin(do_not_execute_pin)
			if is_pushed then
				gpio.write(led_pin, gpio.LOW)
				dofile("led.lua").loop_blink(250)
				file.close("led.lua")
				print("do_not_execute_pin is pushed")
				continue_execution = false
			end
		end)
	else
		print("do_not_execute_pin is released")
	end
end

setup_pins()
do_job()

