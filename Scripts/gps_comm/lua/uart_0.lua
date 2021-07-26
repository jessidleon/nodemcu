local allowed_to_write = true

local function received_data(data)
    local position = {string.find(data, "$GPRMC")}
    if position[1] ~= nil and position[2] == "A" then
        if allowed_to_write then
            allowed_to_write = false

            dofile("log.lua").log(data, position)
            file.close("log.lua")

            dofile("led.lua").blink(1)
            file.close()
        end
    end
end

local function configure_uart()
    local id = 0
    local baud = 9600
    local data_bits = 8
    local parity = uart.PARITY_NONE
    local stop_bits = uart.STOPBITS_1
    local echo = 0
    uart.alt(1)
    uart.setup(id, baud, data_bits, parity, stop_bits, echo)
    uart.on("data", "\r", received_data, 0)
end

configure_uart()

tmr.create():alarm(15000, tmr.ALARM_AUTO, function(t)
    allowed_to_write = true
end)

--local tmr_tmp = tmr.create()
--tmr_tmp:register(100, tmr.ALARM_AUTO, function(t)
--    received_data("$GPRMC,180152.00,A,4113.17156,N,00142.67346,E,0.807,275.57,270521,,,A*6B")
--end)
--tmr_tmp:start()
