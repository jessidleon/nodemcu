local input_pin = 3
local led_pin = 4

local function setup_pins()
    gpio.mode(input_pin, gpio.INPUT)
    gpio.mode(led_pin, gpio.OUTPUT)
    gpio.write(led_pin, gpio.HIGH)
end

local function test_pin()
    local pushed = true
    local released = false
    local value = gpio.read(input_pin)
    if value == gpio.LOW then
        return pushed
    end
    return released
end

local function do_job()
    local is_pushed = test_pin()
    if is_pushed then
        local initial_timer = tmr.create():alarm(1000, tmr.ALARM_SINGLE, function()
            is_pushed = test_pin()
            if is_pushed then
                gpio.write(led_pin, gpio.LOW)
                local file_to_remove = "data.txt"
                file.remove(file_to_remove)
                print("removed " .. file_to_remove)
            end
        end)
    end
end

setup_pins()
do_job()
