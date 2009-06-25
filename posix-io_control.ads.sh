#!/bin/sh

cat LICENSE       || exit 1
cat auto-warn.txt || exit 1
cat <<EOF
with POSIX.C_Types;
use type POSIX.C_Types.Int_t;

with POSIX.Error;
with POSIX.File;

--# inherit POSIX.C_Types,
--#         POSIX.Error,
--#         POSIX.Errno,
--#         POSIX.File;

package POSIX.IO_Control is

  -- subprogram_map : ioctl
  procedure Push_Module
    (Descriptor  : in     File.Valid_Descriptor_t;
     Name        : in     String;
     Error_Value :    out Error.Error_t);
  --# global in Errno.Errno_Value;
  --# derives Error_Value from Descriptor, Name, Errno.Errno_Value;

private

  subtype Request_t is C_Types.Int_t
    range C_Types.Int_t'First .. C_Types.Int_t'Last;

EOF

I_PUSH=`./constants I_PUSH`           || exit 1
I_POP=`./constants I_POP`             || exit 1
I_LOOK=`./constants I_LOOK`           || exit 1
I_FLUSH=`./constants I_FLUSH`         || exit 1
I_FLUSHBAND=`./constants I_FLUSHBAND` || exit 1
I_SETSIG=`./constants I_SETSIG`       || exit 1
I_GETSIG=`./constants I_GETSIG`       || exit 1
I_FIND=`./constants I_FIND`           || exit 1
I_PEEK=`./constants I_PEEK`           || exit 1
I_SRDOPT=`./constants I_SRDOPT`       || exit 1
I_GRDOPT=`./constants I_GRDOPT`       || exit 1
I_NREAD=`./constants I_NREAD`         || exit 1
I_FDINSERT=`./constants I_FDINSERT`   || exit 1
I_STR=`./constants I_STR`             || exit 1
I_SWROPT=`./constants I_SWROPT`       || exit 1
I_GWROPT=`./constants I_GWROPT`       || exit 1
I_SENDFD=`./constants I_SENDFD`       || exit 1
I_RECVFD=`./constants I_RECVFD`       || exit 1
I_LIST=`./constants I_LIST`           || exit 1
I_ATMARK=`./constants I_ATMARK`       || exit 1
I_CKBAND=`./constants I_CKBAND`       || exit 1
I_GETBAND=`./constants I_GETBAND`     || exit 1
I_CANPUT=`./constants I_CANPUT`       || exit 1
I_SETCLTIME=`./constants I_SETCLTIME` || exit 1
I_GETCLTIME=`./constants I_GETCLTIME` || exit 1
I_LINK=`./constants I_LINK`           || exit 1
I_UNLINK=`./constants I_UNLINK`       || exit 1
I_PLINK=`./constants I_PLINK`         || exit 1
I_PUNLINK=`./constants I_PUNLINK`     || exit 1

cat <<EOF
  Unsupported : constant Request_t := -1;

  I_PUSH      : constant Request_t := $I_PUSH;
  I_POP       : constant Request_t := $I_POP;
  I_LOOK      : constant Request_t := $I_LOOK;
  I_FLUSH     : constant Request_t := $I_FLUSH;
  I_FLUSHBAND : constant Request_t := $I_FLUSHBAND;
  I_SETSIG    : constant Request_t := $I_SETSIG;
  I_GETSIG    : constant Request_t := $I_GETSIG;
  I_FIND      : constant Request_t := $I_FIND;
  I_PEEK      : constant Request_t := $I_PEEK;
  I_SRDOPT    : constant Request_t := $I_SRDOPT;
  I_GRDOPT    : constant Request_t := $I_GRDOPT;
  I_NREAD     : constant Request_t := $I_NREAD;
  I_FDINSERT  : constant Request_t := $I_FDINSERT;
  I_STR       : constant Request_t := $I_STR;
  I_SWROPT    : constant Request_t := $I_SWROPT;
  I_GWROPT    : constant Request_t := $I_GWROPT;
  I_SENDFD    : constant Request_t := $I_SENDFD;
  I_RECVFD    : constant Request_t := $I_RECVFD;
  I_LIST      : constant Request_t := $I_LIST;
  I_ATMARK    : constant Request_t := $I_ATMARK;
  I_CKBAND    : constant Request_t := $I_CKBAND;
  I_GETBAND   : constant Request_t := $I_GETBAND;
  I_CANPUT    : constant Request_t := $I_CANPUT;
  I_SETCLTIME : constant Request_t := $I_SETCLTIME;
  I_GETCLTIME : constant Request_t := $I_GETCLTIME;
  I_LINK      : constant Request_t := $I_LINK;
  I_UNLINK    : constant Request_t := $I_UNLINK;
  I_PLINK     : constant Request_t := $I_PLINK;
  I_PUNLINK   : constant Request_t := $I_PUNLINK;

  function Check_Request_Support (Request : in Request_t) return Boolean;
  --# return Request = -1;

end POSIX.IO_Control;
EOF
