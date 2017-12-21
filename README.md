# CMakeSuperbuild

This project is an example of a CMake Superbuild setup.

## Global Variables
The outermost CMakeLists.txt has the responsibility of setting up system wide variables and including common CMake modules
* Whether to build the libraries as static or dynamic
* Prefix directory that all targets will be installed to.

## Third Party Libraries

Third Party Libraries are defined in cmake/ThirdPartyLibraries.cmake
This file contains a macro that will
* Expose an option to use the system library instead of the cmake ExternalProject variant
* Find the system library, if it was chosen, and append its include and library directories to the appropriate vars
* Include the ExternalProject file if the system library was not used

It runs this macro for every dependency needed by the project.

## Main Project

The main project is included through the cmake/BuildProject.cmake file.
This file is responsible for setting up the dependency management of the main project.

Instead of downloading from a repo or file, it instead treats the CMakeProject directory as an external project.