#pragma once

#include <string>
#include <map>

namespace jlvg {
	class AccessPointData {

	public:
		void set(const std::string& key, const std::string& value);

		const std::string get(const std::string& key) const;

	private:
		std::string NONE{"NULL"};
		std::map<std::string, std::string> data{
			{"bssid",     ""},
			{"ssid",      ""},
			{"rssid",     ""},
			{"auth_mode", ""},
			{"channel",   ""}
		};
	};
}
