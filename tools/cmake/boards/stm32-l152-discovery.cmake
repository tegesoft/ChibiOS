# STM32-L152 Discovery board

# platform files and flags
include(${CHIBIOS_CMAKE_DIR}/platforms/stm32-l1xx.cmake)
include(${CHIBIOS_CMAKE_DIR}/ports/gcc/stm32-l1xx.cmake)

# path to the board files
set(CHIBIOS_BOARD_PATH "${CHIBIOS_ROOT}/boards/ST_STM32L_DISCOVERY")
