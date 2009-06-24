#include "posix_config.h"
#include "posix_ioctl.h"

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

  /* ioctl constants */
  { SIGNED_LONG, { I_PUSH      }, "I_PUSH" },
  { SIGNED_LONG, { I_POP       }, "I_POP" },
  { SIGNED_LONG, { I_LOOK      }, "I_LOOK" },
  { SIGNED_LONG, { I_FLUSH     }, "I_FLUSH" },
  { SIGNED_LONG, { I_FLUSHBAND }, "I_FLUSHBAND" },
  { SIGNED_LONG, { I_SETSIG    }, "I_SETSIG" },
  { SIGNED_LONG, { I_GETSIG    }, "I_GETSIG" },
  { SIGNED_LONG, { I_FIND      }, "I_FIND" },
  { SIGNED_LONG, { I_PEEK      }, "I_PEEK" },
  { SIGNED_LONG, { I_SRDOPT    }, "I_SRDOPT" },
  { SIGNED_LONG, { I_GRDOPT    }, "I_GRDOPT" },
  { SIGNED_LONG, { I_NREAD     }, "I_NREAD" },
  { SIGNED_LONG, { I_FDINSERT  }, "I_FDINSERT" },
  { SIGNED_LONG, { I_STR       }, "I_STR" },
  { SIGNED_LONG, { I_SWROPT    }, "I_SWROPT" },
  { SIGNED_LONG, { I_GWROPT    }, "I_GWROPT" },
  { SIGNED_LONG, { I_SENDFD    }, "I_SENDFD" },
  { SIGNED_LONG, { I_RECVFD    }, "I_RECVFD" },
  { SIGNED_LONG, { I_LIST      }, "I_LIST" },
  { SIGNED_LONG, { I_ATMARK    }, "I_ATMARK" },
  { SIGNED_LONG, { I_CKBAND    }, "I_CKBAND" },
  { SIGNED_LONG, { I_GETBAND   }, "I_GETBAND" },
  { SIGNED_LONG, { I_CANPUT    }, "I_CANPUT" },
  { SIGNED_LONG, { I_SETCLTIME }, "I_SETCLTIME" },
  { SIGNED_LONG, { I_GETCLTIME }, "I_GETCLTIME" },
  { SIGNED_LONG, { I_LINK      }, "I_LINK" },
  { SIGNED_LONG, { I_UNLINK    }, "I_UNLINK" },
  { SIGNED_LONG, { I_PLINK     }, "I_PLINK" },
  { SIGNED_LONG, { I_PUNLINK   }, "I_PUNLINK" },
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
