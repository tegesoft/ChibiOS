# STM32 platforms

# path to the STM32 common source files
set(STM32_SRC_ROOT "${CHIBIOS_ROOT}/os/hal/platforms/STM32")

# declare a common feature: it takes a key, the source path and the
# source files for the feature
macro(stm32_declare_feature key src_path)
    set(STM32_FEATURE_${key}_PATH ${src_path})
    foreach(src_file ${ARGN})
        set(STM32_FEATURE_${key}_SRC ${STM32_FEATURE_${key}_SRC} ${src_path}/${src_file})
    endforeach()
endmacro()

# enable a common feature: it takes the feature's key
macro(stm32_enable_feature key)
    include_directories(${STM32_FEATURE_${key}_PATH})
    set(CHIBIOS_SRC ${CHIBIOS_SRC} ${STM32_FEATURE_${key}_SRC})
endmacro()

# common source files and include directoies
set(CHIBIOS_SRC ${CHIBIOS_SRC} ${STM32_SRC_ROOT}/stm32.h)
include_directories(${STM32_SRC_ROOT})

# declare available common feature
stm32_declare_feature(CAN     "${STM32_SRC_ROOT}" can_lld.h can_lld.c)
stm32_declare_feature(EXT     "${STM32_SRC_ROOT}" ext_lld.h ext_lld.c)
stm32_declare_feature(I2S     "${STM32_SRC_ROOT}" i2s_lld.h i2s_lld.c)
stm32_declare_feature(MAC     "${STM32_SRC_ROOT}" mac_lld.h mac_lld.c)
stm32_declare_feature(SDC     "${STM32_SRC_ROOT}" sdc_lld.h sdc_lld.c)
stm32_declare_feature(ICU     "${STM32_SRC_ROOT}/TIMv1" icu_lld.h icu_lld.c)
stm32_declare_feature(GPT     "${STM32_SRC_ROOT}/TIMv1" gpt_lld.h gpt_lld.c)
stm32_declare_feature(PWM     "${STM32_SRC_ROOT}/TIMv1" pwm_lld.h pwm_lld.c)
stm32_declare_feature(SPIv1   "${STM32_SRC_ROOT}/SPIv1" spi_lld.h spi_lld.c)
stm32_declare_feature(SPIv2   "${STM32_SRC_ROOT}/SPIv2" spi_lld.h spi_lld.c)
stm32_declare_feature(GPIOv1  "${STM32_SRC_ROOT}/GPIOv1" pal_lld.h pal_lld.c)
stm32_declare_feature(GPIOv2  "${STM32_SRC_ROOT}/GPIOv2" pal_lld.h pal_lld.c)
stm32_declare_feature(I2Cv1   "${STM32_SRC_ROOT}/I2Cv1" i2c_lld.h i2c_lld.c)
stm32_declare_feature(OTGv1   "${STM32_SRC_ROOT}/OTGv1" stm32_otg.h usb_lld.h usb_lld.c)
stm32_declare_feature(RTCv1   "${STM32_SRC_ROOT}/RTCv1" rtc_lld.h rtc_lld.c)
stm32_declare_feature(RTCv2   "${STM32_SRC_ROOT}/RTCv2" rtc_lld.h rtc_lld.c)
stm32_declare_feature(USARTv1 "${STM32_SRC_ROOT}/USARTv1" serial_lld.h serial_lld.c uart_lld.h uart_lld.c)
stm32_declare_feature(USARTv2 "${STM32_SRC_ROOT}/USARTv2" serial_lld.h serial_lld.c uart_lld.h uart_lld.c)
stm32_declare_feature(USBv1   "${STM32_SRC_ROOT}/USBv1" stm32_usb.h usb_lld.h usb_lld.c)

