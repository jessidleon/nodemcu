cmake_minimum_required(VERSION 3.19)
project(ap_locations)

set(CMAKE_CXX_STANDARD 20)

add_executable(ap_locations
        src/main.cpp
        src/parser/dataParser.cpp
        src/parser/dataParser.hpp
        src/parser/gpsData.cpp
        src/parser/gpsData.hpp
        src/parser/accessPoint.cpp
        src/parser/accessPoint.hpp
        src/tools/stringTools.cpp
        src/tools/stringTools.hpp
        src/sqlite/sqlite3.c
        src/sqlite/sqlite3.h
        src/parser/parserHelper.cpp src/parser/parserHelper.hpp src/sqlite/sqlHelper.cpp src/sqlite/sqlHelper.hpp src/tools/argumentsHelper.cpp src/tools/argumentsHelper.hpp)

target_link_libraries(ap_locations pthread dl m)