#include <fstream>
#include "dataParser.hpp"
#include <iostream>
#include "parserHelper.hpp"

std::map<jlvg::GPSData, std::vector<jlvg::AccessPointData>> jlvg::ParserHelper::help(const char** argv) {
	std::ifstream in{jlvg::DataParser::open(argv[2])};
	jlvg::DataParser::parse(in);
	jlvg::DataParser::close(in);
	return jlvg::DataParser::getData();
}