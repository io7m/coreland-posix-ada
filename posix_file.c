#include "posix_config.h"

#include <fcntl.h>
#include <stdio.h>

int
main (void)
{
  (void) printf (
"  O_RDONLY   : constant Open_Flag_Integer_t := 16#%lx#;\n"
"  O_WRONLY   : constant Open_Flag_Integer_t := 16#%lx#;\n"
"  O_NONBLOCK : constant Open_Flag_Integer_t := 16#%lx#;\n"
"  O_APPEND   : constant Open_Flag_Integer_t := 16#%lx#;\n"
"  O_CREAT    : constant Open_Flag_Integer_t := 16#%lx#;\n"
"  O_EXCL     : constant Open_Flag_Integer_t := 16#%lx#;\n"
"  O_TRUNC    : constant Open_Flag_Integer_t := 16#%lx#;\n",
  (unsigned long) O_RDONLY,
  (unsigned long) O_WRONLY,
  (unsigned long) O_NONBLOCK,
  (unsigned long) O_APPEND,
  (unsigned long) O_CREAT,
  (unsigned long) O_EXCL,
  (unsigned long) O_TRUNC);

  return 0;
}
