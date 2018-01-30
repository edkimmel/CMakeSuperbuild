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
include(ClangTidy)

# Currently disabled until I actually test that it works...
#include(CCache)


# Currently disabled - it seems to enter system headers and choke itself :(
#include(IncludeWhatYouUse)

###############
##  OPTIONS  ##
###############

# It is always easier to navigate in an IDE when projects are organized in folders.
set_property(GLOBAL PROPERTY USE_FOLDERS ON)

###############
##  Project  ##
###############

#==========================#
#  MyProject executable  #
#==========================#

set(CMakeProject_SOURCE_FILES 
  source/main.cpp 
)
 
set(CMakeProject_INCLUDE_FILES 

)                  

# Create the target
add_executable(MyProject ${CMakeProject_SOURCE_FILES} ${CMakeProject_INCLUDE_FILES})

# Set include paths
target_include_directories(MyProject SYSTEM
	PUBLIC
		${CMAKE_INSTALL_PREFIX}/include
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

# More logging when compiling.
set_target_properties(
	MyProject PROPERTIES 
	RULE_MESSAGES ON
)

# Set the standard version
set_target_properties(
  MyProject PROPERTIES
  CXX_STANDARD 14
  CXX_STANDARD_REQUIRED ON
)

# Add warnings to our target (From Warnings.cmake)
target_set_warnings(MyProject ENABLE ALL DISABLE Annoying)

# Add clang-tidy to our build if it was found (From ClangTidy.cmake)
#if(DO_CLANG_TIDY)
  set_target_properties(
    MyProject PROPERTIES
    CXX_CLANG_TIDY "${DO_CLANG_TIDY}"
  )
#endif()

# Add include-what-you-use to our build if it was found (From IncludeWhatYouUse.cmake)
#if(DO_IWYU)
  set_target_properties(
    MyProject PROPERTIES
    CXX_INCLUDE_WHAT_YOU_USE "${DO_IWYU}"
  )
#endif()

# Where to install the target
install (TARGETS MyProject RUNTIME DESTINATION ${CMAKE_INSTALL_PREFIX}/bin)
