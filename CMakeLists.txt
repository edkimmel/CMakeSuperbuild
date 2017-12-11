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
  "-DCMAKE_INSTALL_PREFIX:PATH=${WirelessMaps_INSTALL_PREFIX}"
)


if(CMAKE_BUILD_TYPE)
  list(APPEND WirelessMaps_DEFAULT_ARGS
    "-DCMAKE_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE}")
endif()

# Convenience macro for adding dependencies optionally if not using system
# copies. This function takes the external project target name, looks for a
# variable of the form USE_SYSTEM_TARGETNAME, if this does not exist or is set
# to false the supplied taget name will be added to dep_var.
macro(add_optional_deps dep_var)
  foreach(_dependency ${ARGN})
    string(TOUPPER "${_dependency}" _uDependency)
    if(NOT USE_SYSTEM_${_uDependency})
      list(APPEND ${dep_var} ${_dependency})
    endif()
  endforeach()
endmacro()

# Direct dependencies here
include(External_fmt)
include(External_spdlog)

# Project here
include(BuildWirelessMaps)
