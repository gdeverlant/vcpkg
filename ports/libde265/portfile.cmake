include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO gdeverlant/libde265
    REF v1.0.3 
    SHA512 1
    HEAD_REF master
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
)
vcpkg_install_cmake()
file(INSTALL ${SOURCE_PATH}/AUTHORS DESTINATION ${CURRENT_PACKAGES_DIR}/share/libde265 RENAME copyright)