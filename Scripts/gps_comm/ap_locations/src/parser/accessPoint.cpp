#include <iostream>
#include "accessPoint.hpp"

void jlvg::AccessPointData::set(const std::string& key, const std::string& value) {
	if (data.find(key) == data.end()) {
		std::cout << "key " << key << " does not exist" << std::endl << std::flush;
		return;
	}
	data.at(key) = value;
}

const std::string jlvg::AccessPointData::get(const std::string& key) const {
	if (data.contains(key)) {
		return "'" + data.at(key) + "'";
	}
	return NONE;
}
