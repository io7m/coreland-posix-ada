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
EOF

FMNAMESZ=`./constants FMNAMESZ` || exit 1

cat <<EOF

  Minimum_Name_Size : constant Positive := ${FMNAMESZ} + 1;

  subtype Name_Buffer_Index_t is Positive range 1 .. Minimum_Name_Size;
  subtype Name_Buffer_t       is String (Name_Buffer_Index_t);

  -- subprogram_map : ioctl
  procedure Push_Module
    (Descriptor  : in     File.Valid_Descriptor_t;
     Name        : in     String;
     Error_Value :    out Error.Error_t);
  --# global in Errno.Errno_Value;
  --# derives Error_Value from Descriptor, Name, Errno.Errno_Value;

  -- subprogram_map : ioctl
  procedure Pop_Module
    (Descriptor  : in     File.Valid_Descriptor_t;
     Error_Value :    out Error.Error_t);
  --# global in Errno.Errno_Value;
  --# derives Error_Value from Descriptor, Errno.Errno_Value;

  -- subprogram_map : ioctl
  procedure Look_Module
    (Descriptor  : in     File.Valid_Descriptor_t;
     Name_Buffer :    out Name_Buffer_t;
     Name_Last   :    out Name_Buffer_Index_t;
     Error_Value :    out Error.Error_t);
  --# global in Errno.Errno_Value;
  --# derives Name_Buffer, Name_Last from Descriptor &
  --#         Error_Value            from Descriptor, Errno.Errno_Value;

  type Queue_Type_t is
    (Flush_Read_Queues,
     Flush_Write_Queues,
     Flush_Read_Write_Queues);

  -- subprogram_map : ioctl
  procedure Flush
    (Descriptor  : in     File.Valid_Descriptor_t;
     Queues      : in     Queue_Type_t;
     Error_Value :    out Error.Error_t);
  --# global in Errno.Errno_Value;
  --# derives Error_Value from Descriptor, Queues, Errno.Errno_Value;

EOF

./type-discrete Priority_Band || exit 1

cat <<EOF

  -- subprogram_map : ioctl
  procedure Flush_Band
    (Descriptor  : in     File.Valid_Descriptor_t;
     Priority    : in     Priority_Band_t;
     Queues      : in     Queue_Type_t;
     Error_Value :    out Error.Error_t);
  --# global in Errno.Errno_Value;
  --# derives Error_Value from Descriptor, Priority, Queues, Errno.Errno_Value;

  type Event_Selector_t is
    (Normal_Message,
     Priority_Band_Message,
     Input_Message,
     High_Priority_Message,
     Write_Queue_Space_Available,
     Write_Queue_Priority_Space_Available,
     Signal_Message,
     Error_Message,
     Hangup_Message,
     Urgent);

  type Events_t is array (Event_Selector_t) of Boolean;

  -- subprogram_map : ioctl
  procedure Set_Signal_Events
    (Descriptor  : in     File.Valid_Descriptor_t;
     Events      : in     Events_t;
     Error_Value :    out Error.Error_t);
  --# global in Errno.Errno_Value;
  --# derives Error_Value from Descriptor, Events, Errno.Errno_Value;

  -- subprogram_map : ioctl
  procedure Get_Signal_Events
    (Descriptor  : in     File.Valid_Descriptor_t;
     Events      :    out Events_t;
     Error_Value :    out Error.Error_t);
  --# global in Errno.Errno_Value;
  --# derives Events      from Descriptor &
  --#         Error_Value from Descriptor, Errno.Errno_Value;

  -- subprogram_map : ioctl
  procedure Find_Module
    (Descriptor  : in     File.Valid_Descriptor_t;
     Name        : in     String;
     Found       :    out Boolean;
     Error_Value :    out Error.Error_t);
  --# global in Errno.Errno_Value;
  --# derives Found       from Descriptor, Name &
  --#         Error_Value from Descriptor, Name, Errno.Errno_Value;

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

