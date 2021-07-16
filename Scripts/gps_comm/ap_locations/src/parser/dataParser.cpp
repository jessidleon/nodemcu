#include "dataParser.hpp"
#include "../tools/stringTools.hpp"
#include <fstream>
#include <iostream>

std::map<jlvg::GPSData, std::vector<jlvg::AccessPointData>> jlvg::DataParser::data;

std::ifstream jlvg::DataParser::open(const std::string& path) {
	std::ifstream in(path.c_str(), std::ifstream::in);
	if (not in.is_open()) {
		std::string message{"Could not open " + path};
		exit(-1);
	}
	return in;
}

void jlvg::DataParser::parse(std::ifstream& in) {
	auto line{searchNextGPSLine(in)};
	GPSData gpsData{parseGPSLine(line)};
	std::vector<AccessPointData> APsForThisGpsData;

	while (getline(in, line)) {
		if (jlvg::GPSData::isGPSLine(line)) {
			if (not APsForThisGpsData.empty()) {
				data.insert(std::make_pair(gpsData, APsForThisGpsData));
				APsForThisGpsData.clear();
			}
			gpsData = parseGPSLine(line);
		} else if (isAPLine(line)) {
			auto apData{parseAPLine(line)};
			APsForThisGpsData.emplace_back(apData);
		}
	}
	if (not APsForThisGpsData.empty()) {
		data.insert(std::make_pair(gpsData, APsForThisGpsData));
	}
}

std::string jlvg::DataParser::searchNextGPSLine(std::ifstream& in) {
	std::string line{""};

	while (getline(in, line)) {
		if (line.starts_with("$GPRMC")) {
			return line;
		}
	}
	return std::string{""};
}


jlvg::GPSData jlvg::DataParser::parseGPSLine(const std::string& line) {
	auto splitLine{Tools::split(line, ",")};

	GPSData gpsData;
	gpsData.setTime(splitLine->at(1));
	gpsData.setStatus(splitLine->at(2));
	gpsData.setLatitude(splitLine->at(3));
	gpsData.setNorthSouthIndicator(splitLine->at(4));
	gpsData.setLongitude(splitLine->at(5));
	gpsData.setEastWestIndicator(splitLine->at(6));
	gpsData.setSpeed(splitLine->at(7));
	gpsData.setCourse(splitLine->at(8));
	gpsData.setDate(splitLine->at(9));
	gpsData.setMagneticVariation(splitLine->at(10));
	auto modeAndChksum_ptr{Tools::split(splitLine->at(12), "*")};
	if (not modeAndChksum_ptr->empty()) {
		gpsData.setMode(modeAndChksum_ptr->at(0));
		gpsData.setChecksum(modeAndChksum_ptr->at(1).substr(0, 2));
	}
	return gpsData;
}

std::map<jlvg::GPSData, std::vector<jlvg::AccessPointData>> jlvg::DataParser::getData() {
	return data;
}

void jlvg::DataParser::close(std::ifstream& in) {
	in.close();
	if (in.is_open()) {
		std::string error{"Could not close file"};
		throw std::runtime_error(error.c_str());
	}
}

bool jlvg::DataParser::isAPLine(const std::string& line) {
	auto splitLine{Tools::split(line, ",")};
	if (splitLine->size() == 5) {
		auto mac{Tools::split(splitLine->at(0), ":")};
		return mac->size() == 6;
	}
	return false;
}

jlvg::AccessPointData jlvg::DataParser::parseAPLine(const std::string& line) {
	auto splitLine{Tools::split(line, ",")};
	auto accessPointData{jlvg::AccessPointData()};
	accessPointData.set("bssid", splitLine->at(0));
	accessPointData.set("ssid", splitLine->at(1));
	accessPointData.set("rssid", splitLine->at(2));
	accessPointData.set("auth_mode", splitLine->at(3));
	accessPointData.set("channel", splitLine->at(4));
	return accessPointData;
}