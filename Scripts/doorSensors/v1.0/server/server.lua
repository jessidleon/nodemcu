local function client_connected_to_server(socket)
	--print("client connected to server")
	--print("----\n")
end

local function client_reconnected_to_server(socket, error_code)
	--print("client reconnected to server")
	--print(error_code)
	--print("----\n")
end

local function client_disconnected_from_server(socket, error_code)
	--print("client disconnected to server")
	--print(error_code)
	--print("----\n")
end

local function received_from_client(socket, request)
	--print("request:\n", request)
	local encrypted_string = encoder.fromHex(request)
	local decrypted_string = crypto.decrypt("AES-ECB", "thisIsWh3Ecrypti", encrypted_string)
	local fields = {}
	for field in string.gmatch(decrypted_string, "[^,]+") do
		local start_end = { string.find(field, "=") }
		fields[string.sub(field, 1, start_end[1] - 1)] = string.sub(field, start_end[2] + 1)
	end
	
	print("#fields: ", #fields)
	print("id: ", fields["id"])
	print("data: ", fields["data"])
	print("chk: ", fields["chk"])

	fields = nil
	encrypted_string = nil
	decrypted_string = nil
	socket:send("ACK")
	--inform_to_rockpi(fields)
end

local function sent_to_client(socket)
	--print("sent to client")
	socket:close()
	--print("now the socket is closed")
end

local function respond_to_successful_connection(socket)
	socket:on("connection", client_connected_to_server)
	socket:on("reconnection", client_reconnected_to_server)
	socket:on("disconnection", client_disconnected_from_server)
	socket:on("receive", received_from_client)
	socket:on("sent", sent_to_client)
end

local client_timeout = 3
server = net.createServer(net.TCP, client_timeout)
if server then
	server:listen(80, respond_to_successful_connection)
end


