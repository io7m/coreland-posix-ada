#include <sys/types.h>

#include <limits.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

enum kind_t {
  DISCRETE_RANGED,
  DISCRETE_MOD
};

struct discrete_t {
  /*@observer@*/ char *name_ada;
  long        bound_low;
  long        bound_high;
  int         bound_base;
  size_t      size;
  enum kind_t kind;
};

static const struct discrete_t type_table[] = {
  /* signed integral types */
  { "Char",  -CHAR_MAX, CHAR_MAX, 10, sizeof (char) * CHAR_BIT,  DISCRETE_RANGED },
  { "Short", -SHRT_MAX, SHRT_MAX, 10, sizeof (short) * CHAR_BIT, DISCRETE_RANGED },
  { "Int",    -INT_MAX,  INT_MAX, 10, sizeof (int) * CHAR_BIT,   DISCRETE_RANGED },
  { "Long",  -LONG_MAX, LONG_MAX, 10, sizeof (long) * CHAR_BIT,  DISCRETE_RANGED },

  /* unsigned integral types */
  { "Unsigned_Char",  0, 0, 10, sizeof (unsigned char) * CHAR_BIT,  DISCRETE_MOD },
  { "Unsigned_Short", 0, 0, 10, sizeof (unsigned short) * CHAR_BIT, DISCRETE_MOD },
  { "Unsigned_Int",   0, 0, 10, sizeof (unsigned int) * CHAR_BIT,   DISCRETE_MOD },
  { "Unsigned_Long",  0, 0, 10, sizeof (unsigned long) * CHAR_BIT,  DISCRETE_MOD },

  /* specific integral types */
  { "Return_Value",         -1,         0, 10, sizeof (int) * CHAR_BIT,     DISCRETE_RANGED },
  { "Descriptor",           -1,   INT_MAX, 10, sizeof (int) * CHAR_BIT,     DISCRETE_RANGED },
  { "Open_Flags",            0,   INT_MAX, 10, sizeof (int) * CHAR_BIT,     DISCRETE_MOD },
  { "Errno_Int",      -INT_MAX,   INT_MAX, 10, sizeof (int) * CHAR_BIT,     DISCRETE_RANGED },
  { "Mode",                  0,    07777l,  8, sizeof (mode_t) * CHAR_BIT,  DISCRETE_RANGED },
  { "Size",                  0,         0,  0, sizeof (size_t) * CHAR_BIT,  DISCRETE_MOD },
  { "Signed_Size",  -SSIZE_MAX, SSIZE_MAX, 10, sizeof (ssize_t) * CHAR_BIT, DISCRETE_RANGED },
};
static const size_t type_table_size = sizeof (type_table) / sizeof (struct discrete_t);

/*
 * Print definition for ranged type. Print bound_low and bound_high
 * as base bound_base. Type Size attribute is set to size bits.
 */

static void
int_type (const char *name, long bound_low, long bound_high, int bound_base, size_t size)
{
  (void) printf ("  %s_Size : constant Positive := %u;\n", name, (unsigned int) size);

  switch (bound_base) {
    case 8:
      if (bound_low < 0) {
        (void) printf ("  type %s_t is range 8#-%lo# .. 8#%lo#;\n",
          name, (unsigned long) labs (bound_low), (unsigned long) bound_high);
      } else {
        (void) printf ("  type %s_t is range 8#%lo# .. 8#%lo#;\n",
          name, (unsigned long) bound_low, (unsigned long) bound_high);
      }
      break;
    case 10:
      if (bound_low < 0) {
        (void) printf ("  type %s_t is range -%ld .. %ld;\n",
          name, labs (bound_low), bound_high);
      } else {
        (void) printf ("  type %s_t is range %ld .. %ld;\n",
          name, bound_low, bound_high);
      }
      break;
    case 16:
      if (bound_low < 0) {
        (void) printf ("  type %s_t is range 16#%lx# .. 16#%lx#;\n",
          name, (unsigned long) labs (bound_low), (unsigned long) bound_high);
      } else {
        (void) printf ("  type %s_t is range 16#-%lx# .. 16#%lx#;\n",
          name, (unsigned long) bound_low, (unsigned long) bound_high);
      }
      break;
    default:
      (void) fprintf (stderr, "fatal: invalid number base\n");
      exit (EXIT_FAILURE);
  }

  (void) printf ("  for %s_t'Size use %s_Size;\n", name, name);
  (void) printf ("  pragma Convention (C, %s_t);\n", name);
}

/*
 * Print definition for modular type. Type Size attribute is set to size bits.
 */

static void
mod_type (const char *name, size_t size)
{
  (void) printf ("  %s_Size : constant Positive := %u;\n", name, (unsigned int) size);
  (void) printf ("  type %s_t is mod 2 ** %u;\n", name, (unsigned int) size);
  (void) printf ("  for %s_t'Size use %s_Size;\n", name, name);
  (void) printf ("  pragma Convention (C, %s_t);\n", name);
}

int
main (int argc, char *argv[])
{
  const struct discrete_t *dtype;
  size_t index;

  if (argc < 2) {
    (void) fprintf (stderr, "usage: type\n");
    exit (EXIT_FAILURE);
  }

  for (index = 0; index < type_table_size; ++index) {
    dtype = &type_table [index];
    if (strcmp (argv[1], dtype->name_ada) == 0) {
      switch (dtype->kind) {
        case DISCRETE_RANGED:
          int_type
           (dtype->name_ada,
            dtype->bound_low,
            dtype->bound_high,
            dtype->bound_base,
            dtype->size);
          exit (EXIT_SUCCESS);
        case DISCRETE_MOD:
          mod_type (dtype->name_ada, dtype->size);
          exit (EXIT_SUCCESS);
        default:
          (void) fprintf (stderr, "fatal: unknown discrete type kind\n");
          exit (EXIT_FAILURE); 
      }
    }
  }

  (void) fprintf (stderr, "fatal: unknown type\n");
  exit (EXIT_FAILURE); 

  /*@notreached@*/
  return 0;
}
