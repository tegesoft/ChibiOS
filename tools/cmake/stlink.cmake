# try to locate the ST-LINK command line utility
find_program(
    STLINK_CLI_EXE
    NAMES ST-LINK_CLI
    PATHS ${STLINK_ROOT}
    DOC "ST-LINK CLI program"
)
if(STLINK_CLI_EXE)
    message("Found ST-LINK CLI: ${STLINK_CLI_EXE}.")
else()
    message(FATAL_ERROR "ST-LINK CLI not found.")
endif()

# helper macro to create a target using ST-LINK CLI
macro(create_stlink_target custom_name target_to_flash)
    add_custom_target(
        ${custom_name}
        ${STLINK_CLI_EXE}
        ${ARGN}
        DEPENDS ${target_to_flash}
    )
endmacro()

# get the .bin output file of the given target
# NOTE: this depends on what the add_chibios_executable function does...
macro(get_target_bin_file target filename)
    get_property(L_TARGET_LOCATION TARGET ${target} PROPERTY LOCATION)
    get_filename_component(L_TARGET_PATH "${L_TARGET_LOCATION}" PATH)
    get_filename_component(L_TARGET_NAME_WE "${L_TARGET_LOCATION}" NAME_WE)
    set(${filename} "${L_TARGET_PATH}/${L_TARGET_NAME_WE}.bin")
endmacro()

# create a flash-xxx target
macro(add_flash_target target_to_flash)
    get_target_bin_file(${target_to_flash} L_BIN_FILENAME)
    create_stlink_target(
        flash-${target_to_flash}
        ${target_to_flash}
        -c
        -ME
        -P \"${L_BIN_FILENAME}\" 0x08000000
        -V \"after_programming\"
    )
endmacro()

# create a flash-and-run-xxx target
macro(add_flash_and_run_target target_to_flash)
    get_target_bin_file(${target_to_flash} L_BIN_FILENAME)
    create_stlink_target(
        flash-and-run-${target_to_flash}
        ${target_to_flash}
        -c
        -ME
        -P \"${L_BIN_FILENAME}\" 0x08000000
        -V \"after_programming\"
        -Rst
        -Run
    )
endmacro()
