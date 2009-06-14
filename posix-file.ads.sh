#!/bin/sh

cat LICENSE       || exit 1
cat auto-warn.txt || exit 1
cat <<EOF
with POSIX.C_Types;
use type POSIX.C_Types.Int_t;

with POSIX.Error;
use type POSIX.Error.Error_t;
use type POSIX.Error.Return_Value_t;

with POSIX.Errno;
use type POSIX.Errno.Errno_Integer_t;

with POSIX.Path;
with POSIX.Permissions;

--# inherit POSIX.C_Types,
--#         POSIX.Errno,
--#         POSIX.Error,
--#         POSIX.Path,
--#         POSIX.Permissions;

package POSIX.File is

  -- File descriptor type.
EOF

./type-discrete Descriptor || exit 1

cat << EOF
  subtype Valid_Descriptor_t is Descriptor_t range 0 .. Descriptor_t'Last;

  -- Filename subtype based on POSIX PATH_MAX
  subtype File_Name_Index_t is Positive range Positive'First .. Path.Max_Length;
  subtype File_Name_t is String (File_Name_Index_t);

  --
  -- File opening/creation.
  --

  procedure Open_Read_Only
    (File_Name    : in String;
     Non_Blocking : in Boolean;
     Descriptor   : out Descriptor_t;
     Error_Value  : out Error.Error_t);
  --# global in Errno.Errno_Value;
  --# derives Descriptor from File_Name, Non_Blocking &
  --#         Error_Value from File_Name, Non_Blocking, Errno.Errno_Value;
  --# post ((Descriptor >= 0) and (Error_Value = Error.Error_None)) or
  --#      ((Descriptor = -1) and (Error_Value /= Error.Error_None));

  procedure Open_Write_Only
    (File_Name    : in String;
     Non_Blocking : in Boolean;
     Descriptor   : out Descriptor_t;
     Error_Value  : out Error.Error_t);
  --# global in Errno.Errno_Value;
  --# derives Descriptor from File_Name, Non_Blocking &
  --#         Error_Value from File_Name, Non_Blocking, Errno.Errno_Value;
  --# post ((Descriptor >= 0) and (Error_Value = Error.Error_None)) or
  --#      ((Descriptor = -1) and (Error_Value /= Error.Error_None));

  procedure Open_Exclusive
    (File_Name    : in String;
     Non_Blocking : in Boolean;
     Mode         : in Permissions.Mode_t;
     Descriptor   : out Descriptor_t;
     Error_Value  : out Error.Error_t);
  --# global in Errno.Errno_Value;
  --# derives Descriptor from File_Name, Non_Blocking, Mode &
  --#         Error_Value from File_Name, Non_Blocking, Mode, Errno.Errno_Value;
  --# post ((Descriptor >= 0) and (Error_Value = Error.Error_None)) or
  --#      ((Descriptor = -1) and (Error_Value /= Error.Error_None));

  procedure Open_Append
    (File_Name    : in String;
     Non_Blocking : in Boolean;
     Descriptor   : out Descriptor_t;
     Error_Value  : out Error.Error_t);
  --# global in Errno.Errno_Value;
  --# derives Descriptor from File_Name, Non_Blocking &
  --#         Error_Value from File_Name, Non_Blocking, Errno.Errno_Value;
  --# post ((Descriptor >= 0) and (Error_Value = Error.Error_None)) or
  --#      ((Descriptor = -1) and (Error_Value /= Error.Error_None));

  procedure Open_Truncate
    (File_Name    : in String;
     Non_Blocking : in Boolean;
     Mode         : in Permissions.Mode_t;
     Descriptor   : out Descriptor_t;
     Error_Value  : out Error.Error_t);
  --# global in Errno.Errno_Value;
  --# derives Descriptor from File_Name, Non_Blocking, Mode &
  --#         Error_Value from File_Name, Non_Blocking, Mode, Errno.Errno_Value;
  --# post ((Descriptor >= 0) and (Error_Value = Error.Error_None)) or
  --#      ((Descriptor = -1) and (Error_Value /= Error.Error_None));

  procedure Open_Read_Write
    (File_Name    : in String;
     Non_Blocking : in Boolean;
     Descriptor   : out Descriptor_t;
     Error_Value  : out Error.Error_t);
  --# global in Errno.Errno_Value;
  --# derives Descriptor from File_Name, Non_Blocking &
  --#         Error_Value from File_Name, Non_Blocking, Errno.Errno_Value;
  --# post ((Descriptor >= 0) and (Error_Value = Error.Error_None)) or
  --#      ((Descriptor = -1) and (Error_Value /= Error.Error_None));

  procedure Open_Create
    (File_Name    : in String;
     Non_Blocking : in Boolean;
     Mode         : in Permissions.Mode_t;
     Descriptor   : out Descriptor_t;
     Error_Value  : out Error.Error_t);
  --# global in Errno.Errno_Value;
  --# derives Descriptor from File_Name, Non_Blocking, Mode &
  --#         Error_Value from File_Name, Non_Blocking, Mode, Errno.Errno_Value;
  --# post ((Descriptor >= 0) and (Error_Value = Error.Error_None)) or
  --#      ((Descriptor = -1) and (Error_Value /= Error.Error_None));

