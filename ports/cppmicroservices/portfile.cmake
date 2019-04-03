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

# CPPMicroServices - dev: gdeverlant - branch: port/5801/cppmicroservices
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO gdeverlant/CppMicroServices
    REF b4dd3f8f35f9283f224c7112c3f58e7583c875e3
    SHA512 f9f21df6dd8f5659d50484b2163dcd018febf08e2224826b8f06494f98a11fb80e6e3c8b380b99ee754315505cc390ccfc6668a949462efe62a6ed2b2afb010b
    HEAD_REF port/5801/cppmicroservices
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    #PREFER_NINJA # Disable this option if project cannot be built with Ninja
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
#vcpkg_copy_tool_dependencies(${CURRENT_PACKAGES_DIR}/tools)

# Extract the name of the folder
get_filename_component(FOLDER_NAME "${SOURCE_PATH}" NAME)
# Handle copyright
file(COPY ${CURRENT_BUILDTREES_DIR}/src/${FOLDER_NAME}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/cppmicroservices)
file(RENAME ${CURRENT_PACKAGES_DIR}/share/cppmicroservices/LICENSE ${CURRENT_PACKAGES_DIR}/share/cppmicroservices/copyright)

<<<<<<< HEAD

file(GLOB EXES_RELEASE
    ${CURRENT_PACKAGES_DIR}/tools/cppmicroservices4/usResourceCompiler4.exe
    ${CURRENT_PACKAGES_DIR}/tools/cppmicroservices4/usShell4.exe
)
file(GLOB EXES_DEBUG
    ${CURRENT_PACKAGES_DIR}/debug/tools/cppmicroservices4/usResourceCompiler4.exe
    ${CURRENT_PACKAGES_DIR}/debug/tools/cppmicroservices4/usShell4.exe
)

# file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/tools/cppmicroservices4)
# file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/tools/cppmicroservices4/debug)

 # Drop a copy of tools
 file(COPY ${EXES_RELEASE} DESTINATION ${CURRENT_PACKAGES_DIR}/tools/cppmicroservices4)
 file(COPY ${EXES_DEBUG} DESTINATION ${CURRENT_PACKAGES_DIR}/tools/cppmicroservices4/debug)

 # Tools require dlls
#  vcpkg_copy_tool_dependencies(${CURRENT_PACKAGES_DIR}/tools/cppmicroservices4)
#  vcpkg_copy_tool_dependencies(${CURRENT_PACKAGES_DIR}/tools/cppmicroservices4/debug)

 #file(REMOVE ${EXES_RELEASE} ${EXES_DEBUG})

=======
>>>>>>> dev/gdeverlant/port/imgui
# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME cppmicroservices)
