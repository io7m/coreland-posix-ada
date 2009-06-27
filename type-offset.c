#include <sys/types.h>
#include <stdio.h>
#include <limits.h>

int
main (void)
{
  const unsigned long long bits       = sizeof (off_t) * CHAR_BIT;
  const unsigned long long shift_bits = bits - 1;
  const unsigned long long off_max    = 1LL << shift_bits;

  (void) printf ("  type Offset_t is range -%llu .. %llu;\n", off_max, off_max);
  (void) printf ("  for Offset_t'Size use %llu;\n", bits);
  (void) printf ("  pragma Convention (C, Offset_t);\n");

  return 0;
}
