cmake_minimum_required(VERSION 3.16)
project(cpp-services)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Buscar dependencias
find_package(Threads REQUIRED)

# Ejecutable principal
add_executable(cpp-service main.cpp)
target_link_libraries(cpp-service Threads::Threads)

# Configuracion de compilacion
if(CMAKE_BUILD_TYPE STREQUAL "Debug")
    target_compile_definitions(cpp-service PRIVATE DEBUG_MODE)
endif()
