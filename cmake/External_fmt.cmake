cmake_minimum_required(VERSION 3.8.2)

ExternalProject_Add(fmt
		PREFIX fmt
		EXCLUDE_FROM_ALL 1
                GIT_REPOSITORY https://github.com/fmtlib/fmt.git
                GIT_TAG 4.0.0
		UPDATE_COMMAND ""
		PATCH_COMMAND ""
		INSTALL_DIR "${WirelessMaps_INSTALL_PREFIX}"
		CMAKE_ARGS 
		  -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
)