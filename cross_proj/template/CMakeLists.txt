cmake_minimum_required(VERSION 3.0.0)
project(ntios_tests VERSION 0.1.0)

message("---------------CMake: Configure START---------------")

string(CONCAT CONTAINER_CMAKE_PATH ${CMAKE_SOURCE_DIR}/container.cmake)

include(${CONTAINER_CMAKE_PATH})

message("----------------------" ${LINK_DIRECTORIES} "----------------------------" )

link_directories(${CHROOT_PATH}/usr/lib/arm-linux-gnueabihf/)
add_executable('****project_name****' '****cpp_files****')
target_compile_options('****project_name****' PRIVATE -include  ${CHROOT_PATH}/usr/include/ntios/threads/ntios_includes.h)
link_directories(${CHROOT_PATH}/lib/arm-linux-gnueabihf )
target_link_libraries('****project_name****' ntios_beep ntios_beepchannel ntios_pmux ntios_threads ntios_sysfsfunc ntios_fd ntios_romfile ntios_ssi ntios_ssichannel ntios_math ntios_conv ntios_aes ntios_datetime ntios_strman ntios_md5 ntios_sha1 ntios_rc4 ntios_libtest ntios_base ntios_gpiodfunc ntios_stor ntios_serial ntios_sys ntios_pat ntios_patchannel ntios_io pthread rt)

message("---------------CMake: Configure END---------------")
