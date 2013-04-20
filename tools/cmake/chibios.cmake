# make sure the CHIBIOS_SRC variable is empty
set(CHIBIOS_SRC)

# extract the root directory of the ChibiOs CMake files
get_filename_component(CHIBIOS_CMAKE_DIR "${CMAKE_CURRENT_LIST_FILE}" PATH)

# specify the path to ChibiOs
get_filename_component(CHIBIOS_ROOT "${CHIBIOS_CMAKE_DIR}/../.." ABSOLUTE)

# clear compiler and linker flags
set(CMAKE_C_FLAGS)
set(CMAKE_CXX_FLAGS)
set(CMAKE_EXE_LINKER_FLAGS)

# board specific definition
if(NOT CHIBIOS_BOARD_CMAKE_FILE)
    # if the board file is not defined by the project CMake file,
    # add a variable in the cache to allow the user to choose one
    set(CHIBIOS_BOARD_CMAKE_FILE "" CACHE FILEPATH "Board CMake file")
endif()
if(EXISTS "${CHIBIOS_BOARD_CMAKE_FILE}")
    include("${CHIBIOS_BOARD_CMAKE_FILE}")
else()
    message(FATAL_ERROR "The CHIBIOS_BOARD_CMAKE_FILE variable must point to a valid CMake board file")
endif()

# board source files and include path
file(GLOB CHIBIOS_BOARD_SRC "${CHIBIOS_BOARD_PATH}/*.c" "${CHIBIOS_BOARD_PATH}/*.h")
set(CHIBIOS_SRC ${CHIBIOS_SRC} ${CHIBIOS_BOARD_SRC})
include_directories(${CHIBIOS_BOARD_PATH})

# HAL files
set(CHIBIOS_SRC
    ${CHIBIOS_SRC}

    ${CHIBIOS_ROOT}/os/hal/include/adc.h
    ${CHIBIOS_ROOT}/os/hal/include/can.h
    ${CHIBIOS_ROOT}/os/hal/include/ext.h
    ${CHIBIOS_ROOT}/os/hal/include/gpt.h
    ${CHIBIOS_ROOT}/os/hal/include/hal.h
    ${CHIBIOS_ROOT}/os/hal/include/i2c.h
    ${CHIBIOS_ROOT}/os/hal/include/i2s.h
    ${CHIBIOS_ROOT}/os/hal/include/icu.h
    ${CHIBIOS_ROOT}/os/hal/include/io_block.h
    ${CHIBIOS_ROOT}/os/hal/include/io_channel.h
    ${CHIBIOS_ROOT}/os/hal/include/mac.h
    ${CHIBIOS_ROOT}/os/hal/include/mii.h
    ${CHIBIOS_ROOT}/os/hal/include/mmcsd.h
    ${CHIBIOS_ROOT}/os/hal/include/mmc_spi.h
    ${CHIBIOS_ROOT}/os/hal/include/pal.h
    ${CHIBIOS_ROOT}/os/hal/include/pwm.h
    ${CHIBIOS_ROOT}/os/hal/include/rtc.h
    ${CHIBIOS_ROOT}/os/hal/include/sdc.h
    ${CHIBIOS_ROOT}/os/hal/include/serial.h
    ${CHIBIOS_ROOT}/os/hal/include/serial_usb.h
    ${CHIBIOS_ROOT}/os/hal/include/spi.h
    ${CHIBIOS_ROOT}/os/hal/include/tm.h
    ${CHIBIOS_ROOT}/os/hal/include/uart.h
    ${CHIBIOS_ROOT}/os/hal/include/usb_cdc.h
    ${CHIBIOS_ROOT}/os/hal/include/usb.h

    ${CHIBIOS_ROOT}/os/hal/src/adc.c
    ${CHIBIOS_ROOT}/os/hal/src/can.c
    ${CHIBIOS_ROOT}/os/hal/src/ext.c
    ${CHIBIOS_ROOT}/os/hal/src/gpt.c
    ${CHIBIOS_ROOT}/os/hal/src/hal.c
    ${CHIBIOS_ROOT}/os/hal/src/i2c.c
    ${CHIBIOS_ROOT}/os/hal/src/i2s.c
    ${CHIBIOS_ROOT}/os/hal/src/icu.c
    ${CHIBIOS_ROOT}/os/hal/src/mac.c
    ${CHIBIOS_ROOT}/os/hal/src/mmcsd.c
    ${CHIBIOS_ROOT}/os/hal/src/mmc_spi.c
    ${CHIBIOS_ROOT}/os/hal/src/pal.c
    ${CHIBIOS_ROOT}/os/hal/src/pwm.c
    ${CHIBIOS_ROOT}/os/hal/src/rtc.c
    ${CHIBIOS_ROOT}/os/hal/src/sdc.c
    ${CHIBIOS_ROOT}/os/hal/src/serial.c
    ${CHIBIOS_ROOT}/os/hal/src/serial_usb.c
    ${CHIBIOS_ROOT}/os/hal/src/spi.c
    ${CHIBIOS_ROOT}/os/hal/src/tm.c
    ${CHIBIOS_ROOT}/os/hal/src/uart.c
    ${CHIBIOS_ROOT}/os/hal/src/usb.c
)
include_directories(${CHIBIOS_ROOT}/os/hal/include)

