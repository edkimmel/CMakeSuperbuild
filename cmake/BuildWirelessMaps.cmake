ExternalProject_Add(WirelessMaps
	PREFIX WirelessMaps
	DEPENDS fmt spdlog
	DOWNLOAD_COMMAND ""
	UPDATE_COMMAND ""
	SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/../WirelessMaps
	INSTALL_DIR "${WirelessMaps_INSTALL_PREFIX}"
	CMAKE_ARGS 
		${WirelessMaps_DEFAULT_ARGS}
)