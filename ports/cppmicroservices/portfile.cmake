# Common Ambient Variables:
#   CURRENT_BUILDTREES_DIR    = ${VCPKG_ROOT_DIR}\buildtrees\${PORT}
#   CURRENT_PACKAGES_DIR      = ${VCPKG_ROOT_DIR}\packages\${PORT}_${TARGET_TRIPLET}
#   CURRENT_PORT_DIR          = ${VCPKG_ROOT_DIR}\ports\${PORT}
#   PORT                      = current port name (zlib, etc)
#   TARGET_TRIPLET            = current triplet (x86-windows, x64-windows-static, etc)
#   VCPKG_CRT_LINKAGE         = C runtime linkage type (static, dynamic)
#   VCPKG_LIBRARY_LINKAGE     = target library linkage type (static, dynamic)
#   VCPKG_ROOT_DIR            = <C:\path\to\current\vcpkg>
#   VCPKG_TARGET_ARCHITECTURE = target architecture (x64, x86, arm)
#

include(vcpkg_common_functions)

# CPPMicroServices - dev: gdeverlant - branch: port/vcpkg/cppmicroservices
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO gdeverlant/CppMicroServices
    REF 9e879d80b4752f1a290a54b89ab957a9beef3f4c
    SHA512 62273765abf54330f93a90f1eccb26c6d3ed8c352b1c9dfda99e8ed266cd47348b03b72e011cdbcf2db4f011bb1faebcb369a754c64f6e545d143400768aa853
    HEAD_REF port/vcpkg/cppmicroservices
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    # OPTIONS -DUSE_THIS_IN_ALL_BUILDS=1 -DUSE_THIS_TOO=2
    # OPTIONS_RELEASE -DOPTIMIZE=1
    # OPTIONS_DEBUG -DDEBUGGABLE=1
)

vcpkg_install_cmake()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)

message(STATUS "OUT_SOURCE_PATH = ${OUT_SOURCE_PATH}")
message(STATUS "SOURCE_PATH = ${SOURCE_PATH}")
message(STATUS "CURRENT_BUILDTREES_DIR = ${CURRENT_BUILDTREES_DIR}")

 # Tools require dlls
 vcpkg_copy_tool_dependencies(${CURRENT_PACKAGES_DIR}/tools)

# Extract the name of the folder
get_filename_component(FOLDER_NAME "${SOURCE_PATH}" NAME)
# Handle copyright
file(COPY ${CURRENT_BUILDTREES_DIR}/src/${FOLDER_NAME}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/cppmicroservices)
file(RENAME ${CURRENT_PACKAGES_DIR}/share/cppmicroservices/LICENSE ${CURRENT_PACKAGES_DIR}/share/cppmicroservices/copyright)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME cppmicroservices)
