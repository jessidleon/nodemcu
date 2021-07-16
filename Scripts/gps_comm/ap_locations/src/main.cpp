#include <iostream>
#include <fstream>
#include <map>
#include "parser/dataParser.hpp"
#include "parser/parserHelper.hpp"
#include "sqlite/sqlHelper.hpp"
#include "tools/argumentsHelper.hpp"

int main(int argc, const char** argv) {
	jlvg::ArgumentsHelper::help(argc, argv);
	auto data{jlvg::ParserHelper::help(argv)};
	jlvg::SqlHelper::help(argv, data);
	return 0;
}