EOF

./type-discrete Open_Flags || exit 1

cat <<EOF

  Append     : constant Open_Flags_t;
  Create     : constant Open_Flags_t;
  Exclusive  : constant Open_Flags_t;
  Read_Only  : constant Open_Flags_t;
  Read_Write : constant Open_Flags_t;
  Truncate   : constant Open_Flags_t;
  Write_Only : constant Open_Flags_t;

  -- proc_map : open
  procedure Open
    (File_Name    : in String;
     Non_Blocking : in Boolean;
     Mode         : in Permissions.Mode_t;
     Flags        : in Open_Flags_t;
     Descriptor   : out Descriptor_t;
     Error_Value  : out Error.Error_t);
  --# global in Errno.Errno_Value;
  --# derives Descriptor from File_Name, Non_Blocking, Mode, Flags &
  --#         Error_Value from File_Name, Non_Blocking, Mode, Flags, Errno.Errno_Value;
  --# post ((Descriptor >= 0) and (Error_Value = Error.Error_None)) or
  --#      ((Descriptor = -1) and (Error_Value /= Error.Error_None));

  --
  -- File permissions.
  --

  -- proc_map : chmod
  procedure Change_Mode
    (File_Name   : in String;
     Mode        : in Permissions.Mode_t;
     Error_Value : out Error.Error_t);
  --# global in Errno.Errno_Value;
  --# derives Error_Value from File_Name, Mode, Errno.Errno_Value;

  -- proc_map : fchmod
  procedure Change_Descriptor_Mode
    (Descriptor  : in Valid_Descriptor_t;
     Mode        : in Permissions.Mode_t;
     Error_Value : out Error.Error_t);
  --# global in Errno.Errno_Value;
  --# derives Error_Value from Descriptor, Mode, Errno.Errno_Value;

  --
  -- File removal.
  --

  -- proc_map : unlink
  procedure Unlink
    (File_Name   : in String;
     Error_Value : out Error.Error_t);
  --# global in Errno.Errno_Value;
  --# derives Error_Value from File_Name, Errno.Errno_Value;

  --
  -- File closing.
  --

  -- proc_map : close
  procedure Close
    (Descriptor  : in Valid_Descriptor_t;
     Error_Value : out Error.Error_t);
  --# global in Errno.Errno_Value;
  --# derives Error_Value from Descriptor, Errno.Errno_Value;

private

EOF

./posix_file || exit 1

cat <<EOF

  Append     : constant Open_Flags_t := O_APPEND;
  Create     : constant Open_Flags_t := O_CREAT;
  Exclusive  : constant Open_Flags_t := O_EXCL;
  Read_Only  : constant Open_Flags_t := O_RDONLY;
  Read_Write : constant Open_Flags_t := O_RDONLY or O_WRONLY;
  Truncate   : constant Open_Flags_t := O_TRUNC;
  Write_Only : constant Open_Flags_t := O_WRONLY;

end POSIX.File;
