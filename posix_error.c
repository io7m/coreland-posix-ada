#include <errno.h>

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
