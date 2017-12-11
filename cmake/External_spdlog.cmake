ExternalProject_Add(spdlog
		PREFIX spdlog
		DEPENDS fmt
                GIT_REPOSITORY https://github.com/gabime/spdlog.git
                GIT_TAG master
		UPDATE_COMMAND ""
		PATCH_COMMAND ""
		INSTALL_DIR "${WirelessMaps_INSTALL_PREFIX}"
		CMAKE_ARGS 
		  -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
		  CFLAGS=-DSPDLOG_FMT_EXTERNAL=1
)