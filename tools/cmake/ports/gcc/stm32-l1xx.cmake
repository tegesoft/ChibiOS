
# gcc ARMCMx common
include(${CHIBIOS_CMAKE_DIR}/ports/gcc/armcmx.cmake)

# source files
set(CHIBIOS_SRC
    ${CHIBIOS_SRC}
    ${CHIBIOS_ROOT}/os/ports/GCC/ARMCMx/STM32L1xx/cmparams.h
    ${CHIBIOS_ROOT}/os/ports/GCC/ARMCMx/STM32L1xx/vectors.c
)
include_directories(
    ${CHIBIOS_ROOT}/os/ports/GCC/ARMCMx/STM32L1xx
)

# set the type of CPU
set(CPU_FLAGS "-mcpu=cortex-m3 -mthumb")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${CPU_FLAGS}")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${CPU_FLAGS}")
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} ${CPU_FLAGS} -nostartfiles")

