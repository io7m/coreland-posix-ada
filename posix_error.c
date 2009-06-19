#include "posix_config.h"

#include <errno.h>
#include <string.h>

int
posix_errno_get (void)
{
  return errno;
}

void
posix_errno_set (int e)
{
  errno = e;
}

void
posix_errno_reset (void)
{
  errno = 0;
}

size_t
posix_strerror_r (int error_code, char *buffer, size_t buffer_size)
{
  int r = strerror_r (error_code, buffer, buffer_size);
  if (r == 0) {
    return strlen (buffer);
  } else {
    return 1;
  }
}
