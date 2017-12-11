cmake_minimum_required(VERSION 3.8.2)

if(CMAKE_SOURCE_DIR STREQUAL CMAKE_BINARY_DIR)
    message(FATAL_ERROR "Do not build in-source. Please remove CMakeCache.txt and the CMakeFiles/ directory. Then build out-of-source.")
endif()

# Put the project early since modules might need to detect the compiler
project("WirelessMaps" C CXX)

############################
##  Modules and scripts   ##
############################

# Standard CMake modules

include(CTest) # Must be called before adding tests but after calling project(). This automatically calls enable_testing() and configures ctest targets when using Make/Ninja

include(CMakeDependentOption)# This is a really useful scripts that creates options that depends on other options. It can even be used with generator expressions !

# Custom modules and scripts

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_CURRENT_LIST_DIR}/cmake")
include(LTO)
include(Warnings)
include(CopyDllsForDebug)
include(Coverage)

###############
##  OPTIONS  ##
###############

option(WM_USE_DOXYGEN "Add a doxygen target to generate the documentation" ON)

cmake_dependent_option(WM_BUILD_TESTS
    "Enable tests targets" ON # By default we want tests if CTest is enabled
    "BUILD_TESTING" OFF # Stay coherent with CTest variables
)

# External dependencies
add_subdirectory(external EXCLUDE_FROM_ALL)

# It is always easier to navigate in an IDE when projects are organized in folders.
set_property(GLOBAL PROPERTY USE_FOLDERS ON)

###############
##  Project  ##
###############

# Check for LTO support (needs to be after project(...) )
find_lto(CXX)

#==========================#
#  WirelessMaps executable  #
#==========================#

# Always list the files explicitly
set(WM_SOURCE_FILES source/main.cpp )

# Always list headers so that they appear in the IDE   
set(WM_INCLUDE_FILES )                  

add_executable(WirelessMaps ${WM_SOURCE_FILES} ${WM_INCLUDE_FILES})
target_link_libraries(WirelessMaps
    PRIVATE
        general fmt spdlog
        #debug DEBUGLIBS
        #optimized RELEASELIBS
)

# Require c++14, this is better than setting CMAKE_CXX_STANDARD since it won't pollute other targets
target_compile_features(WirelessMaps PRIVATE cxx_std_14)

# CMake scripts extensions
target_set_warnings(WirelessMaps ENABLE ALL AS_ERROR ALL DISABLE Annoying)
target_enable_lto(WirelessMaps optimized)
copy_dlls_for_debug(WirelessMaps "" "")

# Setup our project as the startup project for Visual so that people don't need to do it manually
set_directory_properties(PROPERTIES VS_STARTUP_PROJECT WirelessMaps)

#===============#
#  Foo library  #
#===============#

# Usually libraries are listed before executables, but in this case we only use it for the tests
set(FOO_SOURCE_FILES source/foo.cpp )
set(FOO_INCLUDE_FILES source/include/foo.h)

add_library(wm_foo ${FOO_SOURCE_FILES} ${FOO_INCLUDE_FILES} )
target_include_directories(wm_foo
    PUBLIC # The folder must be used in the include path for any target using this library
        source/include
)
target_link_libraries(wm_foo
    PRIVATE # fmt is only needed to build, not to use this library
        fmt
)
# Give a 'scoped' name to libraries targets, as it can't be mistaken with system libraries
add_library(wm::foo ALIAS wm_foo)

#===========#
#   Tests   #
#===========#

if(WM_BUILD_TESTS)
    # Let the user add options to the test runner if needed
    set(TEST_RUNNER_PARAMS "--force-colors=true" CACHE STRING "Options to add to our test runners commands")
    # In a real project you most likely want to exclude test folders
    # list(APPEND CUSTOM_COVERAGE_EXCLUDE "/test/")
    add_subdirectory(tests)
    # You can setup some custom variables and add them to the CTestCustom.cmake.in template to have custom ctest settings
    # For example, you can exclude some directories from the coverage reports such as third-parties and tests
    configure_file(
        ${CMAKE_CURRENT_LIST_DIR}/cmake/CTestCustom.cmake.in
        ${CMAKE_CURRENT_BINARY_DIR}/CTestCustom.cmake
        @ONLY
    )
endif()

#############
## Doxygen ##
#############

if(WM_USE_DOXYGEN AND CMAKE_VERSION VERSION_GREATER_EQUAL 3.9)
    find_package(Doxygen
        OPTIONAL_COMPONENTS dot mscgen dia
    )
    if(DOXYGEN_FOUND)
        set(DOXYGEN_USE_MDFILE_AS_MAINPAGE README.md)
        doxygen_add_docs(
            doc
            README.md source
            COMMENT "Generate man pages"
        )
    endif()
endif()
