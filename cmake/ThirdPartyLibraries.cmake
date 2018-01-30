
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
    find_package(${_uLibName} REQUIRED CONFIG)  
    MESSAGE( "Found system ${_uLibName}")
  else()
    include(External_${lib_name})
  endif()
endmacro()

add_thirdparty_lib(fmt)
add_thirdparty_lib(spdlog)