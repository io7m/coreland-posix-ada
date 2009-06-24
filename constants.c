#include "posix_config.h"

#include <sys/types.h>
#include <sys/stat.h>

#include <err.h>
#include <limits.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

/*
 * Print compile time value of named constants.
 */

/*
 * Compile-time constants.
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
} compile_time_constants[] = {
  { SIGNED_LONG,   { PATH_MAX }, "PATH_MAX" },

  { SIGNED_LONG,   { SEEK_SET }, "SEEK_SET" },
  { SIGNED_LONG,   { SEEK_CUR }, "SEEK_CUR" },
  { SIGNED_LONG,   { SEEK_END }, "SEEK_END" },

  { UNSIGNED_LONG, { S_IRUSR }, "S_IRUSR" },
  { UNSIGNED_LONG, { S_IWUSR }, "S_IWUSR" },
  { UNSIGNED_LONG, { S_IXUSR }, "S_IXUSR" },
  { UNSIGNED_LONG, { S_IRGRP }, "S_IRGRP" },
  { UNSIGNED_LONG, { S_IWGRP }, "S_IWGRP" },
  { UNSIGNED_LONG, { S_IXGRP }, "S_IXGRP" },
  { UNSIGNED_LONG, { S_IROTH }, "S_IROTH" },
  { UNSIGNED_LONG, { S_IWOTH }, "S_IWOTH" },
  { UNSIGNED_LONG, { S_IXOTH }, "S_IXOTH" },
  { UNSIGNED_LONG, { S_ISUID }, "S_ISUID" },
  { UNSIGNED_LONG, { S_ISGID }, "S_ISGID" },

  /* Maximum value for ORd mode */
  { UNSIGNED_LONG, { S_IRUSR | S_IWUSR | S_IXUSR |
                     S_IRGRP | S_IWGRP | S_IXGRP |
                     S_IROTH | S_IWOTH | S_IXOTH |
                     S_ISUID | S_ISGID }, "S_IMAX" },
};
const unsigned int compile_time_constants_size =
  sizeof (compile_time_constants) / sizeof (compile_time_constants [0]);

/*
 * Run-time constants.
 */

static const struct {
  unsigned int constant;
  const char *name;
} run_time_constants[] = {
  { _SC_LOGIN_NAME_MAX, "LOGIN_NAME_MAX" },
};
const unsigned int run_time_constants_size =
  sizeof (run_time_constants) / sizeof (run_time_constants [0]);

int
main (int argc, char *argv[])
{
  unsigned int index;
  unsigned int exit_code = EXIT_FAILURE;

  if (argc < 2) return EXIT_FAILURE;

  /* Check for compile-time constant by name. */
  for (index = 0; index < compile_time_constants_size; ++index) {
    if (strcmp (compile_time_constants [index].name, argv [1]) == 0) {
      switch (compile_time_constants [index].number_type) {
        case SIGNED_LONG: (void) printf ("%ld", compile_time_constants [index].number.lo); break;
        case UNSIGNED_LONG: (void) printf ("%lu", compile_time_constants [index].number.ulo); break;
      }
      exit_code = EXIT_SUCCESS;
    }
  }

  /* Check for run-time constant by name. */
  if (exit_code != EXIT_SUCCESS) {
    for (index = 0; index < run_time_constants_size; ++index) {
      if (strcmp (run_time_constants [index].name, argv [1]) == 0) {
        (void) printf ("%ld", sysconf (run_time_constants [index].constant));
        exit_code = EXIT_SUCCESS;
      }
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
