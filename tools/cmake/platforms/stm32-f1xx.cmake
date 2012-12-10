# STM32-F1xx (except F105 and F107) platforms

# STM32 common
include(${CHIBIOS_CMAKE_DIR}/platforms/stm32.cmake)

# enable STM32 common features
stm32_enable_feature(CAN)
stm32_enable_feature(EXT)
stm32_enable_feature(GPT)
stm32_enable_feature(ICU)
stm32_enable_feature(MAC)
stm32_enable_feature(PWM)
stm32_enable_feature(SDC)
stm32_enable_feature(SPIv1)
stm32_enable_feature(GPIOv1)
stm32_enable_feature(I2Cv1)
stm32_enable_feature(RTCv1)
stm32_enable_feature(USARTv1)
stm32_enable_feature(USBv1)

# F1xx specific source files
set(CHIBIOS_SRC
    ${CHIBIOS_SRC}

    ${CHIBIOS_ROOT}/os/hal/platforms/STM32F1xx/adc_lld.c
    ${CHIBIOS_ROOT}/os/hal/platforms/STM32F1xx/adc_lld.h
    ${CHIBIOS_ROOT}/os/hal/platforms/STM32F1xx/ext_lld_isr.c
    ${CHIBIOS_ROOT}/os/hal/platforms/STM32F1xx/ext_lld_isr.h
    ${CHIBIOS_ROOT}/os/hal/platforms/STM32F1xx/hal_lld.c
    ${CHIBIOS_ROOT}/os/hal/platforms/STM32F1xx/hal_lld_f100.h
    ${CHIBIOS_ROOT}/os/hal/platforms/STM32F1xx/hal_lld_f103.h
    ${CHIBIOS_ROOT}/os/hal/platforms/STM32F1xx/hal_lld.h
    ${CHIBIOS_ROOT}/os/hal/platforms/STM32F1xx/stm32_dma.c
    ${CHIBIOS_ROOT}/os/hal/platforms/STM32F1xx/stm32_dma.h
    ${CHIBIOS_ROOT}/os/hal/platforms/STM32F1xx/stm32f10x.h
    ${CHIBIOS_ROOT}/os/hal/platforms/STM32F1xx/stm32_isr.h
    ${CHIBIOS_ROOT}/os/hal/platforms/STM32F1xx/stm32_rcc.h
 )

# include search paths
include_directories(
    ${CHIBIOS_ROOT}/os/hal/platforms/STM32F1xx
)

