include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO gdeverlant/libde265
    REF v1.0.3 
    SHA512 0153632afcc9733950e8354997ccd93eddad90e8e0f7362bfe49b93b11cb1756cf803d0ba5c07042aee80e18227613af768ca82baf7891c687edf5e253a129c4
    HEAD_REF master
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
)

vcpkg_install_cmake()
file(INSTALL ${SOURCE_PATH}/AUTHORS DESTINATION ${CURRENT_PACKAGES_DIR}/share/libde265 RENAME copyright)