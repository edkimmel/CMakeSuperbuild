cmake_minimum_required(VERSION 3.8.2)

if(CMAKE_SOURCE_DIR STREQUAL CMAKE_BINARY_DIR)
    message(FATAL_ERROR "Do not build in-source. Please remove CMakeCache.txt and the CMakeFiles/ directory. Then build out-of-source.")
endif()

include(${CMAKE_ROOT}/Modules/ExternalProject.cmake)

ExternalProject_Add(fmt
		PREFIX fmt
                GIT_REPOSITORY https://github.com/fmtlib/fmt.git
                GIT_TAG 4.0.0
		EXCLUDE_FROM_ALL 1
		UPDATE_COMMAND ""
		PATCH_COMMAND ""
)

ExternalProject_Add(spdlog
		PREFIX spdlog
                GIT_REPOSITORY https://github.com/gabime/spdlog.git
                GIT_TAG master
		EXCLUDE_FROM_ALL 1
		UPDATE_COMMAND ""
		PATCH_COMMAND ""
		CMAKE_ARGS "-DSPDLOG_FMT_EXTERNAL"
)

ExternalProject_Add(doctest
		PREFIX doctest
                GIT_REPOSITORY https://github.com/onqtam/doctest.git
                GIT_TAG 1.2.6
		UPDATE_COMMAND ""
		PATCH_COMMAND ""
)

ExternalProject_Add(WirelessMaps
   DEPENDS fmt spdlog doctest
   DOWNLOAD_COMMAND ""
   UPDATE_COMMAND ""
   SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/..
   BINARY_DIR WirelessMaps-build   
)