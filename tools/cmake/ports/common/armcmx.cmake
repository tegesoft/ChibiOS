
# source files
set(CHIBIOS_SRC
    ${CHIBIOS_SRC}
    ${CHIBIOS_ROOT}/os/ports/common/ARMCMx/nvic.c
    ${CHIBIOS_ROOT}/os/ports/common/ARMCMx/nvic.h
)

# include search paths
include_directories(
    ${CHIBIOS_ROOT}/os/ports/common/ARMCMx/CMSIS/include
    ${CHIBIOS_ROOT}/os/ports/common/ARMCMx
)

