cmake_minimum_required(VERSION 3.8.2)

ExternalProject_Add(fmt
	PREFIX 
		fmt
  GIT_REPOSITORY https://github.com/fmtlib/fmt.git
  GIT_TAG "4.0.0"
	UPDATE_COMMAND ""
	PATCH_COMMAND ""
	INSTALL_DIR ${MyProject_INSTALL_PREFIX}
	CMAKE_ARGS 
		${MyProject_DEFAULT_ARGS}
		-DFMT_TEST=OFF
		-DFMT_DOC=OFF
)
