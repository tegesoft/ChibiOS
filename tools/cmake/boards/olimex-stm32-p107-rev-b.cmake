# Olimex STM32-P107 (rev. B) board

# platform files and flags
include(${CHIBIOS_CMAKE_DIR}/platforms/stm32-f105-107.cmake)
include(${CHIBIOS_CMAKE_DIR}/ports/gcc/stm32-f107.cmake)

# path to the board files
set(CHIBIOS_BOARD_PATH "${CHIBIOS_ROOT}/boards/OLIMEX_STM32_P107_REV_B")

# openocd flags
set(OPENOCD_TARGET "stm32f1x")
set(OPENOCD_BOARD "olimex_stm32_p107")

