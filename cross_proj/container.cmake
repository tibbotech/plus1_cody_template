# Add debugging option
if (${CMAKE_BUILD_TYPE} STREQUAL "Debug")
  add_definitions(-DDEBUG)
endif()



# Set up cross compilation
set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR arm)

#set paths to locations in image. 
set (CHROOT_PATH  /root/disk/)
set (CHROOT_INCLUDE_PATHS ${CHROOT_PATH}/usr/include/
                          ${CHROOT_PATH}/usr/include/ntios)
set (CHROOT_LIB_PATHS     ${CHROOT_PATH}/usr/lib/arm-linux-gnueabihf/)



set (CMAKE_SYSROOT ${CHROOT_PATH})

#set compiler
set(CMAKE_C_COMPILER /usr/bin/arm-linux-gnueabihf-gcc)
set(CMAKE_CXX_COMPILER /usr/bin/arm-linux-gnueabihf-g++)
set(CMAKE_CXX_STANDARD 11)

#set paths for finding libraries. 
#These should always be from the chroot environment.
set (CMAKE_FIND_ROOT_PATH ${CHROOT_PATH})
set( CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER )
set( CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY )
set( CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY )
set( CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY )


include_directories(${CMAKE_SOURCE_DIR}/ 
                    ${CHROOT_INCLUDE_PATHS})

# -----------------------------------------------------------------------------
# Original commands:
# -----------------------------------------------------------------------------
# set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/../output/lib)
# set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/../output/bin)
# -----------------------------------------------------------------------------
# Replaced with (edited by Imcase):
# Note: parameter CMAKE_SOURCE_DIR is defined in /root/ntios/Makefile
# -----------------------------------------------------------------------------
message("---:Executed From: " ${CMAKE_SOURCE_DIR} "/container.cmake")
message("------:set(CMAKE_LIBRARY_OUTPUT_DIRECTORY " ${CMAKE_SOURCE_DIR} "/output/lib)")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/output/lib)
message("------:set(CMAKE_RUNTIME_OUTPUT_DIRECTORY " ${CMAKE_SOURCE_DIR} "/output/bin)")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/output/bin)