# kernel files
set(CHIBIOS_SRC
    ${CHIBIOS_SRC}

    ${CHIBIOS_ROOT}/os/kernel/include/chbsem.h
    ${CHIBIOS_ROOT}/os/kernel/include/chcond.h
    ${CHIBIOS_ROOT}/os/kernel/include/chdebug.h
    ${CHIBIOS_ROOT}/os/kernel/include/chdynamic.h
    ${CHIBIOS_ROOT}/os/kernel/include/chevents.h
    ${CHIBIOS_ROOT}/os/kernel/include/chfiles.h
    ${CHIBIOS_ROOT}/os/kernel/include/ch.h
    ${CHIBIOS_ROOT}/os/kernel/include/chheap.h
    ${CHIBIOS_ROOT}/os/kernel/include/chinline.h
    ${CHIBIOS_ROOT}/os/kernel/include/chlists.h
    ${CHIBIOS_ROOT}/os/kernel/include/chmboxes.h
    ${CHIBIOS_ROOT}/os/kernel/include/chmemcore.h
    ${CHIBIOS_ROOT}/os/kernel/include/chmempools.h
    ${CHIBIOS_ROOT}/os/kernel/include/chmsg.h
    ${CHIBIOS_ROOT}/os/kernel/include/chmtx.h
    ${CHIBIOS_ROOT}/os/kernel/include/chqueues.h
    ${CHIBIOS_ROOT}/os/kernel/include/chregistry.h
    ${CHIBIOS_ROOT}/os/kernel/include/chschd.h
    ${CHIBIOS_ROOT}/os/kernel/include/chsem.h
    ${CHIBIOS_ROOT}/os/kernel/include/chstreams.h
    ${CHIBIOS_ROOT}/os/kernel/include/chsys.h
    ${CHIBIOS_ROOT}/os/kernel/include/chthreads.h
    ${CHIBIOS_ROOT}/os/kernel/include/chvt.h

    ${CHIBIOS_ROOT}/os/kernel/src/chcond.c
    ${CHIBIOS_ROOT}/os/kernel/src/chdebug.c
    ${CHIBIOS_ROOT}/os/kernel/src/chdynamic.c
    ${CHIBIOS_ROOT}/os/kernel/src/chevents.c
    ${CHIBIOS_ROOT}/os/kernel/src/chheap.c
    ${CHIBIOS_ROOT}/os/kernel/src/chlists.c
    ${CHIBIOS_ROOT}/os/kernel/src/chmboxes.c
    ${CHIBIOS_ROOT}/os/kernel/src/chmemcore.c
    ${CHIBIOS_ROOT}/os/kernel/src/chmempools.c
    ${CHIBIOS_ROOT}/os/kernel/src/chmsg.c
    ${CHIBIOS_ROOT}/os/kernel/src/chmtx.c
    ${CHIBIOS_ROOT}/os/kernel/src/chqueues.c
    ${CHIBIOS_ROOT}/os/kernel/src/chregistry.c
    ${CHIBIOS_ROOT}/os/kernel/src/chschd.c
    ${CHIBIOS_ROOT}/os/kernel/src/chsem.c
    ${CHIBIOS_ROOT}/os/kernel/src/chsys.c
    ${CHIBIOS_ROOT}/os/kernel/src/chthreads.c
    ${CHIBIOS_ROOT}/os/kernel/src/chvt.c
)
include_directories(${CHIBIOS_ROOT}/os/kernel/include)

# other include paths
include_directories(${CHIBIOS_ROOT}/os/various)
include_directories(${CHIBIOS_ROOT}/ext)

# debug options
macro(chibios_debug_option variable description flag)
    option(${variable} ${description} FALSE)
    if(${variable})
        add_definitions("-D${flag}")
    endif()
