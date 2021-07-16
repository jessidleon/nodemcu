#include <iostream>
#include "argumentsHelper.hpp"

void jlvg::ArgumentsHelper::help(int argc, const char** argv) {
	if (argc != 3) {
		std::cout << "Usage:" << std::endl << std::flush;
		std::cout << argv[0] << " 	pathToDatabase pathToTextFile" << std::endl << std::flush;
		exit(-1);
	}
}
