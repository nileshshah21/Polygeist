
include(ExternalProject)
option(CPLEX_HOME_POLYFREQ "Path to CPLEX installation" "")
    if(NOT CPLEX_HOME_POLYFREQ)
message(FATAL_ERROR "Please provide the path to the CPLEX installation")
endif()

option(LLVM_CONFIG_BIN "Path to LLVM installation" "")
if(NOT LLVM_CONFIG_BIN)
    message(FATAL_ERROR "Please provide the path to the LLVM installation")
endif()
#print LLVM_CONFIG and CPLEX_HOME
message(STATUS "LLVM_CONFIG: ${LLVM_CONFIG_BIN}")
message(STATUS "CPLEX_HOME: ${CPLEX_HOME_POLYFREQ}")
message(STATUS "===> Building PolyFreq <===")


ExternalProject_Add(bullseye_build
    SOURCE_DIR        "${CMAKE_BINARY_DIR}/PolyFreq/PolyFreq"
    INSTALL_DIR        "${CMAKE_BINARY_DIR}/PolyFreq/Install"
    GIT_REPOSITORY    /home/intern24005/code/PolyFreq_build_test/Polyfreq_trunk/.git
    GIT_TAG          "trunk"
    BINARY_DIR       "${CMAKE_BINARY_DIR}/PolyFreq/build"
    UPDATE_COMMAND    bash -c "git submodule update --init --recursive"
    CMAKE_ARGS        -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR> -DLLVM_CONFIG=${LLVM_CONFIG_BIN} -DCPLEX_HOME=${CPLEX_HOME_POLYFREQ} 
    # CMAKE_ARGS        -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR> -DCMAKE_BUILD_TYPE=Release -DLLVM_CONFIG=${LLVM_CONFIG_BIN} -DCPLEX_HOME=${CPLEX_HOME_POLYFREQ} -DCMAKE_INSTALL_RPATH=<INSTALL_DIR>
    )
ExternalProject_Get_property(bullseye_build INSTALL_DIR)
include_directories("${INSTALL_DIR}/include")
include_directories("${CMAKE_BINARY_DIR}/PolyFreq/Install/include")

link_directories(${POLYFREQ_DEPENDENT_LIB_DIRS})
set(POLYFREQ_DEPENDENT_LIBS

    libbullseye
    barvinok 
    polylibgmp 
    isl 
    pet
    gmp
    stdc++
    c
    glpk 
    ntl 
    dl
)

set(POLYFREQ_DEPENDENT_LIB_DIRS
    "${INSTALL_DIR}/lib"
    "${CMAKE_BINARY_DIR}/PolyFreq/Install/lib"
    "${CPLEX_HOME_POLYFREQ}/cplex/lib/x86-64_linux/static_pic/"
    "${CPLEX_HOME_POLYFREQ}/concert/lib/x86-64_linux/static_pic/"
    "${CPLEX_HOME_POLYFREQ}/opl/lib/x86-64_linux/static_pic/"
    "${CPLEX_HOME_POLYFREQ}/opl/lib/x86-64_linux/static_pic/"
)



# make all dependendent on bullseye_build
# add_custom_target( DEPENDS bullseye_build)

# [INFO]
# if you use this project and install it in the system remember it will always 
#look for shared libraries in the install directory(of this project) and not in the system.