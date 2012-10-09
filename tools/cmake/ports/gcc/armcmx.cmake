
# ARMCMx common
include(${CHIBIOS_CMAKE_DIR}/ports/common/armcmx.cmake)

# source files
set(CHIBIOS_SRC
    ${CHIBIOS_SRC}

    ${CHIBIOS_ROOT}/os/ports/GCC/ARMCMx/chcore.c
    ${CHIBIOS_ROOT}/os/ports/GCC/ARMCMx/chcore.h
    ${CHIBIOS_ROOT}/os/ports/GCC/ARMCMx/chcore_v7m.c
    ${CHIBIOS_ROOT}/os/ports/GCC/ARMCMx/chcore_v7m.h
    ${CHIBIOS_ROOT}/os/ports/GCC/ARMCMx/chtypes.h
    ${CHIBIOS_ROOT}/os/ports/GCC/ARMCMx/crt0.c
)

# include search paths
include_directories(
    ${CHIBIOS_ROOT}/os/ports/GCC/ARMCMx
)

