#include <string>
#include <iostream>
#include "sqlHelper.hpp"

sqlite3* jlvg::SqlHelper::db;

void jlvg::SqlHelper::help(const char** argv, const std::map<jlvg::GPSData, std::vector<jlvg::AccessPointData>>& data) {
	std::cout << argv[1] << std::endl << std::flush;
	auto rc = sqlite3_open(argv[1], &db);
	char* zErrMsg = 0;
	for (const auto& aPair:data) {
		for (const auto& ap:aPair.second) {
			std::string insertStatement{
				"INSERT INTO ap_gps (bssid, ssid, rssid, auth_mode, channel, time,status, latitude, north_or_south,longitude, east_or_west, speed, course,date, magnetic_variation,mode, checksum) values ("};
			insertStatement += ap.get("bssid") + ", " +
												 ap.get("ssid") + ", " +
												 ap.get("rssid") + ", " +
												 ap.get("auth_mode") + ", " +
												 ap.get("channel") + ", " +
				aPair.first.get("time") + ", " +
												 aPair.first.get("status") + ", " +
												 aPair.first.get("latitude") + ", " +
												 aPair.first.get("north_or_south") + ", " +
												 aPair.first.get("longitude") + ", " +
												 aPair.first.get("east_or_west") + ", " +
												 aPair.first.get("speed") + ", " +
				aPair.first.get("course") + ", " +
				aPair.first.get("date") + ", " +
				aPair.first.get("magnetic_variation") + ", " +
				aPair.first.get("mode") + ", " +
				aPair.first.get("checksum") + ");";
			std::cout << insertStatement << std::endl << std::flush;
			rc = sqlite3_exec(db, insertStatement.c_str(), NULL, 0, &zErrMsg);
			if (rc) {
				std::cout << "DB Error: " << sqlite3_errmsg(db) << std::endl << std::flush;
			}
		}
	}
	sqlite3_close(db);
}
