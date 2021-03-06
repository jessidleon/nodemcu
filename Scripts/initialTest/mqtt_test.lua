-- init mqtt client without logins, keepalive timer 120s
m = mqtt.Client("clientid", 120)

-- init mqtt client with logins, keepalive timer 120sec
--m = mqtt.Client("clientid", 120, "user", "password")

-- setup Last Will and Testament (optional)
-- Broker will publish a message with qos = 0, retain = 0, data = "offline"
-- to topic "/lwt" if client don't send keepalive packet
m:lwt("/lwt", "offline", 0, 0)

m:on(
  "offline",
  function(client)
    print("offline")
  end
)

-- on publish message receive event
m:on(
  "message",
  function(client, topic, data)
    print(topic .. ":")
    if data ~= nil then
      print(data)
    end
  end
)

-- on publish overflow receive event
m:on(
  "overflow",
  function(client, topic, data)
    print(topic .. " partial overflowed message: " .. data)
  end
)

-- for TLS: m:connect("192.168.11.118", secure-port, 1)
m:connect(
  "192.168.0.19",
  1883,
  false,
  function(client)
    print("connected")
    -- Calling subscribe/publish only makes sense once the connection
    -- was successfully established. You can do that either here in the
    -- 'connect' callback or you need to otherwise make sure the
    -- connection was established (e.g. tracking connection status or in
    -- m:on("connect", function)).

    -- subscribe topic with qos = 0
    --client:subscribe("/topic", 0, function(client) print("subscribe success") end)
    -- publish a message with data = hello, QoS = 0, retain = 0

    local mytimer = tmr.create()
    mytimer:register(
      1000,
      tmr.ALARM_AUTO,
      function(t)
        tm = rtctime.epoch2cal(rtctime.get() + 7200)
        date =
          string.format(
          "%02d/%02d/%04d %02d:%02d:%02d",
          tm["day"],
          tm["mon"],
          tm["year"],
          tm["hour"],
          tm["min"],
          tm["sec"]
        )
        print(date)
        client:publish(
          "/topic",
          date,
          0,
          0,
          function(client)
            print("sent")
          end
        )
      end
    )
    mytimer:start()
  end,
  function(client, reason)
    print("Connection failed reason: " .. reason)
  end
)

m:close()
-- you can call m:connect again after the offline callback fires
