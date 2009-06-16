#include "posix_config.h"

#include <err.h>
#include <limits.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/*
 * Print compile time value of named constants.
 */

static const struct {
  enum number_type_t {
    SIGNED_LONG,
    UNSIGNED_LONG
  } number_type;
  union number_t {
    long lo;
    unsigned long ulo;
  } number;
  const char *name;
} constants[] = {
  { SIGNED_LONG, { PATH_MAX },       "PATH_MAX" },
  { SIGNED_LONG, { LOGIN_NAME_MAX }, "LOGIN_NAME_MAX" },
};
const unsigned int constants_size = sizeof (constants) / sizeof (constants [0]);

int
main (int argc, char *argv[])
{
  unsigned int index;
  unsigned int exit_code = EXIT_FAILURE;

  if (argc < 2) return EXIT_FAILURE;

  for (index = 0; index < constants_size; ++index) {
    if (strcmp (constants [index].name, argv [1]) == 0) {
      switch (constants [index].number_type) {
        case SIGNED_LONG: (void) printf ("%ld", constants [index].number.lo); break;
        case UNSIGNED_LONG: (void) printf ("%lu", constants [index].number.ulo); break;
      }
      exit_code = EXIT_SUCCESS;
    }
  }

  (void) fflush (NULL);

  if (exit_code != EXIT_SUCCESS) {
    errx (EXIT_FAILURE, "could not determine value of %s", argv[1]);
  } else {
    exit (EXIT_SUCCESS);
  }

  /*@notreached@*/
  return 0;
}
