#include "posix_config.h"

#include <fcntl.h>
#include <stdio.h>

/*
 * Hack: For platforms that don't fully implement IEEE 1003.1-2008
 *       yet, define an invalid value that will cause Open to return
 *       an error at runtime.
 */

#define O_INVALID_FLAG 0xffffffffL

#ifndef O_CLOEXEC
#  define O_CLOEXEC O_INVALID_FLAG
#endif

#ifndef O_DIRECTORY
#  define O_DIRECTORY O_INVALID_FLAG
#endif

#ifndef O_EXEC
#  define O_EXEC O_INVALID_FLAG
#endif

#ifndef O_SEARCH
#  define O_SEARCH O_INVALID_FLAG
#endif

#ifndef O_TTY_INIT
#  define O_TTY_INIT O_INVALID_FLAG
#endif

int
main (void)
{
  (void) printf (
"  O_APPEND    : constant Open_Flag_Integer_t := 16#%lx#;\n"
"  O_CLOEXEC   : constant Open_Flag_Integer_t := 16#%lx#;\n"
"  O_CREAT     : constant Open_Flag_Integer_t := 16#%lx#;\n"
"  O_DIRECTORY : constant Open_Flag_Integer_t := 16#%lx#;\n"
"  O_EXCL      : constant Open_Flag_Integer_t := 16#%lx#;\n"
"  O_EXEC      : constant Open_Flag_Integer_t := 16#%lx#;\n"
"  O_NOCTTY    : constant Open_Flag_Integer_t := 16#%lx#;\n"
"  O_NOFOLLOW  : constant Open_Flag_Integer_t := 16#%lx#;\n"
"  O_NONBLOCK  : constant Open_Flag_Integer_t := 16#%lx#;\n"
"  O_RDONLY    : constant Open_Flag_Integer_t := 16#%lx#;\n"
"  O_RDWR      : constant Open_Flag_Integer_t := 16#%lx#;\n"
"  O_SEARCH    : constant Open_Flag_Integer_t := 16#%lx#;\n"
"  O_TRUNC     : constant Open_Flag_Integer_t := 16#%lx#;\n"
"  O_TTY_INIT  : constant Open_Flag_Integer_t := 16#%lx#;\n"
"  O_WRONLY    : constant Open_Flag_Integer_t := 16#%lx#;\n",
  (unsigned long) O_APPEND,
  (unsigned long) O_CLOEXEC,
  (unsigned long) O_CREAT,
  (unsigned long) O_DIRECTORY,
  (unsigned long) O_EXCL,
  (unsigned long) O_EXEC,
  (unsigned long) O_NOCTTY,
  (unsigned long) O_NOFOLLOW,
  (unsigned long) O_NONBLOCK,
  (unsigned long) O_RDONLY,
  (unsigned long) O_RDWR,
  (unsigned long) O_SEARCH,
  (unsigned long) O_TRUNC,
  (unsigned long) O_TTY_INIT,
  (unsigned long) O_WRONLY);

  return 0;
}
