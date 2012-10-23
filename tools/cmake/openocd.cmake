# define the OpenOCD configuration files to use
set(OPENOCD_INTERFACE_CFG "" CACHE FILEPATH "OpenOCD interface configuration file")
set(OPENOCD_TARGET_CFG "" CACHE FILEPATH "OpenOCD target/board configuration file")

# create a flash target using OpenOCD
macro(add_flash_target target_to_flash)

    # try to locate OpenOCD
    find_program(
        OPENOCD_EXE
        NAMES openocd openocd-0.6.0 openocd.exe openocd-0.6.0.exe
        PATHS ${OPENOCD_ROOT}
        DOC "OpenOCD program"
    )
    if(OPENOCD_EXE)
        message(STATUS "Found OpenOCD: ${OPENOCD_EXE}.")

        # add the flash target
        get_property(TARGET_LOCATION TARGET ${target_to_flash} PROPERTY LOCATION)
        set(OPENOCD_ARGS
            -f ${OPENOCD_INTERFACE_CFG}
            -f ${OPENOCD_TARGET_CFG}
            -c \"init\"
            -c \"reset init\"
            -c \"flash write_image erase ${TARGET_LOCATION}\"
            -c \"shutdown\"
        )
        add_custom_target(flash-${target_to_flash} ${OPENOCD_EXE} ${OPENOCD_ARGS} DEPENDS ${target_to_flash})
    else()
        message(STATUS "OpenOCD not found, no flash target will be created for ${target_to_flash} (add the OPENOCD_ROOT variable if OpenOCD is not in a default path).")
    endif()

endmacro()

