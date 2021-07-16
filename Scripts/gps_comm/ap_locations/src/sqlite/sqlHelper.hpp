#pragma once

#include <vector>
#include "../parser/gpsData.hpp"
#include "../parser/accessPoint.hpp"
#include "../sqlite/sqlite3.h"

namespace jlvg {
	class SqlHelper {
	public:
		static void help(const char** argv, const std::map<jlvg::GPSData, std::vector<jlvg::AccessPointData>>& data);

	private:
		static sqlite3* db;
	};
}