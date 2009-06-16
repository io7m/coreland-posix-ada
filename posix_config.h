#ifndef POSIX_CONFIG_H
#define POSIX_CONFIG_H

/*
 * Configuration for a strictly conforming XSI/POSIX program.
 *
 * The following definitions are required to provide standardized
 * versions of functions as opposed to proprietary GNU extensions.
 */

#define _POSIX_C_SOURCE 200809L
#define _XOPEN_SOURCE   700
#define __BSD_VISIBLE   1
#define __USE_XOPEN
#undef  _GNU_SOURCE

#endif
