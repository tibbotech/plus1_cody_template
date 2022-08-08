cmake_minimum_required(VERSION 3.0.0)
project(ntios VERSION 0.1.0)

set(CMAKE_BUILD_TYPE Debug)

file(MAKE_DIRECTORY ${CMAKE_SOURCE_DIR}/output)
file(MAKE_DIRECTORY ${CMAKE_SOURCE_DIR}/output/lib)
file(MAKE_DIRECTORY ${CMAKE_SOURCE_DIR}/output/lib/inc)
file(MAKE_DIRECTORY ${CMAKE_SOURCE_DIR}/output/bin)


add_subdirectory(tbt13)
