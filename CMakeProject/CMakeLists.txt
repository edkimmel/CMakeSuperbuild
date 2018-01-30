cmake_minimum_required(VERSION 3.8.2)

if(CMAKE_SOURCE_DIR STREQUAL CMAKE_BINARY_DIR)
    message(FATAL_ERROR "Do not build in-source. Please remove CMakeCache.txt and the CMakeFiles/ directory. Then build out-of-source.")
endif()

# Put the project early since modules might need to detect the compiler
project("MyProject" C CXX)

############################
##  Modules and scripts   ##
############################

# Standard CMake modules

include(CMakeDependentOption)

# Custom modules and scripts
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_CURRENT_LIST_DIR}/cmake")
include(Warnings)

###############
##  OPTIONS  ##
###############

# It is always easier to navigate in an IDE when projects are organized in folders.
set_property(GLOBAL PROPERTY USE_FOLDERS ON)

###############
##  Project  ##
###############

# Check for LTO support (needs to be after project(...) )
find_lto(CXX)

#==========================#
#  MyProject executable  #
#==========================#

# Always list the files explicitly
set(CMakeProject_SOURCE_FILES 
  source/main.cpp 
)

# Always list headers so that they appear in the IDE   
set(CMakeProject_INCLUDE_FILES 

)                  

# Create the target
add_executable(MyProject ${CMakeProject_SOURCE_FILES} ${CMakeProject_INCLUDE_FILES})

# Set include paths
target_include_directories(MyProject SYSTEM
	PUBLIC
		${MyProject_INSTALL_PREFIX}/include
)

# Set libraries to link against
set(MyProject_LibraryDependencies 
	fmt
)

# Go find all of our dependencies
set(MyProject_LibraryPaths)
foreach(lib ${MyProject_LibraryDependencies})
	set(LIB_FOUND)
	find_library(LIB_FOUND ${lib})
	message("Found ${lib}: ${LIB_FOUND}")
	list(APPEND MyProject_LibraryPaths ${LIB_FOUND})
endforeach(lib)


# Link against all of our dependencies
target_link_libraries(MyProject
    PRIVATE
        ${MyProject_LibraryPaths}
)

# Require c++14, this is better than setting CMAKE_CXX_STANDARD since it won't pollute other targets
target_compile_features(MyProject PRIVATE cxx_std_14)

# CMake scripts extensions
target_set_warnings(MyProject ENABLE ALL DISABLE Annoying)

install (TARGETS MyProject RUNTIME DESTINATION ${CMAKE_INSTALL_PREFIX}/bin)

