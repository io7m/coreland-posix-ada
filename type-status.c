#include "posix_config.h"

#include <sys/types.h>
#include <sys/stat.h>

#include <limits.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int
main (int argc, char *argv[])
{
  const size_t size = sizeof (struct stat);

  if (argc < 2) {
    (void) fprintf (stderr, "usage: type\n");
    exit (EXIT_FAILURE);
  }

  printf ("  type %s_Element_t is mod 2 ** %u;\n", argv[1], CHAR_BIT);
  printf ("  for %s_Element_t'Size use %u;\n", argv[1], CHAR_BIT);
  printf ("  pragma Convention (C, %s_Element_t);\n", argv[1]);
  printf ("\n");

  printf ("  subtype %s_Element_Index_t is Positive range 1 .. %u;\n", argv[1], size);
  printf ("  type %s_t is array (%s_Element_Index_t) of %s_Element_t;\n", argv[1], argv[1], argv[1]);
  printf ("  for %s_t'Size use %u;\n", argv[1], size * CHAR_BIT);
  printf ("  pragma Convention (C, %s_t);\n", argv[1]);

  return 0;
}