FLUSHR=`./constants FLUSHR`     || exit 1
FLUSHW=`./constants FLUSHW`     || exit 1
FLUSHRW=`./constants FLUSHRW`   || exit 1

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

  subtype Queue_Value_t is C_Types.Int_t
    range C_Types.Int_t'First .. C_Types.Int_t'Last;

  FLUSHR  : constant Queue_Value_t := ${FLUSHR};
  FLUSHW  : constant Queue_Value_t := ${FLUSHW};
  FLUSHRW : constant Queue_Value_t := ${FLUSHRW};

  type Queue_Map_t is array (Queue_Type_t) of Queue_Value_t;

  Queue_Map : constant Queue_Map_t :=
    Queue_Map_t'(Flush_Read_Queues       => FLUSHR,
                 Flush_Write_Queues      => FLUSHW,
                 Flush_Read_Write_Queues => FLUSHRW);

  --
  -- Band info.
  --
  -- FIXME: Generate.
  --

  type Band_Info_t is record
    Priority : Priority_Band_t;
    Queue    : Queue_Value_t;
  end record;
  pragma Convention (C, Band_Info_t);

  --
  -- Set Signal.
  --
EOF
  
S_RDNORM=`./constants S_RDNORM`   || exit 1
S_RDBAND=`./constants S_RDBAND`   || exit 1
S_INPUT=`./constants S_INPUT`     || exit 1
S_HIPRI=`./constants S_HIPRI`     || exit 1
S_OUTPUT=`./constants S_OUTPUT`   || exit 1
S_WRNORM=`./constants S_WRNORM`   || exit 1
S_WRBAND=`./constants S_WRBAND`   || exit 1
S_MSG=`./constants S_MSG`         || exit 1
S_ERROR=`./constants S_ERROR`     || exit 1
S_HANGUP=`./constants S_HANGUP`   || exit 1
S_BANDURG=`./constants S_BANDURG` || exit 1

./type-discrete Event_Value || exit 1

cat <<EOF

  Unsupported_Event : constant Event_Value_t := 16#ffff_ffff#;

  S_RDNORM  : constant Event_Value_t := ${S_RDNORM};
  S_RDBAND  : constant Event_Value_t := ${S_RDBAND};
  S_INPUT   : constant Event_Value_t := ${S_INPUT};
  S_HIPRI   : constant Event_Value_t := ${S_HIPRI};
  S_OUTPUT  : constant Event_Value_t := ${S_OUTPUT};
  S_WRNORM  : constant Event_Value_t := ${S_WRNORM};
  S_WRBAND  : constant Event_Value_t := ${S_WRBAND};
  S_MSG     : constant Event_Value_t := ${S_MSG};
  S_ERROR   : constant Event_Value_t := ${S_ERROR};
  S_HANGUP  : constant Event_Value_t := ${S_HANGUP};
  S_BANDURG : constant Event_Value_t := ${S_BANDURG};

  type Event_Map_t is array (Event_Selector_t) of Event_Value_t;

  Event_Map : constant Event_Map_t :=
    Event_Map_t'(Normal_Message                       => S_RDNORM,
                 Priority_Band_Message                => S_RDBAND,
                 Input_Message                        => S_INPUT,
                 High_Priority_Message                => S_HIPRI,
                 Write_Queue_Space_Available          => S_OUTPUT,
                 Write_Queue_Priority_Space_Available => S_WRNORM,
                 Signal_Message                       => S_MSG,
                 Error_Message                        => S_ERROR,
                 Hangup_Message                       => S_HANGUP,
                 Urgent                               => S_BANDURG);

  --
  -- Return True if all of the selected options are valid on the current platform.
  --

  function Check_Signal_Events (Events : in Events_t) return Boolean;

  --
  -- Convert Events array to event mask.
  --

  function Signal_Event_Mask (Events : in Events_t) return Event_Value_t;

  --
  -- Convert Events array to event mask.
  --

  function Signal_Mask_To_Events (Mask : in Event_Value_t) return Events_t;

end POSIX.IO_Control;
EOF
