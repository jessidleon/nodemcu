local function start()

    print("serial communication with gps started")
    local tx = 2
    local rx = 3

    gpio.mode(tx, gpio.INPUT)
    gpio.mode(rx, gpio.INPUT)

    
    s = softuart.setup(9600, tx, rx)
    s:on("data", "\r", function(data)
        ---[[
        --position = {string.find(data, "$GPRMC")}
         position = {string.find(data, "$GPGGA")}
        if position[1] ~= nil then
            print(string.sub(data, position[1]))
        end
        --]]
    end)

    

end

--node.setcpufreq(node.CPU160MHZ)
print("about to start comm in 5 secs")
mytimer = tmr.create()
mytimer:register(5000, tmr.ALARM_SINGLE, start)
mytimer:start()