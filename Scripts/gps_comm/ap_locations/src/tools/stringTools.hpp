#pragma once
#include <string>
#include <vector>
#include <memory>

class Tools {

public:
	static std::shared_ptr<std::vector<std::string>> split(const std::string& string, char delim);
	static std::shared_ptr<std::vector<std::string>> split(const std::string& string, const std::string& delim);
	static std::string leftTrim(const std::string& str);
	static std::string rightTrim(const std::string& str);
	static std::string trim(const std::string& str);
	static std::string toLower(const std::string& str);
	static std::string toUpper(const std::string& str);
};
