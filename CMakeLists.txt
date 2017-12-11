cmake_minimum_required(VERSION 3.8.2)

if(CMAKE_SOURCE_DIR STREQUAL CMAKE_BINARY_DIR)
    message(FATAL_ERROR "Do not build in-source. Please remove CMakeCache.txt and the CMakeFiles/ directory. Then build out-of-source.")
endif()

project("WirelessMaps" C CXX)

############################
##  Modules and scripts   ##
############################

# Standard CMake modules

include(CTest)
include(CMakeDependentOption)
include(ExternalProject)

# Custom modules and scripts
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_CURRENT_LIST_DIR}/cmake")

option(BUILD_SHARED_LIBS "Build libraries as SHARED" ON)

set(WirelessMaps_INSTALL_PREFIX "${WirelessMaps_BINARY_DIR}/prefix")
set(WirelessMaps_DEFAULT_ARGS
  "-DBUILD_SHARED_LIBS:BOOL=${BUILD_SHARED_LIBS}"
  "-DCMAKE_PREFIX_PATH:PATH=${WirelessMaps_INSTALL_PREFIX};${CMAKE_PREFIX_PATH}"
  "-DCMAKE_INSTALL_PREFIX:PATH=${WirelessMaps_INSTALL_PREFIX}")
include(External_fmt)
include(External_spdlog)

ExternalProject_Add(WirelessMaps
   DEPENDS fmt spdlog
   DOWNLOAD_COMMAND ""
   UPDATE_COMMAND ""
   SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/WirelessMaps
   BINARY_DIR WirelessMaps-build
)
