#ifndef POSIX_STREAMS_H
#define POSIX_STREAMS_H

#include "_sd_streams.h"

/*
 * Stream request arguments.
 */

#ifndef I_PUSH
#define I_PUSH ((unsigned long)(-1))
#endif

#ifndef I_POP
#define I_POP ((unsigned long)(-1))
#endif

#ifndef I_LOOK
#define I_LOOK ((unsigned long)(-1))
#endif

#ifndef I_FLUSH
#define I_FLUSH ((unsigned long)(-1))
#endif

#ifndef I_FLUSHBAND
#define I_FLUSHBAND ((unsigned long)(-1))
#endif

#ifndef I_SETSIG
#define I_SETSIG ((unsigned long)(-1))
#endif

#ifndef I_GETSIG
#define I_GETSIG ((unsigned long)(-1))
#endif

#ifndef I_FIND
#define I_FIND ((unsigned long)(-1))
#endif

#ifndef I_PEEK
#define I_PEEK ((unsigned long)(-1))
#endif

#ifndef I_SRDOPT
#define I_SRDOPT ((unsigned long)(-1))
#endif

#ifndef I_GRDOPT
#define I_GRDOPT ((unsigned long)(-1))
#endif

#ifndef I_NREAD
#define I_NREAD ((unsigned long)(-1))
#endif

#ifndef I_FDINSERT
#define I_FDINSERT ((unsigned long)(-1))
#endif

#ifndef I_STR
#define I_STR ((unsigned long)(-1))
#endif

#ifndef I_SWROPT
#define I_SWROPT ((unsigned long)(-1))
#endif

#ifndef I_GWROPT
#define I_GWROPT ((unsigned long)(-1))
#endif

#ifndef I_SENDFD
#define I_SENDFD ((unsigned long)(-1))
#endif

#ifndef I_RECVFD
#define I_RECVFD ((unsigned long)(-1))
#endif

#ifndef I_LIST
#define I_LIST ((unsigned long)(-1))
#endif

#ifndef I_ATMARK
#define I_ATMARK ((unsigned long)(-1))
#endif

#ifndef I_CKBAND
#define I_CKBAND ((unsigned long)(-1))
#endif

#ifndef I_GETBAND
#define I_GETBAND ((unsigned long)(-1))
#endif

#ifndef I_CANPUT
#define I_CANPUT ((unsigned long)(-1))
#endif

#ifndef I_SETCLTIME
#define I_SETCLTIME ((unsigned long)(-1))
#endif

#ifndef I_GETCLTIME
#define I_GETCLTIME ((unsigned long)(-1))
#endif

#ifndef I_LINK
#define I_LINK ((unsigned long)(-1))
#endif

#ifndef I_UNLINK
#define I_UNLINK ((unsigned long)(-1))
#endif

#ifndef I_PLINK
#define I_PLINK ((unsigned long)(-1))
#endif

#ifndef I_PUNLINK
#define I_PUNLINK ((unsigned long)(-1))
#endif

#endif
