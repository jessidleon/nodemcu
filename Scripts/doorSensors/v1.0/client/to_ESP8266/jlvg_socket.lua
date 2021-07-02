local function socket_connected(socket)
	--print("socket connected ")
	local msg = crypto.encrypt("AES-ECB", "thisIsWh3Ecrypti", "id=first_sensor,data=door_open,chk=1234")
	local hex = encoder.toHex(msg)
	socket:send(hex)
	print("sent in hex: ", hex)
	msg = nil
end

local function socket_sent_data(socket, c)
	--print("message sent. Check the server!")
end

local function socket_received_data(socket, data)
	--print("received from server:", data)
	socket:close()
	wifi.sta.disconnect()
end

local function socket_disconnected(socket, error_code)
	--print("disconnected from server. Reason: " .. error_code)
	socket:connect(80, "192.168.4.1")
end

socket = net.createConnection(net.TCP, 3)
socket:on("connection", socket_connected)
socket:on("sent", socket_sent_data)
socket:on("receive", socket_received_data)
socket:on("disconnection", socket_disconnected)

socket:connect(80, "192.168.4.1")



