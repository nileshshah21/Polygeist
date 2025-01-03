
include(ExternalProject)
option(CPLEX_HOME "Path to CPLEX installation" "")
    if(NOT CPLEX_HOME)
message(FATAL_ERROR "Please provide the path to the CPLEX installation")
endif()

option(LLVM_CONFIG_BIN "Path to LLVM installation" "")
if(NOT LLVM_CONFIG_BIN)
    message(FATAL_ERROR "Please provide the path to the LLVM installation")
endif()
#print LLVM_CONFIG and CPLEX_HOME
message(STATUS "LLVM_CONFIG: ${LLVM_CONFIG_BIN}")
message(STATUS "CPLEX_HOME: ${CPLEX_HOME}")
message(STATUS "===> Building PolyFreq <===")


ExternalProject_Add(bullseye_build
    SOURCE_DIR        "${CMAKE_BINARY_DIR}/PolyFreq/PolyFreq"
    INSTALL_DIR        "${CMAKE_BINARY_DIR}/PolyFreq/Install"
    GIT_REPOSITORY    /home/intern24005/code/PolyFreq_build_test/Polyfreq_trunk/.git
    GIT_TAG          "trunk"
    BINARY_DIR       "${CMAKE_BINARY_DIR}/PolyFreq/build"
    UPDATE_COMMAND    bash -c "git submodule update --init --recursive"
    CMAKE_ARGS        -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR> -DLLVM_CONFIG=${LLVM_CONFIG_BIN} -DCPLEX_HOME=${CPLEX_HOME} 
    # CMAKE_ARGS        -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR> -DCMAKE_BUILD_TYPE=Release -DLLVM_CONFIG=${LLVM_CONFIG_BIN} -DCPLEX_HOME=${CPLEX_HOME_POLYFREQ} -DCMAKE_INSTALL_RPATH=<INSTALL_DIR>
    INSTALL_BYPRODUCTS  <INSTALL_DIR>/lib/libbullseye.a <INSTALL_DIR>/lib/libpolylibgmp.so <INSTALL_DIR>/lib/libisl.so <INSTALL_DIR>/lib/libpet.so <INSTALL_DIR>/lib/libbarvinok.a  <INSTALL_DIR>/lib/libgmp.a <INSTALL_DIR>/lib/libstdc++.a <INSTALL_DIR>/lib/libc.a <INSTALL_DIR>/lib/libglpk.a <INSTALL_DIR>/lib/libntl.a <INSTALL_DIR>/lib/libdl.a
    # INSTALL_BYPRODUCTS  <INSTALL_DIR>/lib/libbullseye.a <INSTALL_DIR>/lib/libpolylibgmp.a <INSTALL_DIR>/lib/libisl.a <INSTALL_DIR>/lib/libpet.a <INSTALL_DIR>/lib/libgmp.a <INSTALL_DIR>/lib/libstdc++.a <INSTALL_DIR>/lib/libc.a <INSTALL_DIR>/lib/libglpk.a <INSTALL_DIR>/lib/libntl.a <INSTALL_DIR>/lib/libdl.a
)
ExternalProject_Get_property(bullseye_build INSTALL_DIR)
set(POLYFREQ_DEPENDENT_LIB_DIRS
    ${GMP_LIBRARY} 
    ${NTL_LIBRARY} 
    ${GLPK_LIBRARY}
    "${INSTALL_DIR}/lib"
    "${CMAKE_BINARY_DIR}/PolyFreq/Install/lib"
    "${CPLEX_HOME_POLYFREQ}/cplex/lib/x86-64_linux/static_pic/"
    "${CPLEX_HOME_POLYFREQ}/concert/lib/x86-64_linux/static_pic/"
    "${CPLEX_HOME_POLYFREQ}/opl/lib/x86-64_linux/static_pic/"
    "${CPLEX_HOME_POLYFREQ}/opl/lib/x86-64_linux/static_pic/"  
    "${CPLEX_HOME_DIR}/cplex/lib/x86-64_linux/static_pic/"
    "${CPLEX_HOME_DIR}/concert/lib/x86-64_linux/static_pic/"
    "${CPLEX_HOME_DIR}/opl/lib/x86-64_linux/static_pic/"
    "${CPLEX_HOME_DIR}/opl/lib/x86-64_linux/static_pic/"
)
include_directories("${INSTALL_DIR}/include")
include_directories("${CMAKE_BINARY_DIR}/PolyFreq/Install/include")
link_directories(${POLYFREQ_DEPENDENT_LIB_DIRS})
add_library(libbullseye STATIC IMPORTED)
set_target_properties(libbullseye PROPERTIES IMPORTED_LOCATION "${INSTALL_DIR}/lib/libbullseye.a")
add_library(libpolylibgmp SHARED IMPORTED)
set_target_properties(libpolylibgmp PROPERTIES IMPORTED_LOCATION "${INSTALL_DIR}/lib/libpolylibgmp.so")
add_library(libisl SHARED IMPORTED)
set_target_properties(libisl PROPERTIES IMPORTED_LOCATION "${INSTALL_DIR}/lib/libisl.so")
add_library(libpet SHARED IMPORTED)
set_target_properties(libpet PROPERTIES IMPORTED_LOCATION "${INSTALL_DIR}/lib/libpet.so")
add_library(libbarvinok STATIC IMPORTED)
set_target_properties(libbarvinok PROPERTIES IMPORTED_LOCATION "${INSTALL_DIR}/lib/libbarvinok.a")


set(POLYFREQ_DEPENDENT_LIBS
    ${CPLEX_LIBRARIES}
    libbullseye
    libbarvinok
    libpolylibgmp
    libisl
    libpet
    gmp
    ntl
    glpk
)




# make all dependendent on bullseye_build
# add_custom_target( DEPENDS bullseye_build)

# [INFO]
# if you use this project and install it in the system remember it will always 
#look for shared libraries in the install directory(of this project) and not in the system.