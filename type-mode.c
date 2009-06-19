#include "posix_config.h"

#include <sys/types.h>
#include <sys/stat.h>

#include <limits.h>
#include <stdio.h>
#include <stdlib.h>

/*
 * The S_* mode macros are guaranteed to correspond to positive
 * powers of 2.
 */

int
main (int argc, char *argv[])
{
  const mode_t mode_max =
    S_IRUSR | S_IWUSR | S_IXUSR |
    S_IRGRP | S_IWGRP | S_IXGRP |
    S_IROTH | S_IWOTH | S_IXOTH |
    S_ISUID | S_ISGID | S_ISVTX;

  (void) printf ("  type Mode_Integer_t is mod 8#%o# + 1;\n", mode_max);
  (void) printf ("  for Mode_Integer_t'Size use %u;\n", sizeof (mode_t) * CHAR_BIT);
  (void) printf ("  pragma Convention (C, Mode_Integer_t);\n");

  return 0;
}
