#pragma once

namespace jlvg {
	class ParserHelper {
	public:
		static std::map<jlvg::GPSData, std::vector<jlvg::AccessPointData>> help(const char** argv);
	};
}