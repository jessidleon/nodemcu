#include <stdexcept>
#include <iostream>
#include "gpsData.hpp"
#include "../tools/stringTools.hpp"



//std::string jlvg::GPSData::createSqlInsertStatement() const {
//	std::string insertStatement{"INSERT INTO gps ("};
//	std::string valuesStatement{") VALUES ("};
//	for (unsigned int index{1}; index <= data.size(); index++) {
//		std::string key{positionField.at(index)};
//		std::string value{data.at(key)};
//		if (value.empty()) {
//			continue;
//		}
//		insertStatement += positionField.at(index) + ", ";
//		valuesStatement += "'" + value + "', ";
//	}
//	insertStatement = insertStatement.substr(0, insertStatement.size() - 2);
//	valuesStatement = valuesStatement.substr(0, valuesStatement.size() - 2);
//	valuesStatement += ")";
//	insertStatement += valuesStatement + ";";
//	return insertStatement;
//}

bool jlvg::GPSData::operator<(const GPSData& other) const {
// I need this map to store elements with repeated key. Should I ask for forgiveness? Perhaps use a multi_map?
	return true;
}

const std::string jlvg::GPSData::get(const std::string& key) const {
	if (data.find(key) == data.end()) {
		std::cout << "key " << key << " does not exist" << std::endl << std::flush;
		return NONE;
	}
	if (data.at(key) == "") {
		return NONE;
	}
	return "'" + data.at(key) + "'";
}

void jlvg::GPSData::setStatus(const std::string& status) {
	data.at("status") = status;
}

void jlvg::GPSData::setTime(const std::string& time) {
	data.at("time") = time;
}

void jlvg::GPSData::setLatitude(const std::string& latitude) {
	data.at("latitude") = latitude;
}

void jlvg::GPSData::setNorthSouthIndicator(const std::string& northSouthIndicator) {
	data.at("north_or_south") = northSouthIndicator;
}

void jlvg::GPSData::setLongitude(const std::string& longitude) {
	data.at("longitude") = longitude;
}

void jlvg::GPSData::setEastWestIndicator(const std::string& eastWestIndicator) {
	data.at("east_or_west") = eastWestIndicator;
}

void jlvg::GPSData::setSpeed(const std::string& speed) {
	data.at("speed") = speed;
}

void jlvg::GPSData::setCourse(const std::string& course) {
	data.at("course") = course;
}

void jlvg::GPSData::setDate(const std::string& date) {
	data.at("date") = date;
}

void jlvg::GPSData::setMagneticVariation(const std::string& magneticVariation) {
	data.at("magnetic_variation") = magneticVariation;
}

void jlvg::GPSData::setMode(const std::string& mode) {
	data.at("mode") = mode;
}

void jlvg::GPSData::setChecksum(const std::string& checksum) {
	data.at("checksum") = checksum;
}

bool jlvg::GPSData::isGPSLine(const std::string& line) {
	return line.starts_with("$GPRMC");
}

