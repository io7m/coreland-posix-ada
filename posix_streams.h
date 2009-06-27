#ifndef POSIX_STREAMS_H
#define POSIX_STREAMS_H

#include "_sd_streams.h"

#define POSIX_STREAM_UNSUPPORTED -1

/*
 * Stream request arguments.
 */

#ifndef I_PUSH
#define I_PUSH ((unsigned long)(POSIX_STREAM_UNSUPPORTED))
#endif

#ifndef I_POP
#define I_POP ((unsigned long)(POSIX_STREAM_UNSUPPORTED))
#endif

#ifndef I_LOOK
#define I_LOOK ((unsigned long)(POSIX_STREAM_UNSUPPORTED))
#endif

#ifndef I_FLUSH
#define I_FLUSH ((unsigned long)(POSIX_STREAM_UNSUPPORTED))
#endif

#ifndef I_FLUSHBAND
#define I_FLUSHBAND ((unsigned long)(POSIX_STREAM_UNSUPPORTED))
#endif

#ifndef I_SETSIG
#define I_SETSIG ((unsigned long)(POSIX_STREAM_UNSUPPORTED))
#endif

#ifndef I_GETSIG
#define I_GETSIG ((unsigned long)(POSIX_STREAM_UNSUPPORTED))
#endif

#ifndef I_FIND
#define I_FIND ((unsigned long)(POSIX_STREAM_UNSUPPORTED))
#endif

#ifndef I_PEEK
#define I_PEEK ((unsigned long)(POSIX_STREAM_UNSUPPORTED))
#endif

#ifndef I_SRDOPT
#define I_SRDOPT ((unsigned long)(POSIX_STREAM_UNSUPPORTED))
#endif

#ifndef I_GRDOPT
#define I_GRDOPT ((unsigned long)(POSIX_STREAM_UNSUPPORTED))
#endif

#ifndef I_NREAD
#define I_NREAD ((unsigned long)(POSIX_STREAM_UNSUPPORTED))
#endif

#ifndef I_FDINSERT
#define I_FDINSERT ((unsigned long)(POSIX_STREAM_UNSUPPORTED))
#endif

#ifndef I_STR
#define I_STR ((unsigned long)(POSIX_STREAM_UNSUPPORTED))
#endif

#ifndef I_SWROPT
#define I_SWROPT ((unsigned long)(POSIX_STREAM_UNSUPPORTED))
#endif

#ifndef I_GWROPT
#define I_GWROPT ((unsigned long)(POSIX_STREAM_UNSUPPORTED))
#endif

#ifndef I_SENDFD
#define I_SENDFD ((unsigned long)(POSIX_STREAM_UNSUPPORTED))
#endif

#ifndef I_RECVFD
#define I_RECVFD ((unsigned long)(POSIX_STREAM_UNSUPPORTED))
#endif

#ifndef I_LIST
#define I_LIST ((unsigned long)(POSIX_STREAM_UNSUPPORTED))
#endif

#ifndef I_ATMARK
#define I_ATMARK ((unsigned long)(POSIX_STREAM_UNSUPPORTED))
#endif

#ifndef I_CKBAND
#define I_CKBAND ((unsigned long)(POSIX_STREAM_UNSUPPORTED))
#endif

#ifndef I_GETBAND
#define I_GETBAND ((unsigned long)(POSIX_STREAM_UNSUPPORTED))
#endif

#ifndef I_CANPUT
#define I_CANPUT ((unsigned long)(POSIX_STREAM_UNSUPPORTED))
#endif

#ifndef I_SETCLTIME
#define I_SETCLTIME ((unsigned long)(POSIX_STREAM_UNSUPPORTED))
#endif

#ifndef I_GETCLTIME
#define I_GETCLTIME ((unsigned long)(POSIX_STREAM_UNSUPPORTED))
#endif

#ifndef I_LINK
#define I_LINK ((unsigned long)(POSIX_STREAM_UNSUPPORTED))
#endif

#ifndef I_UNLINK
#define I_UNLINK ((unsigned long)(POSIX_STREAM_UNSUPPORTED))
#endif

#ifndef I_PLINK
#define I_PLINK ((unsigned long)(POSIX_STREAM_UNSUPPORTED))
#endif

#ifndef I_PUNLINK
#define I_PUNLINK ((unsigned long)(POSIX_STREAM_UNSUPPORTED))
#endif

#ifndef FMNAMESZ
#define FMNAMESZ 9
#endif

#ifndef FLUSHR
#define FLUSHR ((unsigned long)(POSIX_STREAM_UNSUPPORTED))
#endif

#ifndef FLUSHW
#define FLUSHW ((unsigned long)(POSIX_STREAM_UNSUPPORTED))
#endif

#ifndef FLUSHRW
#define FLUSHRW ((unsigned long)(POSIX_STREAM_UNSUPPORTED))
#endif

#ifndef S_RDNORM
#define S_RDNORM ((unsigned long)(POSIX_STREAM_UNSUPPORTED))
#endif

#ifndef S_RDBAND
#define S_RDBAND ((unsigned long)(POSIX_STREAM_UNSUPPORTED))
#endif

#ifndef S_INPUT
#define S_INPUT ((unsigned long)(POSIX_STREAM_UNSUPPORTED))
#endif

#ifndef S_HIPRI
#define S_HIPRI ((unsigned long)(POSIX_STREAM_UNSUPPORTED))
#endif

#ifndef S_OUTPUT
#define S_OUTPUT ((unsigned long)(POSIX_STREAM_UNSUPPORTED))
#endif

#ifndef S_WRNORM
#define S_WRNORM ((unsigned long)(POSIX_STREAM_UNSUPPORTED))
#endif

#ifndef S_WRBAND
#define S_WRBAND ((unsigned long)(POSIX_STREAM_UNSUPPORTED))
#endif

#ifndef S_MSG
#define S_MSG ((unsigned long)(POSIX_STREAM_UNSUPPORTED))
#endif

#ifndef S_ERROR
#define S_ERROR ((unsigned long)(POSIX_STREAM_UNSUPPORTED))
#endif

#ifndef S_HANGUP
#define S_HANGUP ((unsigned long)(POSIX_STREAM_UNSUPPORTED))
#endif

#ifndef S_BANDURG
#define S_BANDURG ((unsigned long)(POSIX_STREAM_UNSUPPORTED))
#endif

#endif
