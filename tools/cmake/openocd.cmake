# define the OpenOCD flashing interface
set(OPENOCD_INTERFACE "" CACHE STRING "Name of the OpenOCD interface")

# create a flash target using OpenOCD
macro(add_flash_target target_to_flash board target)

    # try to locate OpenOCD
    find_program(
        OPENOCD_EXE
        NAMES openocd openocd-0.6.0 openocd.exe openocd-0.6.0.exe
        PATHS ${OPENOCD_ROOT}
        DOC "OpenOCD program"
    )
    if(OPENOCD_EXE)
        message(STATUS "Found OpenOCD: ${OPENOCD_EXE}.")

        # make sure that the interface is set
        if(OPENOCD_INTERFACE)

            # find the path of the configuration files
            if(CMAKE_HOST_SYSTEM_NAME MATCHES "Windows")
                get_filename_component(OPENOCD_CFG_PATH ${OPENOCD_EXE} PATH)
                get_filename_component(OPENOCD_CFG_PATH "${OPENOCD_CFG_PATH}/../scripts" ABSOLUTE) # normalize the path
            elseif(CMAKE_HOST_SYSTEM_NAME MATCHES "Linux")
                set(OPENOCD_CFG_PATH "/usr/share/openocd/scripts")
            endif()

            # set the configuration scripts to pass to OpenOCD
            set(OPENOCD_INTERFACE_CFG "interface/${OPENOCD_INTERFACE}.cfg")
            set(OPENOCD_BOARD_CFG "board/${board}.cfg")
            if (NOT EXISTS "${OPENOCD_CFG_PATH}/${OPENOCD_BOARD_CFG}")
                set(OPENOCD_BOARD_CFG "target/${target}.cfg") # no board script, fallback to target
            endif()

            # make sure that the configuration files exist
            if (NOT EXISTS "${OPENOCD_CFG_PATH}/${OPENOCD_INTERFACE_CFG}")
                message(FATAL_ERROR "File ${OPENOCD_CFG_PATH}/${OPENOCD_INTERFACE_CFG} does not exist!")
            endif()
            if (NOT EXISTS "${OPENOCD_CFG_PATH}/${OPENOCD_BOARD_CFG}")
                message(FATAL_ERROR "File ${OPENOCD_CFG_PATH}/${OPENOCD_BOARD_CFG} does not exist!")
            endif()

            # add the flash target
            get_property(TARGET_LOCATION TARGET ${target_to_flash} PROPERTY LOCATION)
            set(OPENOCD_ARGS
                -f ${OPENOCD_INTERFACE_CFG}
                -f ${OPENOCD_BOARD_CFG}
                -c \"init\"
                -c \"reset init\"
                -c \"flash write_image erase ${TARGET_LOCATION}\"
                -c \"shutdown\"
            )
            add_custom_target(flash-${target_to_flash} ${OPENOCD_EXE} ${OPENOCD_ARGS} DEPENDS ${target_to_flash})
        else()
            message(STATUS "OPENOCD_INTERFACE variable not set, no flash target will be created for ${target_to_flash}")
        endif()
    else()
        message(STATUS "OpenOCD not found, no flash target will be created for ${target_to_flash} (add the OPENOCD_ROOT variable if OpenOCD is not in a default path).")
    endif()

endmacro()

