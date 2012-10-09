#include <stddef.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/times.h>
#include <sys/types.h>
#include <ff.h>
#include <ch.h>

#ifndef MAX_FILE_COUNT
    #define MAX_FILE_COUNT 5
#endif
static FIL files[MAX_FILE_COUNT];
static int busy[MAX_FILE_COUNT] = {0};

void* _sbrk(ptrdiff_t size)
{
    void* ptr = chCoreAlloc((size_t)size);
    if (ptr)
    {
        return ptr;
    }
    else
    {
        errno = ENOMEM;
        return NULL;
    }
}

int _open(const char* filename, int flags, int mode)
{
    int slot;
    FIL* file;
    BYTE openFlags;

    (void)mode;

    /* find an empty slot */
    for (slot = 0; slot < MAX_FILE_COUNT; ++slot)
    {
        if (!busy[slot])
        {
            file = &files[slot];
            break;
        }
    }
    if (slot == MAX_FILE_COUNT)
    {
        errno = EMFILE;
        return -1;
    }

    /* convert the flags */
    openFlags = 0;
    if (flags & O_RDONLY)
        openFlags |= FA_READ;
    if (flags & O_WRONLY)
        openFlags |= FA_WRITE;
    if (flags & O_RDWR)
        openFlags |= FA_READ | FA_WRITE;
    if ((flags & O_CREAT) && (flags & O_EXCL))
        openFlags |= FA_CREATE_NEW;
    if (flags & O_TRUNC)
        openFlags |= FA_CREATE_ALWAYS;

    /* open the file */
    if (f_open(file, filename, openFlags) != FR_OK)
    {
        errno = EACCES;
        return -1;
    }

    busy[slot] = 1;
    return slot;
}

_off_t _lseek(int fd, _off_t offset, int direction)
{
    DWORD position = 0;

    if ((fd < 0) || (fd >= MAX_FILE_COUNT) || !busy[fd])
    {
        errno = EBADF;
        return -1;
    }

    /* compute the absolute offset from the beginning of the file */
    switch (direction)
    {
        case SEEK_SET:
            position = offset;
            break;

        case SEEK_CUR:
            position = f_tell(&files[fd]) + offset;
            break;

        case SEEK_END:
            position = f_size(&files[fd]) - offset;
            break;

        default:
            errno = EINVAL;
            return -1;
    }

    /* seek */
    if (f_lseek(&files[fd], position) != FR_OK)
    {
        errno = EBADF;
        return -1;
    }

    /* return the current position */
    return position;
}

_ssize_t _read(int fd, void* data, size_t size)
{
    UINT bytesRead = 0;

    if ((fd < 0) || (fd >= MAX_FILE_COUNT) || !busy[fd])
    {
        errno = EBADF;
        return -1;
    }

    if (f_read(&files[fd], data, size, &bytesRead) != FR_OK)
    {
        errno = EINVAL;
        return -1;
    }

    return bytesRead;
}

_ssize_t _write(int fd, const void* data, size_t size)
{
    UINT bytesWritten = 0;

    if ((fd < 0) || (fd >= MAX_FILE_COUNT) || !busy[fd])
    {
        errno = EBADF;
        return -1;
    }

    if (f_write(&files[fd], data, size, &bytesWritten) != FR_OK)
    {
        errno = EINVAL;
        return -1;
    }

    return bytesWritten;
}

int _close(int fd)
{
    if ((fd < 0) || (fd >= MAX_FILE_COUNT) || !busy[fd])
    {
        errno = EBADF;
        return -1;
    }

    if (f_close(&files[fd]) != FR_OK)
    {
        errno = EBADF;
        return -1;
    }

    busy[fd] = 0;
    return 0;
}

int _fstat(int fd, struct stat* st)
{
    (void)fd;
    memset(st, 0, sizeof(*st));
    st->st_mode = S_IFCHR;
    return 0;
}

int _isatty(int fd)
{
    (void)fd;
    return 1;
}
