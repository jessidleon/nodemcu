sntp.sync(
	nil,
	function(sec, usec, server, info)
		print("sync", sec, usec, server)
	end,
	function()
		print("failed!")
	end
)