endmacro()
chibios_debug_option(CHIBIOS_DBG_DISABLE_OPTIMIZE_SPEED "Disable speed optimizations in the kernel" CH_OPTIMIZE_SPEED)
chibios_debug_option(CHIBIOS_DBG_ENABLE_CHECKS          "Enable checks on the API parameters"       CH_DBG_ENABLE_CHECKS)
chibios_debug_option(CHIBIOS_DBG_ENABLE_ASSERTS         "Enable the OS internal consistency checks" CH_DBG_ENABLE_ASSERTS)
chibios_debug_option(CHIBIOS_DBG_ENABLE_TRACE           "Enable the trace buffer"                   CH_DBG_ENABLE_TRACE)
chibios_debug_option(CHIBIOS_DBG_ENABLE_STACK_CHECK     "Enable checks on thread stack overflow"    CH_DBG_ENABLE_STACK_CHECK)
chibios_debug_option(CHIBIOS_DBG_SYSTEM_STATE_CHECK     "Enable checks on calls to OS functions"    CH_DBG_SYSTEM_STATE_CHECK)
chibios_debug_option(CHIBIOS_DBG_FILL_THREAD            "Enable threads workspace filling"          CH_DBG_FILL_THREADS)
chibios_debug_option(CHIBIOS_DBG_THREADS_PROFILING      "Enable thread profiling"                   CH_DBG_THREADS_PROFILING)

option(CHIBIOS_GENERATE_HEX_FILE "Generate an Intel HEX file out of the ELF target"  TRUE)
option(CHIBIOS_GENERATE_BIN_FILE "Generate a binary file out of the ELF target"      TRUE)

macro(get_output_type_info type ext full_name)
    if(${type} STREQUAL "ihex")
        set(${ext} "hex")
        set(${full_name} "Intel HEX")
    elseif(${type} STREQUAL "binary")
        set(${ext} "bin")
        set(${full_name} "binary")
    endif()
endmacro()

# main macro - creates a ChibiOs executable target and the corresponding flash target
macro(add_chibios_executable name)

    # create the target
    add_executable(${name} ${ARGN} ${CHIBIOS_SRC})

    # set its extension to ".elf"
    set_target_properties(${name} PROPERTIES SUFFIX ".elf")

    # define the linker script to use for the target
    get_property(L_LINK_FLAGS TARGET ${name} PROPERTY LINK_FLAGS)
    if(LINKER_SCRIPT)
        set(L_LINK_FLAGS "${L_LINK_FLAGS} -T${LINKER_SCRIPT}")
    else()
        set(L_LINK_FLAGS "${L_LINK_FLAGS} -T${DEFAULT_LINKER_SCRIPT}")
    endif()
    set_target_properties(${name} PROPERTIES LINK_FLAGS ${L_LINK_FLAGS})

    set(OUTPUT_TYPES)
    if(CHIBIOS_GENERATE_HEX_FILE)
        set(OUTPUT_TYPES ${OUTPUT_TYPES} "ihex")
    endif()
    if(CHIBIOS_GENERATE_BIN_FILE)
        set(OUTPUT_TYPES ${OUTPUT_TYPES} "binary")
    endif()

    get_property(L_TARGET_LOCATION TARGET ${name} PROPERTY LOCATION)
    get_filename_component(L_TARGET_PATH "${L_TARGET_LOCATION}" PATH)
    get_filename_component(L_TARGET_NAME_WE "${L_TARGET_LOCATION}" NAME_WE)
    get_filename_component(L_TARGET_NAME "${L_TARGET_LOCATION}" NAME)

    foreach(type ${OUTPUT_TYPES})
        # generate an output file out of the ELF target
        get_output_type_info(${type} OUTPUT_EXT OUTPUT_NAME)
        set(OUTPUT_FILE "${L_TARGET_PATH}/${L_TARGET_NAME_WE}.${OUTPUT_EXT}")
        add_custom_command(TARGET ${name} POST_BUILD
            COMMAND ${CMAKE_OBJCOPY} --strip-all --output-target ${type} "${L_TARGET_PATH}/${L_TARGET_NAME}" ${OUTPUT_FILE}
            COMMENT "Generate ${OUTPUT_NAME} file: ${OUTPUT_FILE}"
        )
        set_directory_properties(PROPERTIES ADDITIONAL_MAKE_CLEAN_FILES ${OUTPUT_FILE})
    endforeach()

endmacro()

