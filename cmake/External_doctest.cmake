ExternalProject_Add(doctest
		PREFIX doctest
                GIT_REPOSITORY https://github.com/onqtam/doctest.git
                GIT_TAG 1.2.6
		UPDATE_COMMAND ""
		PATCH_COMMAND ""
		INSTALL_DIR "${WirelessMaps_INSTALL_PREFIX}"
		CMAKE_ARGS 
		  -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
)