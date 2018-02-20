cmake_minimum_required(VERSION 3.8.2)

if(CMAKE_SOURCE_DIR STREQUAL CMAKE_BINARY_DIR)
    message(FATAL_ERROR "Do not build in-source. Please remove CMakeCache.txt and the CMakeFiles/ directory. Then build out-of-source.")
endif()

project("MyProject" C CXX)

############################
##  Modules and scripts   ##
############################

# Standard CMake modules
include(CTest)
include(CMakeDependentOption)
include(ExternalProject)

# Custom modules and scripts
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_CURRENT_LIST_DIR}/cmake")
include(AddOptionalDependency)


#########################
##  Global Variables.  ##
#########################
# Global variables
option(BUILD_SHARED_LIBS "Build libraries as SHARED" OFF)

set(MyProject_INSTALL_PREFIX "${MyProject_BINARY_DIR}/prefix")
set(MyProject_THIRD_PARTY_DOWNLOAD_DIR "${MyProject_BINARY_DIR}/download")
set(MyProject_DEFAULT_ARGS
  "-DBUILD_SHARED_LIBS:BOOL=${BUILD_SHARED_LIBS}"
  "-DCMAKE_PREFIX_PATH:PATH=${MyProject_INSTALL_PREFIX};${CMAKE_PREFIX_PATH}"
  "-DCMAKE_INSTALL_PREFIX:PATH=${MyProject_INSTALL_PREFIX}"
)


if(CMAKE_BUILD_TYPE)
  list(APPEND MyProject_DEFAULT_ARGS
    "-DCMAKE_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE}")
endif()


##############################
##  Include all the things  ##
##############################

# Include third party projects
include(ThirdPartyLibraries)

# Include first party projects
include(BuildProject)
