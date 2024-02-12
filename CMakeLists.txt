cmake_minimum_required(VERSION 3.27)

set(CMAKE_TOOLCHAIN_FILE ${CMAKE_SOURCE_DIR}/toolchain.cmake)

project(<NAME> LANGUAGES C ASM)

if(${CMAKE_BUILD_TYPE} STREQUAL Test)

  add_subdirectory(test)

else()

  add_executable(${PROJECT_NAME})

  target_include_directories(${PROJECT_NAME} PUBLIC
    ${CMAKE_SOURCE_DIR}/inc
  )

  add_subdirectory(src)

  set_target_properties(${PROJECT_NAME} PROPERTIES
    SUFFIX .elf
  )

  add_custom_command(TARGET ${PROJECT_NAME}
    POST_BUILD
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
    COMMAND ${CMAKE_OBJCOPY} ARGS -O ihex ${PROJECT_NAME}.elf ${PROJECT_NAME}.hex
    COMMAND ${CMAKE_OBJCOPY} ARGS -O binary ${PROJECT_NAME}.elf ${PROJECT_NAME}.bin
  )

  target_link_options(${PROJECT_NAME} PUBLIC
    -Wl,-Map=${CMAKE_BINARY_DIR}/${PROJECT_NAME}.map
  )

endif()


