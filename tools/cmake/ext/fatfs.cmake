# FatFs (file system access)

set(CHIBIOS_SRC
    ${CHIBIOS_SRC}
    ${CHIBIOS_ROOT}/os/various/fatfs_bindings/fatfs_diskio.c
    ${CHIBIOS_ROOT}/os/various/fatfs_bindings/fatfs_syscall.c

    ${CHIBIOS_ROOT}/ext/fatfs/src/diskio.h
    ${CHIBIOS_ROOT}/ext/fatfs/src/ff.h
    ${CHIBIOS_ROOT}/ext/fatfs/src/integer.h

    ${CHIBIOS_ROOT}/ext/fatfs/src/ff.c
    ${CHIBIOS_ROOT}/ext/fatfs/src/option/ccsbcs.c

    ${CHIBIOS_ROOT}/tools/syscalls_newlib_fatfs.c
)

include_directories(${CHIBIOS_ROOT}/ext/fatfs/src)

