set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_C_COMPILER arm-none-eabi-gcc)
set(CMAKE_ASM_COMPILER arm-none-eabi-gcc)
set(CMAKE_EXE_LINKER_FLAGS "--specs=nosys.specs" CACHE INTERNAL "")

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

add_compile_options(
    #-mcpu=cortex-m4    
    #-mfloat-abi=hard
    #-mfpu=fpv4-sp-d16
    --specs=nano.specs    
    #-mthumb
    #$<$<CONFIG:DEBUG>:-g3>   
    #-Wall
    #-Wextra
    #-Wconversion
    #-Wsign-conversion
    #-std=c99    
    #-Og
    #-ffunction-sections
    #-fdata-sections
    #-fstack-usage
    #-fcyclomatic-complexity  
)

add_link_options(
    #-mcpu=cortex-m4
    --specs=nano.specs
    #-mfloat-abi=hard
    #-mfpu=fpv4-sp-d16    
    #-mthumb
    #-u_printf_float
    #-u_scanf_float
    #-Wl,-Map=${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}.map
    #-static    
    -Wl,--gc-sections,--print-memory-usage        
    -Wl,--start-group -lc -lm -Wl,--end-group
)

add_compile_definitions(
    -DHSE_VALUE=16000000U
    -DSTM32L4R9xx
    -DSTM32
    -DUSE_FULL_LL_DRIVER
    -DREV_0C
    $<$<CONFIG:DEBUG>:-DDEBUG>    
    $<$<CONFIG:RELEASE>:-DRELEASE>    
    $<$<CONFIG:BOOTLOADER>:-DBOOTLOADER>    
)


