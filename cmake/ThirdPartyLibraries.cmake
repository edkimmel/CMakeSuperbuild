
# Macro for including a third party lib.
#  - Add an option to use the system version of the library
#  - If the system version is chosen:
#    - Find it (required)
#    - Append to THIRDPARTYLIB_ARGS
#  - Else, include the External_${lib} file to build it. 
macro(add_thirdparty_lib lib_name)
  string(TOUPPER "${lib_name}" _uLibName)
  option(USE_SYSTEM_${_uLibName} "Should we use the system ${lib_name}?" OFF)
  if(USE_SYSTEM_${_uLibName})
    MESSAGE( "Using system ${_uLibName}")
    find_package(${_uLibName} REQUIRED)  
    MESSAGE( "Found system ${_uLibName}")
    set(_uIncludeVarName ${_uLibName}_INCLUDE_DIRS)
    set(_uLibVarName ${_uLibName}_LIBRARIES)
    list(APPEND MyProject_THIRDPARTYLIBS_ARGS
      "-D${_uLibName}_INCLUDE_DIRS:PATH=${_uIncludeVarName}"
      "-D${_uLibName}_LIBRARIES:FILEPATH=${_uLibVarName}")

  else()
    include(External_${lib_name})
  endif()
endmacro()


add_thirdparty_lib(fmt)
add_thirdparty_lib(spdlog)

set(MyProject_THIRDPARTYLIBS_ARGS "${WirelessMaps_THIRDPARTYLIBS_ARGS}")
