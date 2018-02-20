cmake_minimum_required(VERSION 3.8.2)

unset(_deps)
add_optional_dependency(_deps "fmt")

ExternalProject_Add(spdlog
	PREFIX 
		spdlog
	DEPENDS 
		${_deps}
	GIT_REPOSITORY https://github.com/gabime/spdlog.git
	GIT_TAG "v0.16.3"
	UPDATE_COMMAND ""
	PATCH_COMMAND ""
	INSTALL_DIR ${MyProject_INSTALL_PREFIX}
	CMAKE_ARGS 
		${MyProject_DEFAULT_ARGS}
		CFLAGS=-DSPDLOG_FMT_EXTERNAL=1
		-DSPDLOG_BUILD_TESTING=OFF
)
