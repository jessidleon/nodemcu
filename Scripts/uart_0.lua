id = 0
baud = 9600
databits = 8
parity = uart.PARITY_NONE
stopbits = 1
echo = 0

uart.alt(1)
uart.setup(id, baud, databits, parity, stopbits, echo)

---[[
function do_echo(data)
    file.open("gps", "a+")
    file.write(data)
    file.close()
end

uart.on("data", 1 , do_echo, 0)
--]]




--[[
mytimer = tmr.create()
mytimer:register(100, tmr.ALARM_AUTO, function (t) 
uart:write(id, "hola")
--print("hola")
end)
mytimer:start()
--]]