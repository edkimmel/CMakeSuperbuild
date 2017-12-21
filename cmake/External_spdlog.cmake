ExternalProject_Add(spdlog
	PREFIX spdlog
	DEPENDS fmt
	GIT_REPOSITORY https://github.com/gabime/spdlog.git
	GIT_TAG master
	UPDATE_COMMAND ""
	PATCH_COMMAND ""
	INSTALL_DIR "${MyProject_INSTALL_PREFIX}"
	CMAKE_ARGS 
		${MyProject_DEFAULT_ARGS}
		CFLAGS=-DSPDLOG_FMT_EXTERNAL=1
		-DSPDLOG_BUILD_TESTING=OFF
)
