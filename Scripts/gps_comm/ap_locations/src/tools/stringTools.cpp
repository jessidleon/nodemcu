#include <iostream>
#include <sstream>

#include "stringTools.hpp"

std::shared_ptr<std::vector<std::string>> Tools::split(const std::string& _stringToSplit, char _delim) {
	std::shared_ptr<std::vector<std::string>> elems = std::make_shared<std::vector<std::string >>();
	std::stringstream ss;
	ss.str(_stringToSplit);
	std::string item;

	while (getline(ss, item, _delim)) {
		elems->push_back(item);
	}
	if (_stringToSplit[_stringToSplit.size() - 1] == _delim) {
		elems->push_back("");
	}

	return elems;
}

std::shared_ptr<std::vector<std::string>> Tools::split(const std::string& str, const std::string& delim) {
	auto stringCopy{str};
	std::shared_ptr<std::vector<std::string>> elems{std::make_shared<std::vector<std::string >>()};
	size_t pos = 0;
	std::string token;
	while ((pos = stringCopy.find(delim)) != std::string::npos) {
		token = stringCopy.substr(0, pos);
		elems->push_back(token);
		stringCopy.erase(0, pos + delim.length());
	}
	if (stringCopy.length() != 0) {
		elems->push_back(stringCopy);
	}
	return elems;
}

std::string Tools::leftTrim(const std::string& s) {
	const std::string WHITESPACE = " \n\r\t\f\v";
	size_t start = s.find_first_not_of(WHITESPACE);
	return (start == std::string::npos) ? "" : s.substr(start);
}

std::string Tools::rightTrim(const std::string& s) {
	const std::string WHITESPACE = " \n\r\t\f\v";
	size_t end = s.find_last_not_of(WHITESPACE);
	return (end == std::string::npos) ? "" : s.substr(0, end + 1);
}


std::string Tools::toLower(const std::string& s) {
	std::string lower{""};
	for (uint32_t index = 0; index < s.length(); ++index) {
		lower += tolower(s.at(index));
	}
	return lower;
}

std::string Tools::toUpper(const std::string& s) {
	std::string upper{""};
	for (uint32_t index = 0; index < s.length(); ++index) {
		upper += toupper(s.at(index));
	}
	return upper;
}

std::string Tools::trim(const std::string& str) {
	return rightTrim(leftTrim(str));
}
