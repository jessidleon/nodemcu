#pragma once

#include <string>
#include <map>
#include <vector>
#include <memory>
#include "gpsData.hpp"
#include "accessPoint.hpp"

namespace jlvg {
	class DataParser {
	public:
		static std::ifstream open(const std::string& path);

		static void close(std::ifstream& in);

		static void parse(std::ifstream& in);

		static std::map<jlvg::GPSData, std::vector<jlvg::AccessPointData>> getData();


	private:
		static std::map<jlvg::GPSData, std::vector<jlvg::AccessPointData>> data;

		static jlvg::GPSData parseGPSLine(const std::string& line);

		static std::string searchNextGPSLine(std::ifstream& in);

		static jlvg::AccessPointData parseAPLine(const std::string& line);

		static bool isAPLine(const std::string& line);
	};
}
