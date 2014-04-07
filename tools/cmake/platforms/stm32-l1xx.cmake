# STM32-F1xx (except F105 and F107) platforms

# STM32 common
include(${CHIBIOS_CMAKE_DIR}/platforms/stm32.cmake)

# enable STM32 common features
stm32_enable_feature(EXT)
stm32_enable_feature(GPT)
stm32_enable_feature(ICU)
stm32_enable_feature(PWM)
stm32_enable_feature(SPIv1)
stm32_enable_feature(GPIOv2)
stm32_enable_feature(I2Cv1)
stm32_enable_feature(RTCv2)
stm32_enable_feature(USARTv1)
stm32_enable_feature(USBv1)

# L1xx specific source files
set(CHIBIOS_SRC
    ${CHIBIOS_SRC}

    ${CHIBIOS_ROOT}/os/hal/platforms/STM32L1xx/adc_lld.c
    ${CHIBIOS_ROOT}/os/hal/platforms/STM32L1xx/adc_lld.h
    ${CHIBIOS_ROOT}/os/hal/platforms/STM32L1xx/ext_lld_isr.c
    ${CHIBIOS_ROOT}/os/hal/platforms/STM32L1xx/ext_lld_isr.h
    ${CHIBIOS_ROOT}/os/hal/platforms/STM32L1xx/hal_lld.c
    ${CHIBIOS_ROOT}/os/hal/platforms/STM32L1xx/hal_lld.h
    ${CHIBIOS_ROOT}/os/hal/platforms/STM32L1xx/stm32_dma.c
    ${CHIBIOS_ROOT}/os/hal/platforms/STM32L1xx/stm32_dma.h
    ${CHIBIOS_ROOT}/os/hal/platforms/STM32L1xx/stm32l1xx.h
    ${CHIBIOS_ROOT}/os/hal/platforms/STM32L1xx/stm32_isr.h
    ${CHIBIOS_ROOT}/os/hal/platforms/STM32L1xx/stm32_rcc.h
 )

# include search paths
include_directories(
    ${CHIBIOS_ROOT}/os/hal/platforms/STM32L1xx
)

