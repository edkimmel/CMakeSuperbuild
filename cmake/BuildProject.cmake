
unset(_deps)

add_optional_dependency(_deps "fmt")
add_optional_dependency(_deps "spdlog")

message("Deps: ${_deps}")

ExternalProject_Add(CMakeProject
  PREFIX 
    CMakeProject
  DEPENDS
    ${_deps}
  DOWNLOAD_COMMAND 
    ""
  UPDATE_COMMAND 
    ""
  SOURCE_DIR 
    ${CMAKE_CURRENT_LIST_DIR}/../CMakeProject
  INSTALL_DIR 
    ${MyProject_INSTALL_PREFIX}
  CMAKE_ARGS 
    ${MyProject_DEFAULT_ARGS}
)
