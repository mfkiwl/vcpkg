vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO KhronosGroup/OpenCL-Headers
    REF "${VERSION}"
    SHA512 41730e80b267de45db9d7a3bcf9e0f29bfc86b25475a86d50180a7258e1240fc8c8f2ad3e222b03b3ef50c10ef63fb5b1647c056fec615e87965aa3196e8ac60
    HEAD_REF main
)

file(INSTALL "${SOURCE_PATH}/CL" DESTINATION ${CURRENT_PACKAGES_DIR}/include)

# OpenCL C++ headers
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO KhronosGroup/OpenCL-CLHPP
    REF "${VERSION}"
    SHA512 30252a832287375d550a5e184779881d5b22207a636298c7f52f277c219d3a1ae6983259cfea7bf4f90f0840fec114ee0e7a8c1e6a6fe48c24fd3b5119e7a7f8
    HEAD_REF main
)

file(INSTALL "${SOURCE_PATH}/include/CL" DESTINATION ${CURRENT_PACKAGES_DIR}/include)

# OpenCL ICD loader
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO KhronosGroup/OpenCL-ICD-Loader
    REF "${VERSION}"
    SHA512 e418b8f3cccb4716ed44acd0677afb96705f8b40a7714d483f1efe1a9b835f4a823c5a80f8457e72c8004f76d8a07c45d9cca55b699dd2fdaa6fe9f8cc863cbd
    HEAD_REF main
)

string(COMPARE EQUAL ${VCPKG_CRT_LINKAGE} dynamic USE_DYNAMIC_VCXX_RUNTIME)

vcpkg_cmake_configure(
    SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
        -DOPENCL_ICD_LOADER_HEADERS_DIR=${CURRENT_PACKAGES_DIR}/include
)

vcpkg_cmake_build(TARGET OpenCL)

if (VCPKG_LIBRARY_LINKAGE STREQUAL static)
  if (NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "release")
    file(INSTALL "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/${VCPKG_TARGET_STATIC_LIBRARY_PREFIX}OpenCL${VCPKG_TARGET_STATIC_LIBRARY_SUFFIX}" DESTINATION ${CURRENT_PACKAGES_DIR}/lib)
  endif()
  if (NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "debug")
    file(INSTALL "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/${VCPKG_TARGET_STATIC_LIBRARY_PREFIX}OpenCL${VCPKG_TARGET_STATIC_LIBRARY_SUFFIX}" DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib)
  endif()
else()
  if(VCPKG_TARGET_IS_WINDOWS)
    if (NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "release")
      file(INSTALL "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/${VCPKG_TARGET_SHARED_LIBRARY_PREFIX}OpenCL${VCPKG_TARGET_IMPORT_LIBRARY_SUFFIX}" DESTINATION ${CURRENT_PACKAGES_DIR}/lib)
      file(INSTALL "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/${VCPKG_TARGET_SHARED_LIBRARY_PREFIX}OpenCL${VCPKG_TARGET_SHARED_LIBRARY_SUFFIX}" DESTINATION ${CURRENT_PACKAGES_DIR}/bin)
    endif()
    if (NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "debug")
      file(INSTALL "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/${VCPKG_TARGET_SHARED_LIBRARY_PREFIX}OpenCL${VCPKG_TARGET_IMPORT_LIBRARY_SUFFIX}" DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib)
      file(INSTALL "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/${VCPKG_TARGET_SHARED_LIBRARY_PREFIX}OpenCL${VCPKG_TARGET_SHARED_LIBRARY_SUFFIX}" DESTINATION ${CURRENT_PACKAGES_DIR}/debug/bin)
    endif()
  elseif(VCPKG_TARGET_IS_LINUX)
    if (NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "release")
      file(INSTALL "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/${VCPKG_TARGET_SHARED_LIBRARY_PREFIX}OpenCL${VCPKG_TARGET_SHARED_LIBRARY_SUFFIX}" DESTINATION ${CURRENT_PACKAGES_DIR}/lib)
      file(INSTALL "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/${VCPKG_TARGET_SHARED_LIBRARY_PREFIX}OpenCL${VCPKG_TARGET_SHARED_LIBRARY_SUFFIX}.1" DESTINATION ${CURRENT_PACKAGES_DIR}/lib)
      file(INSTALL "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/${VCPKG_TARGET_SHARED_LIBRARY_PREFIX}OpenCL${VCPKG_TARGET_SHARED_LIBRARY_SUFFIX}.1.2" DESTINATION ${CURRENT_PACKAGES_DIR}/lib)
    endif()
    if (NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "debug")
      file(INSTALL "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/${VCPKG_TARGET_SHARED_LIBRARY_PREFIX}OpenCL${VCPKG_TARGET_SHARED_LIBRARY_SUFFIX}" DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib)
      file(INSTALL "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/${VCPKG_TARGET_SHARED_LIBRARY_PREFIX}OpenCL${VCPKG_TARGET_SHARED_LIBRARY_SUFFIX}.1" DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib)
      file(INSTALL "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/${VCPKG_TARGET_SHARED_LIBRARY_PREFIX}OpenCL${VCPKG_TARGET_SHARED_LIBRARY_SUFFIX}.1.2" DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib)
    endif()
  elseif(VCPKG_TARGET_IS_OSX)
    if (NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "release")
      file(INSTALL "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/${VCPKG_TARGET_SHARED_LIBRARY_PREFIX}OpenCL${VCPKG_TARGET_SHARED_LIBRARY_SUFFIX}" DESTINATION ${CURRENT_PACKAGES_DIR}/lib)
    endif()
    if (NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "debug")
      file(INSTALL "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/${VCPKG_TARGET_SHARED_LIBRARY_PREFIX}OpenCL${VCPKG_TARGET_SHARED_LIBRARY_SUFFIX}" DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib)
    endif()
  endif()
endif()

vcpkg_copy_pdbs()

file(COPY ${CMAKE_CURRENT_LIST_DIR}/usage DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT})
file(INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
file(COPY ${CMAKE_CURRENT_LIST_DIR}/vcpkg-cmake-wrapper.cmake DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT})
