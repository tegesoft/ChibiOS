
# gcc ARMCMx common
include(${CHIBIOS_CMAKE_DIR}/ports/gcc/armcmx.cmake)

# source files
set(CHIBIOS_SRC
    ${CHIBIOS_SRC}
    ${CHIBIOS_ROOT}/os/ports/GCC/ARMCMx/STM32F1xx/cmparams.h
    ${CHIBIOS_ROOT}/os/ports/GCC/ARMCMx/STM32F1xx/vectors.c
)
include_directories(
    ${CHIBIOS_ROOT}/os/ports/GCC/ARMCMx/STM32F1xx
)

# set the type of CPU
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -mcpu=cortex-m3 -mthumb")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -mcpu=cortex-m3 -mthumb")
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -nostartfiles -mcpu=cortex-m3 -mthumb")

