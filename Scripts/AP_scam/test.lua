wifi.setmode(wifi.SOFTAP)

local ap_config = {
	ssid = "123",
	pwd = "esteesunpassword",
	auth = wifi.WPA_WPA2_PSK,
	save = false
}

wifi.ap.config(ap_config)
