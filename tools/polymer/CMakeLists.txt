set(CMAKE_LIBRARY_OUTPUT_DIRECTORY
  "${CMAKE_CURRENT_BINARY_DIR}/lib${LLVM_LIBDIR_SUFFIX}")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}")

set(POLYMER_TRANSFORM_DEPENDS
  MLIRAffineOpsIncGen
  MLIRAffinePassIncGen
  MLIRLoopLikeInterfaceIncGen
)

set(POLYMER_MAIN_SRC_DIR "${CMAKE_CURRENT_SOURCE_DIR}" )
set(POLYMER_MAIN_INCLUDE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/include" )

set(POLYMER_SOURCE_DIR  "${CMAKE_CURRENT_SOURCE_DIR}")
set(POLYMER_BINARY_DIR  "${CMAKE_CURRENT_BINARY_DIR}/bin")
set(POLYMER_INCLUDE_DIR "${CMAKE_CURRENT_BINARY_DIR}/include" ) 
set(POLYMER_TOOLS_DIR   ${CMAKE_BINARY_DIR}/bin)

# ----------------------------- Customize CMake

set(CMAKE_MODULE_PATH "${CMAKE_MODULE_PATH}" "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

# ----------------------------- Dependencies
# Find whether the GMP package exists.
find_package(GMP REQUIRED)

# ----------------------------- Add External Projects (polyfreq)
if(POLYGEIST_POLYMER_ENABLE_POLYFREQ)
#print message that we are building PolyFreq
  message(STATUS "Will build and use Polymer-bundled PolyFreq")
  # do not change the order of the following lines 
  include("${CMAKE_CURRENT_SOURCE_DIR}/cmake/FindCPLEX.cmake")
  include("${CMAKE_CURRENT_SOURCE_DIR}/cmake/AddPolyFreq.cmake")
  include("${CMAKE_CURRENT_SOURCE_DIR}/cmake/FindNTL.cmake")
  include("${CMAKE_CURRENT_SOURCE_DIR}/cmake/FindGMP.cmake")
  include("${CMAKE_CURRENT_SOURCE_DIR}/cmake/FindGLPK.cmake")

  include_directories("${CMAKE_BINARY_DIR}/PolyFreq/Install/include/")
  link_directories(${POLYFREQ_DEPENDENT_LIB_DIRS})
  link_libraries(${POLYFREQ_DEPENDENT_LIBS})
  # print all the directories added here
  message(STATUS "POLYFREQ_DEPENDENT_LIB_DIRS='${POLYFREQ_DEPENDENT_LIB_DIRS}'")
  message(STATUS "POLYFREQ_DEPENDENT_LIBS='${POLYFREQ_DEPENDENT_LIBS}'")
  message(STATUS "include_directories='${CMAKE_BINARY_DIR}/PolyFreq/Install/include/'")
  # add_library(libbullseye STATIC IMPORTED)

endif()

if(POLYGEIST_POLYMER_ENABLE_PLUTO)
# build pluto, openscop, cloog

execute_process(
  COMMAND "${CMAKE_CURRENT_SOURCE_DIR}/build_polymer_deps.sh" "${POLYGEIST_PLUTO_DIR}"
  COMMAND_ERROR_IS_FATAL ANY
  )
  # configure the cmake variables for pluto
  include("${CMAKE_CURRENT_SOURCE_DIR}/cmake/AddPluto.cmake")
  include_directories("${PLUTO_INCLUDE_DIR}")
  message(STATUS "Will build and use Polymer-bundled Pluto")
  
  include("${CMAKE_CURRENT_SOURCE_DIR}/cmake/OpenScop.cmake")
  include_directories("${OSL_INCLUDE_DIR}")
  
  include("${CMAKE_CURRENT_SOURCE_DIR}/cmake/CLooG.cmake")
  include_directories("${CLOOG_INCLUDE_DIR}")
  
  set(POLYMER_AVAIL_TARGETS
  PolymerTargetOpenScop
  )
  # elseif(POLYGEIST_POLYMER_ENABLE_POLYFREQ)
  # if (POLYGEIST_POLYMER_ENABLE_ISL)
  message(STATUS "Will build and use Polymer-bundled ISL")
  
  elseif(POLYGEIST_POLYMER_ENABLE_ISL)
  include_directories(${MLIR_MAIN_SRC_DIR}/../polly/lib/External/isl/include)
  # /home/intern24005/code/PolyFreq_build_test/Polygeist/llvm-project/mlir/../polly/lib/External/isl/include
  include_directories(${MLIR_MAIN_SRC_DIR}/../polly/include)
  # /home/intern24005/code/PolyFreq_build_test/Polygeist/llvm-project/mlir/../polly/include
  include_directories(${MLIR_MAIN_SRC_DIR}/../polly/lib/External/isl/include)
  # /home/intern24005/code/PolyFreq_build_test/Polygeist/llvm-project/mlir/../polly/lib/External/isl/include
  include_directories(${MLIR_MAIN_SRC_DIR}/../polly/lib/External/isl/include)
  # /home/intern24005/code/PolyFreq_build_test/Polygeist/llvm-project/mlir/../polly/lib/External/isl/include
  include_directories(${LLVM_BINARY_DIR}/tools/polly/lib/External/isl/include)
  # /home/intern24005/code/PolyFreq_build_test/Polygeist/llvm-project/build/tools/polly/lib/External/isl/include
  #print all the paths added here
  message(STATUS "MLIR_MAIN_SRC_DIR='${MLIR_MAIN_SRC_DIR}'")
  message(STATUS "LLVM_BINARY_DIR='${LLVM_BINARY_DIR}'")
  
  set(POLYMER_AVAIL_TARGETS
  PolymerTargetISL
  )
  else()
  # message(STATUS "Before PolyFreq")
  message(FATAL_ERROR "Need one of POLYGEIST_POLYMER_ENABLE_PLUTO or POLYGEIST_POLYMER_ENABLE_ISL")
  endif()

# ------------------------------------------------- This project
include_directories("${POLYMER_MAIN_INCLUDE_DIR}")
include_directories("${POLYMER_INCLUDE_DIR}")

get_property(dirs DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY INCLUDE_DIRECTORIES)
foreach(dir ${dirs})
message(STATUS "dir='${dir}'")
endforeach()

add_subdirectory(include/polymer)
add_subdirectory(lib)
add_subdirectory(tools)
add_subdirectory(test)

if (NOT LLVM_INSTALL_TOOLCHAIN_ONLY)
  install(DIRECTORY include/polymer
    DESTINATION include
    FILES_MATCHING
    PATTERN "*.h"
    )
endif()
