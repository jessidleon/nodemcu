tx = 2
rx = 3

gpio.mode(tx, gpio.INPUT)
gpio.mode(rx, gpio.INPUT)


s = softuart.setup(9600, tx,rx)
-- Set callback to run when 10 characters show up in the buffer
s:on("data", "\r", function(data)
position = {string.find(data,"$GPRMC")}

if position[1] ~= nil then
print(string.sub(data,position[1]))
end
   -- file.open("test.serial", "a+")
   -- file.writeline(data)
   -- file.close("test.serial")
end)
