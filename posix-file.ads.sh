#!/bin/sh

cat LICENSE || exit 1
cat <<EOF

--
-- Auto generated, do not edit.
--

with POSIX.C_Types;
use type POSIX.C_Types.Int_t;

with POSIX.Error;
use type POSIX.Error.Error_t;
use type POSIX.Error.Return_Value_t;

with POSIX.Errno;
use type POSIX.Errno.Errno_Int_t;

with POSIX.Path;
with POSIX.Permissions;

--# inherit POSIX.C_Types,
--#         POSIX.Errno,
--#         POSIX.Error,
--#         POSIX.Path,
--#         POSIX.Permissions;

package POSIX.File is

EOF

./type-discrete Descriptor || exit 1

cat << EOF

  -- Filename subtype based on POSIX PATH_MAX
  subtype File_Name_Index_t is Positive range Positive'First .. Path.Max_Length;
  subtype File_Name_t is String (File_Name_Index_t);

  type Flags_t is mod 2 ** 32;

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

  procedure Open
    (File_Name    : in String;
     Non_Blocking : in Boolean;
     Mode         : in Permissions.Mode_t;
     Flags        : in Flags_t;
     Descriptor   : out Descriptor_t;
     Error_Value  : out Error.Error_t);
  --# global in Errno.Errno_Value;
  --# derives Descriptor from File_Name, Non_Blocking, Mode, Flags &
  --#         Error_Value from File_Name, Non_Blocking, Mode, Flags, Errno.Errno_Value;
  --# post ((Descriptor >= 0) and (Error_Value = Error.Error_None)) or
  --#      ((Descriptor = -1) and (Error_Value /= Error.Error_None));

  Append     : constant Flags_t;
  Create     : constant Flags_t;
  Exclusive  : constant Flags_t;
  Read_Only  : constant Flags_t;
  Read_Write : constant Flags_t;
  Truncate   : constant Flags_t;
  Write_Only : constant Flags_t;

  procedure Change_Mode
    (File_Name   : in String;
     Mode        : in Permissions.Mode_t;
     Error_Value : out Error.Error_t);
  --# global in Errno.Errno_Value;
  --# derives Error_Value from File_Name, Mode, Errno.Errno_Value;

  procedure Change_Descriptor_Mode
    (Descriptor  : in Descriptor_t;
     Mode        : in Permissions.Mode_t;
     Error_Value : out Error.Error_t);
  --# global in Errno.Errno_Value;
  --# derives Error_Value from Descriptor, Mode, Errno.Errno_Value;
  --# pre Descriptor >= 0;

private

EOF

./posix_file               || exit 1

cat <<EOF

  Append     : constant Flags_t := O_APPEND;
  Create     : constant Flags_t := O_CREAT;
  Exclusive  : constant Flags_t := O_EXCL;
  Read_Only  : constant Flags_t := O_RDONLY;
  Read_Write : constant Flags_t := O_RDONLY or O_WRONLY;
  Truncate   : constant Flags_t := O_TRUNC;
  Write_Only : constant Flags_t := O_WRONLY;

end POSIX.File;
