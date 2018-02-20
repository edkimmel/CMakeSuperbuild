cmake_minimum_required(VERSION 3.8.2)


############################
##  Modules and scripts   ##
############################

# Standard CMake modules

include(CMakeDependentOption)

# Custom modules and scripts
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_CURRENT_LIST_DIR}/cmake")
include(Warnings)
include(ClangTidy)

###############
##  OPTIONS  ##
###############

# It is always easier to navigate in an IDE when projects are organized in folders.
set_property(GLOBAL PROPERTY USE_FOLDERS ON)

###############
##  Project  ##
###############

#==========================#
#  CMakeProject executable  #
#==========================#                

# Create the target
add_executable(CMakeProject "" "")

target_sources(CMakeProject
	PRIVATE
		source/main.cpp
)

# Set include paths
target_include_directories(CMakeProject
	PRIVATE
		${CMAKE_CURRENT_SOURCE_DIR}/source
)

find_package(fmt REQUIRED)
find_package(spdlog REQUIRED)

target_link_libraries(CMakeProject
    PUBLIC
        fmt::fmt 
        spdlog::spdlog
)

# More logging when compiling.
set_target_properties(
	CMakeProject PROPERTIES 
	RULE_MESSAGES ON
)

# Set the standard version
set_target_properties(
  CMakeProject PROPERTIES
  CXX_STANDARD 14
  CXX_STANDARD_REQUIRED ON
)

# Add warnings to our target (From Warnings.cmake)
target_set_warnings(CMakeProject ENABLE ALL DISABLE Annoying)

# Add clang-tidy to our build if it was found (From ClangTidy.cmake)
#if(DO_CLANG_TIDY)
  set_target_properties(
    CMakeProject PROPERTIES
    CXX_CLANG_TIDY "${DO_CLANG_TIDY}"
  )
#endif()

# Add include-what-you-use to our build if it was found (From IncludeWhatYouUse.cmake)
#if(DO_IWYU)
  set_target_properties(
    CMakeProject PROPERTIES
    CXX_INCLUDE_WHAT_YOU_USE "${DO_IWYU}"
  )
#endif()

# Where to install the target
install (TARGETS CMakeProject RUNTIME DESTINATION ${CMAKE_INSTALL_PREFIX}/bin)
