#pragma once

#include <string>
#include <map>

namespace jlvg {
	class GPSData {
	public:
		bool operator<(const GPSData& other) const;

		void setStatus(const std::string& status);

		void setTime(const std::string& time);

		void setLatitude(const std::string& latitude);

		void setNorthSouthIndicator(const std::string& northSouthIndicator);

		void setLongitude(const std::string& longitude);

		void setEastWestIndicator(const std::string& eastWestIndicator);

		void setSpeed(const std::string& speed);

		void setCourse(const std::string& course);

		void setDate(const std::string& date);

		void setMagneticVariation(const std::string& magneticVariation);

		void setMode(const std::string& mode);

		void setChecksum(const std::string& checksum);

		static bool isGPSLine(const std::string& line);

		const std::string get(const std::string& key) const;

	private:
		std::map<std::string, std::string> data{
			{"time",               ""},
			{"status",             ""},
			{"latitude",           ""},
			{"north_or_south",     ""},
			{"longitude",          ""},
			{"east_or_west",       ""},
			{"speed",              ""},
			{"course",             ""},
			{"date",               ""},
			{"magnetic_variation", ""},
			{"mode",               ""},
			{"checksum",           ""}
		};
		static std::map<int, std::string> positionField;
		std::string NONE{"NULL"};
	};
}
