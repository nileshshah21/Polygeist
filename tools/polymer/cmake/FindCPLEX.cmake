# Try to find CPLEX
# Source : https://github.com/alberto-santini/cplex-example/blob/master/cmake/FindCplex.cmake

FIND_PATH(CPLEX_INCLUDE_DIR
        ilcplex/cplex.h
        HINTS ${CPLEX_HOME}/cplex/include
        ${CPLEX_HOME}/include
        PATHS ENV C_INCLUDE_PATH
        ENV C_PLUS_INCLUDE_PATH
        )
message(STATUS "CPLEX CPLEX_INCLUDE_DIR: ${CPLEX_INCLUDE_DIR}")

FIND_PATH(CPLEX_CONCERT_INCLUDE_DIR
        ilconcert/iloenv.h
        HINTS ${CPLEX_HOME}/concert/include
        ${CPLEX_HOME}/include
        PATHS ENV C_INCLUDE_PATH
        ENV C_PLUS_INCLUDE_PATH
        )
message(STATUS "CPLEX CPLEX_CONCERT_INCLUDE_DIR: ${CPLEX_CONCERT_INCLUDE_DIR}")

FIND_LIBRARY(CPLEX_LIBRARY
        NAMES cplex${CPLEX_WIN_VERSION} cplex
        HINTS ${CPLEX_HOME}/cplex/lib/${CPLEX_WIN_PLATFORM} #windows
        ${CPLEX_HOME}/cplex/lib/x86-64_debian4.0_4.1/static_pic #unix
        ${CPLEX_HOME}/cplex/lib/x86-64_sles10_4.1/static_pic #unix 
        ${CPLEX_HOME}/cplex/lib/x86-64_linux/static_pic #unix 
        ${CPLEX_HOME}/cplex/lib/x86-64_osx/static_pic #osx 
        ${CPLEX_HOME}/cplex/lib/x86-64_darwin/static_pic #osx 
        PATHS ENV LIBRARY_PATH #unix
        ENV LD_LIBRARY_PATH #unix
        )
message(STATUS "CPLEX Library: ${CPLEX_LIBRARY}")

FIND_LIBRARY(CPLEX_ILOCPLEX_LIBRARY
        ilocplex
        HINTS ${CPLEX_HOME}/cplex/lib/${CPLEX_WIN_PLATFORM} #windows
        ${CPLEX_HOME}/cplex/lib/x86-64_debian4.0_4.1/static_pic #unix 
        ${CPLEX_HOME}/cplex/lib/x86-64_sles10_4.1/static_pic #unix 
        ${CPLEX_HOME}/cplex/lib/x86-64_linux/static_pic #unix 
        ${CPLEX_HOME}/cplex/lib/x86-64_osx/static_pic #osx 
        ${CPLEX_HOME}/cplex/lib/x86-64_darwin/static_pic #osx 
        PATHS ENV LIBRARY_PATH
        ENV LD_LIBRARY_PATH
        )
message(STATUS "ILOCPLEX Library: ${CPLEX_ILOCPLEX_LIBRARY}")

FIND_LIBRARY(CPLEX_CONCERT_LIBRARY
        concert
        HINTS ${CPLEX_HOME}/concert/lib/${CPLEX_WIN_PLATFORM} #windows
        ${CPLEX_HOME}/concert/lib/x86-64_debian4.0_4.1/static_pic #unix 
        ${CPLEX_HOME}/concert/lib/x86-64_sles10_4.1/static_pic #unix 
        ${CPLEX_HOME}/concert/lib/x86-64_linux/static_pic #unix 
        ${CPLEX_HOME}/concert/lib/x86-64_osx/static_pic #osx 
        ${CPLEX_HOME}/concert/lib/x86-64_darwin/static_pic #osx 
        PATHS ENV LIBRARY_PATH
        ENV LD_LIBRARY_PATH
        )
message(STATUS "CONCERT Library: ${CPLEX_CONCERT_LIBRARY}")

if(WIN32)
    FIND_PATH(CPLEX_BIN_DIR
            cplex${CPLEX_WIN_VERSION}.dll
            HINTS ${CPLEX_HOME}/cplex/bin/${CPLEX_WIN_PLATFORM} #windows
            )
else()
    FIND_PATH(CPLEX_BIN_DIR
            cplex
            HINTS ${CPLEX_HOME}/cplex/bin/x86-64_sles10_4.1 #unix
            ${CPLEX_HOME}/cplex/bin/x86-64_debian4.0_4.1 #unix
            ${CPLEX_HOME}/cplex/lib/x86-64_linux #unix
            ${CPLEX_HOME}/cplex/bin/x86-64_osx #osx
            ${CPLEX_HOME}/cplex/bin/x86-64_darwin #osx
            ENV LIBRARY_PATH
            ENV LD_LIBRARY_PATH
            )
endif()
message(STATUS "CPLEX Bin Dir: ${CPLEX_BIN_DIR}")

INCLUDE(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(CPLEX DEFAULT_MSG
CPLEX_LIBRARY CPLEX_INCLUDE_DIR CPLEX_ILOCPLEX_LIBRARY CPLEX_CONCERT_LIBRARY CPLEX_CONCERT_INCLUDE_DIR)

IF(CPLEX_FOUND)
SET(CPLEX_INCLUDE_DIRS ${CPLEX_INCLUDE_DIR} ${CPLEX_CONCERT_INCLUDE_DIR})
SET(CPLEX_LIBRARIES ${CPLEX_CONCERT_LIBRARY} ${CPLEX_ILOCPLEX_LIBRARY} ${CPLEX_LIBRARY} )
IF(CMAKE_SYSTEM_NAME STREQUAL "Linux")
SET(CPLEX_LIBRARIES "${CPLEX_LIBRARIES};m;pthread")
ENDIF(CMAKE_SYSTEM_NAME STREQUAL "Linux")
ENDIF(CPLEX_FOUND)
message(STATUS "CPLEX CPLEX_INCLUDE_DIRS: ${CPLEX_INCLUDE_DIRS}")
message(STATUS "CPLEX CPLEX_LIBRARIES: ${CPLEX_LIBRARIES}")

MARK_AS_ADVANCED(CPLEX_LIBRARY CPLEX_INCLUDE_DIR CPLEX_ILOCPLEX_LIBRARY CPLEX_CONCERT_INCLUDE_DIR CPLEX_CONCERT_LIBRARY)
