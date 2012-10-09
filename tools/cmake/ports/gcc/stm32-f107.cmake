
# gcc ARMCMx STM32 F1xx common
include(${CHIBIOS_CMAKE_DIR}/ports/gcc/stm32-f1xx.cmake)

# set the linker script
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -T${CHIBIOS_ROOT}/os/ports/GCC/ARMCMx/STM32F1xx/ld/STM32F107xC.ld")

