cmake_minimum_required(VERSION 3.6)

find_program(
  IWYU_EXE
  NAMES "include-what-you-use"
  DOC "Path to include-what-you-use executable"
  )
if(NOT IWYU_EXE)
  message(STATUS "include-what-you-use not found.")
else()
  message(STATUS "include-what-you-use found: ${IWYU_EXE}")
  set(DO_IWYU ${IWYU_EXE})
endif()