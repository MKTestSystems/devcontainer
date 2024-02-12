set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

if("${CMAKE_BUILD_TYPE}" STREQUAL Release OR "${CMAKE_BUILD_TYPE}" STREQUAL Debug) 
    
    message("******DEBUG/RELEASE BUILD TOOLCHAIN*******")
    set(CMAKE_SYSTEM_NAME Generic)
    message(FATAL_ERROR, "set CMAKE_SYSTEM_VERSION below")  
    set(CMAKE_SYSTEM_VERSION Cortex-M4-STM32L4R9)
    set(CMAKE_C_COMPILER arm-none-eabi-gcc)
    set(CMAKE_ASM_COMPILER arm-none-eabi-gcc)
    set(CMAKE_EXE_LINKER_FLAGS "--specs=nosys.specs" CACHE INTERNAL "")

    add_compile_definitions(
        $<$<CONFIG:DEBUG>:-DDEBUG>    
        $<$<CONFIG:RELEASE>:-DRELEASE>    
        $<$<CONFIG:BOOTLOADER>:-DBOOTLOADER>
    )

    message(FATAL_ERROR, "set cpu below")    
    message(FATAL_ERROR, "set fpu options below")
    #see https://gcc.gnu.org/onlinedocs/gcc/ARM-Options.html
    # https://gcc.gnu.org/onlinedocs/gcc/Option-Summary.html
    add_compile_options(
        #-mcpu=cortex-m4    #cpu eg: 'cortex-m3' or 'cortex-m4'
        #-mfloat-abi=hard   #'hard' for hardware fpu, otherwise 'soft'
        #-mfpu=fpv4-sp-d16  #fpu eg: 'vfpv3-fp16' or 'fpv4-sp-d16'
        --specs=nano.specs    
        -mthumb
        $<$<CONFIG:DEBUG>:-g3>   
        -Wall                       #enable common warnings
        -Wextra                     #enable more warnings
        -Wconversion                #warn about type conversions that may change value
        $<$<CONFIG:RELEASE>:-Werror #treat warnings as errors (release builds)
        -std=c99                    #use the c99 standard
        $<$<CONFIG:DEBUG>:-Og       #optimise for debug (debug builds)

        -ffunction-sections         #put each output into own section (allows for linking smaller images)
        -fdata-sections
        -fstack-usage
        #-fcyclomatic-complexity  
    )

    message(FATAL_ERROR, "define linker scripts below")
    #see https://sourceware.org/binutils/docs-2.16/ld/Options.html
    add_link_options(
        --specs=nano.specs        
        -mthumb
        -u_printf_float
        -u_scanf_float
        -static    
        -Wl,--gc-sections, 
        -Wl,--print-memory-usage                    #don't put unused functions in
        -Wl,--start-group -lc -lm -Wl,--end-group    #link libc, libm
        $<$<CONFIG:DEBUG>:-T${CMAKE_CURRENT_LIST_DIR}/link/DEBUG_LINKER_SCRIPT_HERE.ld>    
        $<$<CONFIG:RELEASE>:-T${CMAKE_CURRENT_LIST_DIR}/link/RELEASE_LINKER_SCRIPT_HERE.ld>    
    )


else()

    message("******TEST BUILD TOOLCHAIN*******")
    set(CMAKE_SYSTEM_NAME Generic)
    set(CMAKE_C_COMPILER gcc)
    set(CMAKE_ASM_COMPILER gcc)
  
    add_link_options(
        -Wl,--gc-sections,--print-memory-usage        
        -Wl,--start-group -lc -lm -Wl,--end-group
    )

endif()